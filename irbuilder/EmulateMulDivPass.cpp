#include "llvm/ADT/SmallVector.h"
#include "llvm/IR/Attributes.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/InstVisitor.h"
#include "llvm/IR/InstrTypes.h"
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

// build function mimicing _Z8multiplyjj from divide_impl.ll
Function *buildDivideImpl(Module &M, int BitWidth) {
  auto &Ctx = M.getContext();
  std::string Name = std::string{UDivIntrinsicName} + std::to_string(BitWidth);
  if (auto EmulatedUDiv = M.getFunction(Name))
    return EmulatedUDiv;

  auto Int = IntegerType::get(Ctx, BitWidth);
  auto Int64 = IntegerType::get(Ctx, 64);

  // TODO: Implement me!
  // See divide_impl.ll for the IR you want to replicate.
  // Also see buildMultiplyImpl below for some inspiration.
  // res/div.cpp contains the C++ impl of both the divide and multiply
  // emulation.
  return nullptr;
}

// build function mimicing _Z8multiplyjj from multiply.ll
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

// struct MulDivVisitor : public InstVisitor<MulDivVisitor> {
//   SmallVector<Instruction *> &MulWL;
//
//   MulDivVisitor(SmallVector<Instruction *> &MulWL) : MulWL(MulWL) {}
//
//   void visitMul(BinaryOperator &Mul) { MulWL.push_back(&Mul); }
// };

bool runEmulateMulDiv(Function &F, LoopInfo &LI) {
  SmallVector<Instruction *> MulWL;

  // Iterate over all insts in function with instructions range
  for (auto &I : instructions(F)) {
    // Or using manual basic block and instruction iteration
    //  for (auto &BB : F)
    //    for (auto &I : BB) {
    if (isa<MulOperator>(I))
      MulWL.push_back(&I);
  }

  // Or use the instruction visitor:
  // MulDivVisitor Visitor{MulWL};
  // Visitor.visit(F);

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

  // TODO: Handle UDivOperator!

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
  return {LLVM_PLUGIN_API_VERSION, "EmulateMulDiv", LLVM_VERSION_STRING,
          [](PassBuilder &PB) {
            PB.registerVectorizerStartEPCallback(
                [](llvm::FunctionPassManager &PM, OptimizationLevel Level) {
                  PM.addPass(EmulateMulDiv());
                });
            PB.registerPipelineParsingCallback(
                [](StringRef Name, llvm::FunctionPassManager &PM,
                   ArrayRef<llvm::PassBuilder::PipelineElement>) {
                  if (Name == "emulate-muldiv") {
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
