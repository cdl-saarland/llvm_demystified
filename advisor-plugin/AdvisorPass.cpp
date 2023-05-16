#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Analysis/OptimizationRemarkEmitter.h"
#include "llvm/IR/Function.h"
#include "llvm/Pass.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"

using namespace llvm;

namespace {

bool runAdvisor(Function& F, LoopInfo& LI, OptimizationRemarkEmitter& ORE)
{
  static std::set<std::string> ExpensiveFuncs { "__divdc3", "__muldc3", "sin", "cos" };

  if (F.isDeclaration())
    return false;

  for (auto& BB : F) {
    auto* L = LI.getLoopFor(&BB);
    if (!L)
      continue;

    for (auto& I : BB) {
      auto* Call = dyn_cast<CallInst>(&I);
      if (!Call)
        continue;
      if (!Call->getType()->isStructTy())
        continue;
      auto* Callee = Call->getCalledFunction();
      if (!Callee)
        continue;

      errs() << Callee->getName() << "\n";
      if (!ExpensiveFuncs.count(Callee->getName().str()))
        continue;
      errs() << "\tActually expensive!\n";

      OptimizationRemark Remark("advisor", "nestedExpensiveFunc", Call);
      ORE.emit(Remark << "Calling expensive function " << Callee->getName() << " inside loop!\n");
      // errs() << Nesting << *Call << "\n";
    }
  }

  // errs().write_escaped(F.getName()) << '\n';
  return false;
}

struct Advisor : PassInfoMixin<Advisor> {
  PreservedAnalyses run(Function& F, FunctionAnalysisManager& FAM)
  {
    auto& LI = FAM.getResult<LoopAnalysis>(F);
    auto& ORE = FAM.getResult<OptimizationRemarkEmitterAnalysis>(F);

    if (!runAdvisor(F, LI, ORE))
      return PreservedAnalyses::all();
    return PreservedAnalyses::none();
  }
};

} // namespace

llvm::PassPluginLibraryInfo getAdvisorPluginInfo()
{
  return { LLVM_PLUGIN_API_VERSION, "Advisor", LLVM_VERSION_STRING,
    [](PassBuilder& PB) {
      PB.registerVectorizerStartEPCallback(
          [](llvm::FunctionPassManager& PM, OptimizationLevel Level) {
            PM.addPass(Advisor());
          });
      PB.registerPipelineParsingCallback(
          [](StringRef Name, llvm::FunctionPassManager& PM,
              ArrayRef<llvm::PassBuilder::PipelineElement>) {
            if (Name == "advisor") {
              PM.addPass(Advisor());
              return true;
            }
            return false;
          });
    } };
}

#ifndef LLVM_BYE_LINK_INTO_TOOLS
extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo()
{
  return getAdvisorPluginInfo();
}
#endif
