#ifndef ONR_STAGE3_FSMEXTRACTOR_H
#define ONR_STAGE3_FSMEXTRACTOR_H

#include <fstream>

#include "llvm/Pass.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/GlobalVariable.h"


using namespace llvm;
using namespace std;


class StructFieldInfo {

public:
    StructType *Stype;
    int FieldOffset;
    Type *FieldType;

    bool operator<(const StructFieldInfo &other) const { return Stype < other.Stype; }
};


class StateBase {

public:
    StoreInst *storeInst;
    int value;
};


class ConditionBase {

public:
    LoadInst *loadInst;
    int predicate; // ICMP_EQ, ICMP_NE.....
    string direction; // true or false
    int value;
};


class PoState {

public:
    StateBase *stateBase;
    vector<ConditionBase *> condVec;
    bool isEqual;
};


struct FSMExtractor : public ModulePass {
    static char ID;

    FSMExtractor();

    virtual void getAnalysisUsage(AnalysisUsage &AU) const;

    virtual bool runOnModule(Module &M);

    bool isFSMLoop(Loop *pLoop);

    void collectStoreAndStore(Loop *pLoop);

    bool fieldTypeFilter(Type *fieldType);

    bool findAPath(BasicBlock *A, BasicBlock *B, set<BasicBlock *> pLoopBBSet, BasicBlock *pLoopHeader);

    void printPoState(vector<PoState *> poStateVec);

    /* Va if from LoadInst or StoreInst */
    StructFieldInfo *getStructFieldInfo(Value *Va);

    ofstream outPutFile;

};


#endif //ONR_STAGE3_FSMEXTRACTOR_H
