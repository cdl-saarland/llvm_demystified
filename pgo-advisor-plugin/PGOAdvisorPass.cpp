#include "llvm/Analysis/BranchProbabilityInfo.h"
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

struct PGOAdvisor : PassInfoMixin<PGOAdvisor> {
  PreservedAnalyses run(Function& F, FunctionAnalysisManager& FAM)
  {
    auto& BPI = FAM.getResult<BranchProbabilityAnalysis>(F);
    errs() << "Function ";
    errs().write_escaped(F.getName()) << ":\n";
    BPI.print(errs());
    errs() << "\n";
    return PreservedAnalyses::all();
  }
};

} // namespace

llvm::PassPluginLibraryInfo getPGOAdvisorPluginInfo()
{
  return { LLVM_PLUGIN_API_VERSION, "PGOAdvisor", LLVM_VERSION_STRING,
    [](PassBuilder& PB) {
      PB.registerVectorizerStartEPCallback(
          [](llvm::FunctionPassManager& PM, OptimizationLevel Level) {
            PM.addPass(PGOAdvisor());
          });
      PB.registerPipelineParsingCallback(
          [](StringRef Name, llvm::FunctionPassManager& PM,
              ArrayRef<llvm::PassBuilder::PipelineElement>) {
            if (Name == "pgo-advisor") {
              PM.addPass(PGOAdvisor());
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
  return getPGOAdvisorPluginInfo();
}
#endif
