#ifndef ONR_STAGE3_FSMEXTRACTOR_H
#define ONR_STAGE3_FSMEXTRACTOR_H

#include "llvm/Pass.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/GlobalVariable.h"


using namespace llvm;

struct FSMExtractor : public ModulePass {
    static char ID;

    FSMExtractor();

    virtual void getAnalysisUsage(AnalysisUsage &AU) const;
    virtual bool runOnModule(Module &M);


    bool isFSMLoop(Loop* pLoop);

};


#endif //ONR_STAGE3_FSMEXTRACTOR_H
