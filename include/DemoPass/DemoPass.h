#ifndef ONR_STAGE3_DEMOPASS_H
#define ONR_STAGE3_DEMOPASS_H

#include "llvm/Pass.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/GlobalVariable.h"


using namespace llvm;

struct DemoPass : public ModulePass {
    static char ID;

    DemoPass();

    virtual void getAnalysisUsage(AnalysisUsage &AU) const;
    virtual bool runOnModule(Module &M);

    //type
    IntegerType *LongType;
    Type *VoidType;

    //function
    Function *Print;

    //global
    GlobalVariable *numCost;

    //constant
    ConstantInt *ConstantLong0;
    ConstantInt *ConstantLong1;
};


#endif //ONR_STAGE3_DEMOPASS_H
