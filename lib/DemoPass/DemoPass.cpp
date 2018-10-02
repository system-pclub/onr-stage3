#include "llvm/Analysis/LoopInfo.h"

#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/DebugInfo.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/InstrTypes.h"
#include "llvm/IR/Module.h"
#include "llvm/Support/raw_ostream.h"


#include "DemoPass/DemoPass.h"

using namespace std;


static RegisterPass <DemoPass> X(
        "dump-function",
        "print function all instructions", true, true);

static cl::opt<std::string> strFunctionName(
        "strFunctionName",
        cl::desc("The name of function to print"),
        cl::value_desc("strFunctionName"));

char DemoPass::ID = 0;


void DemoPass::getAnalysisUsage(AnalysisUsage &AU) const {
    AU.setPreservesAll();
    AU.addRequired<LoopInfoWrapperPass>();
}

DemoPass::DemoPass() : ModulePass(ID) {
    PassRegistry &Registry = *PassRegistry::getPassRegistry();
    initializeLoopInfoWrapperPassPass(Registry);
}

bool DemoPass::runOnModule(Module & M)
{

    if (strFunctionName.empty()) {
       strFunctionName = "main";
    }

    // get main function and dump it
    Function * pFunc = M.getFunction(strFunctionName);
    assert(pFunc != NULL);

    // find the loop in this function
    LoopInfo &LoopInfo = getAnalysis<LoopInfoWrapperPass>(*pFunc).getLoopInfo();

    if (LoopInfo.empty()) {
        errs() << "There is no loop in function " << strFunctionName << "\n";
        return false;
    }

    for (auto &loop:LoopInfo) {
        loop->dump();
    }

    return false;
}
