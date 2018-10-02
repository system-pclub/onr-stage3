#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/InstrTypes.h"
#include "llvm/IR/Module.h"

#include "DemoPass/DemoPass.h"

using namespace std;


static RegisterPass <DemoPass> X(
        "print-main",
        "print main function all instructions", true, true);

char DemoPass::ID = 0;


void DemoPass::getAnalysisUsage(AnalysisUsage &AU) const {

}

DemoPass::DemoPass() : ModulePass(ID) {

}

bool DemoPass::runOnModule(Module & M)
{
    // get main function and dump it
    Function * pMain = M.getFunction("main");
    assert(pMain != NULL);

    pMain->dump();

    return false;
}
