#ifndef ONR_STAGE3_FSMEXTRACTOR_H
#define ONR_STAGE3_FSMEXTRACTOR_H

#include "llvm/Pass.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/GlobalVariable.h"


using namespace llvm;


class StructFieldInfo {

public:
    StructType *Stype;
    int FieldOffset;
    Type *FieldType;

    bool operator<(const StructFieldInfo &other) const { return Stype < other.Stype; }
};

struct FSMExtractor : public ModulePass {
    static char ID;

    FSMExtractor();

    virtual void getAnalysisUsage(AnalysisUsage &AU) const;

    virtual bool runOnModule(Module &M);

    bool isFSMLoop(Loop *pLoop);

    void collectStoreAndStore(Loop *pLoop);

    bool fieldTypeFilter(Type *fieldType);

    /* Va if from LoadInst or StoreInst */
    StructFieldInfo* getStructFieldInfo(Value *Va);

};


#endif //ONR_STAGE3_FSMEXTRACTOR_H
