#include "llvm/ADT/SmallVector.h"
#include "llvm/IR/Attributes.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/InstVisitor.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/IR/Operator.h"
#include "llvm/IR/Verifier.h"
#include "llvm/Pass.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"

// Required for llvm::instructions(Function&) iterator.
#include "llvm/IR/InstIterator.h"

#include <string>

using namespace llvm;

namespace {

static constexpr const char *UDivIntrinsicName = "__emulated_udiv.i";
static constexpr const char *MulIntrinsicName = "__emulated_mul.i";

Function *buildDivideImpl(Module &M, int BitWidth) {
  auto &Ctx = M.getContext();
  std::string Name = std::string{UDivIntrinsicName} + std::to_string(BitWidth);
  if (auto EmulatedUDiv = M.getFunction(Name))
    return EmulatedUDiv;

  auto Int = IntegerType::get(Ctx, BitWidth);
  auto Int64 = IntegerType::get(Ctx, 64);

  auto EmulatedUDiv =
      Function::Create(FunctionType::get(Int, {Int, Int}, false),
                       llvm::GlobalValue::InternalLinkage, Name, &M);
  EmulatedUDiv->addFnAttr(Attribute::get(Ctx, Attribute::NoInline));

  auto N = EmulatedUDiv->getArg(0);
  auto D = EmulatedUDiv->getArg(1);

  auto EntryBB = BasicBlock::Create(Ctx, "entry", EmulatedUDiv);
  auto LoopPreHeader = BasicBlock::Create(Ctx, "loop.ph", EmulatedUDiv);
  auto LoopBody = BasicBlock::Create(Ctx, "loop.body", EmulatedUDiv);
  auto LoopExit = BasicBlock::Create(Ctx, "loop.exit", EmulatedUDiv);

  IRBuilder<> Builder{EntryBB};

  // Fill Entry BB
  auto DCtlz =
      Builder.CreateIntrinsic(Intrinsic::ctlz, {Int}, {D, Builder.getFalse()});
  auto NCtlz =
      Builder.CreateIntrinsic(Intrinsic::ctlz, {Int}, {N, Builder.getFalse()});
  auto DCtlzSubNCtlz = Builder.CreateNSWSub(DCtlz, NCtlz);
  auto DCtlzSubNCtlzCmp0 =
      Builder.CreateICmpEQ(DCtlzSubNCtlz, Builder.getIntN(BitWidth, 0));
  Builder.CreateCondBr(DCtlzSubNCtlzCmp0, LoopExit, LoopPreHeader);

  // Fill Loop Pre Header
  Builder.SetInsertPoint(LoopPreHeader);
  auto BitsToCount = Builder.CreateSub(Builder.getIntN(BitWidth, BitWidth),
                                       NCtlz, {}, true, true);
  auto IterCount = Builder.CreateIntrinsic(
      Intrinsic::smax, {Int}, {BitsToCount, Builder.getIntN(BitWidth, 1)});
  auto DAligned64 =
      Builder.CreateZExt(Builder.CreateShl(D, DCtlzSubNCtlz), Int64);
  Builder.CreateBr(LoopBody);

  // Fill Loop Body
  Builder.SetInsertPoint(LoopBody);
  auto NPhi = Builder.CreatePHI(Int, 2);
  NPhi->addIncoming(N, LoopPreHeader);
  auto IPhi = Builder.CreatePHI(Int, 2);
  IPhi->addIncoming(Builder.getIntN(BitWidth, 0), LoopPreHeader);
  auto QPhi = Builder.CreatePHI(Int, 2);
  QPhi->addIncoming(Builder.getIntN(BitWidth, 0), LoopPreHeader);
  auto N64 = Builder.CreateZExt(NPhi, Int64);
  auto NDSub64 = Builder.CreateNSWSub(N64, DAligned64);
  auto NgtD = Builder.CreateICmpSGE(NDSub64, Builder.getInt64(0));
  auto NewBit = Builder.CreateZExt(NgtD, Int);
  auto NewQ = Builder.CreateShl(Builder.CreateOr(QPhi, NewBit),
                                Builder.getIntN(BitWidth, 1));
  auto NDSub = Builder.CreateTrunc(NDSub64, Int);
  auto NewN = Builder.CreateShl(Builder.CreateSelect(NgtD, NDSub, NPhi),
                                Builder.getIntN(BitWidth, 1));
  auto Inc =
      Builder.CreateAdd(IPhi, Builder.getIntN(BitWidth, 1), {}, true, true);
  auto ExitCond = Builder.CreateICmpEQ(Inc, IterCount);
  Builder.CreateCondBr(ExitCond, LoopExit, LoopBody);

  NPhi->addIncoming(NewN, LoopBody);
  IPhi->addIncoming(Inc, LoopBody);
  QPhi->addIncoming(NewQ, LoopBody);

  // Fill Loop Exit
  Builder.SetInsertPoint(LoopExit);
  auto FinalQPhi = Builder.CreatePHI(Int, 2);
  FinalQPhi->addIncoming(Builder.getIntN(BitWidth, 0), EntryBB);
  FinalQPhi->addIncoming(NewQ, LoopBody);
  // we're unsigned -> LShr
  auto FinalQ = Builder.CreateLShr(FinalQPhi, DCtlzSubNCtlz);
  Builder.CreateRet(FinalQ);

  assert(!verifyFunction(*EmulatedUDiv, &errs()));

  return EmulatedUDiv;
}

Function *buildMultiplyImpl(Module &M, int BitWidth) {
  auto &Ctx = M.getContext();
  std::string Name = std::string{MulIntrinsicName} + std::to_string(BitWidth);
  if (auto EmulatedMul = M.getFunction(Name))
    return EmulatedMul;

  auto Int = IntegerType::get(Ctx, BitWidth);

  auto EmulatedMul =
      Function::Create(FunctionType::get(Int, {Int, Int}, false),
                       llvm::GlobalValue::InternalLinkage, Name, &M);
  EmulatedMul->addFnAttr(Attribute::get(Ctx, Attribute::NoInline));
  EmulatedMul->addFnAttr(Attribute::get(Ctx, Attribute::OptimizeNone));

  auto A = EmulatedMul->getArg(0);
  auto B = EmulatedMul->getArg(1);

  auto LoopPreHeader = BasicBlock::Create(Ctx, "entry", EmulatedMul);
  auto LoopCond = BasicBlock::Create(Ctx, "for.cond", EmulatedMul);
  auto LoopBody = BasicBlock::Create(Ctx, "for.body", EmulatedMul);
  auto LoopExit = BasicBlock::Create(Ctx, "for.exit", EmulatedMul);

  IRBuilder<> Builder{LoopPreHeader};

  // Fill Entry BB
  Builder.CreateBr(LoopCond);

  // Fill Loop Pre Header
  Builder.SetInsertPoint(LoopCond);
  auto AccPhi = Builder.CreatePHI(Int, 2);
  AccPhi->addIncoming(Builder.getIntN(BitWidth, 0), LoopPreHeader);
  auto IPhi = Builder.CreatePHI(Int, 2);
  IPhi->addIncoming(Builder.getIntN(BitWidth, 0), LoopPreHeader);
  auto Cmp = Builder.CreateICmpULT(IPhi, B);
  Builder.CreateCondBr(Cmp, LoopBody, LoopExit);

  // Fill Loop Body
  Builder.SetInsertPoint(LoopBody);
  auto NewAcc = Builder.CreateAdd(AccPhi, A);
  auto Inc = Builder.CreateNSWAdd(IPhi, Builder.getIntN(BitWidth, 1));
  Builder.CreateBr(LoopCond);

  AccPhi->addIncoming(NewAcc, LoopBody);
  IPhi->addIncoming(Inc, LoopBody);

  // Fill Loop Exit
  Builder.SetInsertPoint(LoopExit);
  Builder.CreateRet(AccPhi);

  assert(!verifyFunction(*EmulatedMul, &errs()));

  return EmulatedMul;
}

struct MulDivVisitor : public InstVisitor<MulDivVisitor> {
  SmallVector<Instruction *> &MulWL;
  SmallVector<Instruction *> &UDivWL;

  MulDivVisitor(SmallVector<Instruction *> &MulWL,
                SmallVector<Instruction *> &UDivWL)
      : MulWL(MulWL), UDivWL(UDivWL) {}

  void visitMul(BinaryOperator &Mul) { MulWL.push_back(&Mul); }
  void visitUDiv(BinaryOperator &UDiv) { UDivWL.push_back(&UDiv); }
};

bool runEmulateMulDiv(Function &F, LoopInfo &LI) {
  SmallVector<Instruction *> UDivWL;
  SmallVector<Instruction *> MulWL;

  // Iterate over all insts in function with instructions range
  for (auto &I : instructions(F)) {
    // Or using manual basic block and instruction iteration
    //  for (auto &BB : F)
    //    for (auto &I : BB) {
    if (isa<UDivOperator>(I))
      UDivWL.push_back(&I);
    if (isa<MulOperator>(I))
      MulWL.push_back(&I);
  }

  // Or use the instruction visitor:
  // MulDivVisitor Visitor{MulWL, UDivWL};
  // Visitor.visit(F);

  for (auto *DivI : UDivWL) {
    auto DivideImpl =
        buildDivideImpl(*F.getParent(), DivI->getType()->getIntegerBitWidth());

    IRBuilder<> builder{DivI};
    auto EmulatedDiv = builder.CreateCall(
        DivideImpl, {DivI->getOperand(0), DivI->getOperand(1)}, "emulated_div");
    errs() << "replace " << *DivI << " with " << *EmulatedDiv << "\n";
    DivI->replaceAllUsesWith(EmulatedDiv);
    DivI->eraseFromParent();
  }
  for (auto *MulI : MulWL) {
    auto MultiplyImpl = buildMultiplyImpl(
        *F.getParent(), MulI->getType()->getIntegerBitWidth());

    IRBuilder<> builder{MulI};
    auto EmulatedMul = builder.CreateCall(
        MultiplyImpl, {MulI->getOperand(0), MulI->getOperand(1)},
        "emulated_mul");
    errs() << "replace " << *MulI << " with " << *EmulatedMul << "\n";
    MulI->replaceAllUsesWith(EmulatedMul);
    MulI->eraseFromParent();
  }

  return false;
}

struct EmulateMulDiv : PassInfoMixin<EmulateMulDiv> {
  PreservedAnalyses run(Function &F, FunctionAnalysisManager &FAM) {
    auto &LI = FAM.getResult<LoopAnalysis>(F);

    if (!runEmulateMulDiv(F, LI))
      return PreservedAnalyses::all();
    return PreservedAnalyses::none();
  }
};

} // namespace

llvm::PassPluginLibraryInfo getEmulateMulDivPluginInfo() {
  return {LLVM_PLUGIN_API_VERSION, "EmulateMulDivSolution", LLVM_VERSION_STRING,
          [](PassBuilder &PB) {
            PB.registerVectorizerStartEPCallback(
                [](llvm::FunctionPassManager &PM, OptimizationLevel Level) {
                  PM.addPass(EmulateMulDiv());
                });
            PB.registerPipelineParsingCallback(
                [](StringRef Name, llvm::FunctionPassManager &PM,
                   ArrayRef<llvm::PassBuilder::PipelineElement>) {
                  if (Name == "emulate-muldiv-solution") {
                    PM.addPass(EmulateMulDiv());
                    return true;
                  }
                  return false;
                });
          }};
}

extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return getEmulateMulDivPluginInfo();
}
