#include <vector>
#include <map>

#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Analysis/PostDominators.h"

#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/DebugInfo.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/InstrTypes.h"
#include "llvm/IR/Module.h"
#include "llvm/Support/raw_ostream.h"


#include "CFG/CFG.h"
#include "FSMExtractor/FSMExtractor.h"

using namespace std;
using namespace llvm;


static RegisterPass<FSMExtractor> X(
        "fsm-extract",
        "extract FSM", true, true);

static cl::opt<std::string> strFunctionName(
        "strFunctionName",
        cl::desc("The name of function to print"),
        cl::value_desc("strFunctionName"));

char FSMExtractor::ID = 0;

bool FSMExtractor::fieldTypeFilter(Type *fieldType) {

    if (fieldType->isIntegerTy()) {
        // state var is integer and is int32;
        if (fieldType->getIntegerBitWidth() <= 32) {
            return true;
        }
    }
    return false;
}

std::string printSrcCodeInfo(Instruction *pInst) {
    const DILocation *DIL = pInst->getDebugLoc();

    if (!DIL)
        return "NULL";

    char pPath[400];

    std::string sFileName = DIL->getDirectory().str() + "/" + DIL->getFilename().str();
    realpath(sFileName.c_str(), pPath);
    sFileName = std::string(sFileName);
    unsigned int numLine = DIL->getLine();
//    return sFileName + ": " + std::to_string(numLine);
    return "ssl.c: " + std::to_string(numLine);
}


std::string icmpString(int cmp_token) {

    switch (cmp_token) {
        case ICmpInst::ICMP_EQ: {
            return "EQUAL";
        }

        case ICmpInst::ICMP_NE: {
            return "ICMP_NE";
        }

        case ICmpInst::ICMP_UGT: {
            return "ICMP_UGE";
        }

        case ICmpInst::ICMP_UGE: {
            return "ICMP_UGE";
        }

        case ICmpInst::ICMP_ULT: {
            return "ICMP_ULT";
        }

        case ICmpInst::ICMP_ULE: {
            return "ICMP_ULE";
        }

        case ICmpInst::ICMP_SGT: {
            return "ICMP_SGT";
        }

        case ICmpInst::ICMP_SGE: {
            return "ICMP_SGE";
        }

        case ICmpInst::ICMP_SLT: {
            return "SMALLER THAN";
        }

        case ICmpInst::ICMP_SLE: {
            return "ICMP_SLE";
        }

        default:
            return "";
    }
}

void printPoState(vector<PoState *> poStateVec) {

    errs() << "========================================= \n";

    // filter not equal

    for (auto it=poStateVec.begin(); it != poStateVec.end(); ++it) {

        PoState *curState = *it;

        for (auto ho = curState->condVec.begin(); ho != curState->condVec.end(); ++ho) {
            ConditionBase *conBase = *ho;

            if (conBase->predicate == ICmpInst::ICMP_EQ) {
                curState->isEqual = true;
            }
        }

    }

    for (auto it=poStateVec.begin(); it != poStateVec.end(); ++it) {

        PoState *curState = *it;
        errs() << "Store State Value: " << curState->stateBase->value << "\n";

        set<int> printValues;

        for (auto ho = curState->condVec.begin(); ho != curState->condVec.end(); ++ho) {

            ConditionBase *conBase = *ho;

            if (curState->isEqual && conBase->predicate != ICmpInst::ICMP_EQ) {
                continue;
            }

            if (find(printValues.begin(), printValues.end(), conBase->value) != printValues.end()) {
                continue;

            } else {
                printValues.insert(conBase->value);
            }

            if (conBase->direction == "Not")
                errs() << conBase->direction + " " + icmpString(conBase->predicate) <<
                       " " << to_string(conBase->value) << "\n";
            else
                errs() << icmpString(conBase->predicate) <<
                       " " << to_string(conBase->value) << "\n";
        }
        errs() << "========================================= \n";
    }

}

StructFieldInfo *FSMExtractor::getStructFieldInfo(Value *Va) {

    StructFieldInfo *SSI = new StructFieldInfo;

    vector<Value *> workList;
    if (Va != NULL) {
        workList.push_back(Va);
    }

    Type *type = NULL;
    int offset = 0;

    while (workList.size() != 0) {

        Value *va = workList.back();
        workList.pop_back();

        if (User *usr = dyn_cast<User>(va)) {

            if (Instruction *inst = dyn_cast<Instruction>(usr)) {

                if (GetElementPtrInst *GI = dyn_cast<GetElementPtrInst>(inst)) {
                    type = GI->getSourceElementType();
                    Value *subVa = GI->getPointerOperand();

                    if (GI->getNumOperands() == 3) {
                        Value *offsetValue = GI->getOperand(2);
                        if (llvm::ConstantInt *CI = dyn_cast<llvm::ConstantInt>(offsetValue)) {
                            // foo indeed is a ConstantInt, we can use CI here
                            offset = CI->getSExtValue();
                        }
                    }
                    workList.push_back(subVa);

                } else if (BitCastInst *BI = dyn_cast<BitCastInst>(inst)) {
                    Value *subVa = BI->getOperand(0);
                    workList.push_back(subVa);

                } else {
                    break;
                }
            }
        }
    }

    // check the type whether it is a struct type, if yes, then store it
    if (type != NULL && type->isStructTy()) {

        StructType *stype = dyn_cast<StructType>(type);

        if (stype) {
            SSI->Stype = stype;
            SSI->FieldOffset = offset;
            return SSI;
        }
    }

    return NULL;
}

bool FSMExtractor::findAPath(BasicBlock *A, BasicBlock *B, set<BasicBlock *> pLoopBBSet, BasicBlock *pLoopHeader) {

    set<BasicBlock *> visitedBB;
    vector<BasicBlock *> vecBB;

    for (BasicBlock *AS: A->getTerminator()->successors()) {

        if (find(pLoopBBSet.begin(), pLoopBBSet.end(), AS) == pLoopBBSet.end()) {
            continue;
        }

        if (AS == pLoopHeader) {
            continue;
        }

        if (AS == B)
            return true;

        vecBB.push_back(AS);
        visitedBB.insert(AS);
    }


    while (!vecBB.empty()) {

        BasicBlock *BB = vecBB.back();
        vecBB.pop_back();

        for (BasicBlock *BBS: BB->getTerminator()->successors()) {

            if (find(visitedBB.begin(), visitedBB.end(), BBS) != visitedBB.end()) {
                continue;
            }

            if (find(pLoopBBSet.begin(), pLoopBBSet.end(), BBS) == pLoopBBSet.end()) {
                continue;
            }

            if (BBS == pLoopHeader) {
                continue;
            }

            if (BBS == B)
                return true;

            vecBB.push_back(BBS);
            visitedBB.insert(BBS);
        }
    }

    return false;
}

void FSMExtractor::collectStoreAndStore(Loop *pLoop) {

    std::vector<StructFieldInfo *> structFieldStoreSet;
    std::vector<StructFieldInfo *> structFieldLoadSet;
    std::map<StructFieldInfo *, StoreInst *> storeFieldMap;
    std::map<StructFieldInfo *, LoadInst *> loadFieldMap;
    std::map<StoreInst *, vector<LoadInst *>> loadStorePairMap;
    std::set<BasicBlock *> pLoopBBSet;
    BasicBlock *loopHeader = pLoop->getHeader();

    for (BasicBlock *BB: pLoop->getBlocks()) {

        pLoopBBSet.insert(BB);

        for (BasicBlock::iterator II = BB->begin(); II != BB->end(); ++II) {

            Instruction *Inst = &*II;

            if (StoreInst *storeInst = dyn_cast<StoreInst>(Inst)) {

                // if this instruction is related to a struct field
                Value *Pva = storeInst->getPointerOperand();
                Type *fieldType = storeInst->getValueOperand()->getType();
                StructFieldInfo *SSI = getStructFieldInfo(Pva);
                if (SSI != NULL) {
                    SSI->FieldType = fieldType;
                    structFieldStoreSet.push_back(SSI);
                    storeFieldMap[SSI] = storeInst;
                }

            } else if (LoadInst *loadInst = dyn_cast<LoadInst>(Inst)) {

                // if this instruction is related to a struct field
                Value *Pva = loadInst->getPointerOperand();
                Type *fieldType = loadInst->getType();
                StructFieldInfo *SSI = getStructFieldInfo(Pva);
                if (SSI != NULL) {
                    SSI->FieldType = fieldType;
                    structFieldLoadSet.push_back(SSI);
                    loadFieldMap[SSI] = loadInst;
                }
            }
        }
    }

    Function *F = loopHeader->getParent();
    // TODO: After this operation, the loop obj is broken. May be this is a bug in llvm.
    ControlDependenceGraphBase CDG;
    PostDominatorTree *PDT = &getAnalysis<PostDominatorTreeWrapperPass>(*F).getPostDomTree();
    CDG.graphForFunction(*F, *PDT);

    // filter struct field by struct type and field offset
    for (vector<StructFieldInfo *>::iterator itS = structFieldStoreSet.begin();
         itS != structFieldStoreSet.end(); itS++) {

        StructFieldInfo *SS = *itS;

        vector<LoadInst *> tempLoadIS;
        for (vector<StructFieldInfo *>::iterator itL = structFieldLoadSet.begin();
             itL != structFieldLoadSet.end(); ++itL) {

            StructFieldInfo *LL = *itL;

            if (LL->Stype == SS->Stype && SS->FieldOffset == LL->FieldOffset) {
                BasicBlock *loadBB = loadFieldMap[LL]->getParent();
                BasicBlock *storeBB = storeFieldMap[SS]->getParent();

                // load and store control dependency
                if (CDG.influences(loadBB, storeBB) && fieldTypeFilter(LL->FieldType)) {

                    if (findAPath(loadBB, storeBB, pLoopBBSet, loopHeader)) {
//                    errs() << "Find a struct field load and store " << SS->Stype << ";" << SS->FieldOffset << ";"
//                           << SS->FieldType << "\n";
                        errs() << *loadFieldMap[LL] << " === source code :" << printSrcCodeInfo(loadFieldMap[LL])
                               << "\n";
                        tempLoadIS.push_back(loadFieldMap[LL]);
                    }
                }
            }
        }

        if (!tempLoadIS.empty()) {
            errs() << "                                         " << "\n";
            errs() << *storeFieldMap[SS] << " === source code :" << printSrcCodeInfo(storeFieldMap[SS]) << "\n";
            loadStorePairMap[storeFieldMap[SS]] = tempLoadIS;
            errs() << "========================================= \n";
        }
    }

    errs() << "                                         " << "\n";
    errs() << "                                         " << "\n";
    errs() << "                                         " << "\n";
    errs() << "                                         " << "\n";

    // analyze Load Store Map
    if (!loadStorePairMap.empty()) {

        vector<PoState *> poStateVec;

        // find load instruction users
        for (std::map<StoreInst *, vector<LoadInst *>>::iterator it = loadStorePairMap.begin();
             it != loadStorePairMap.end(); ++it) {

            StoreInst *storeInst = it->first;
            BasicBlock *storeBB = storeInst->getParent();
            Value *storeValue = storeInst->getValueOperand();
            StateBase *stateBase = new StateBase();

            if (ConstantInt *conInst = dyn_cast<ConstantInt>(storeValue)) {
//                errs() << "Store State Value: " << conInst->getSExtValue() << "\n";
                stateBase->value = conInst->getSExtValue();
                stateBase->storeInst = storeInst;
            }

            vector<LoadInst *> LIVec = it->second;

            PoState *poState = new PoState();
            poState->stateBase = stateBase;

            vector<ConditionBase *> condBaseVec;

            for (LoadInst *loadInst: LIVec) {
                for (User *user: loadInst->users()) {
                    if (Instruction *I1 = dyn_cast<Instruction>(user)) {
                        if (I1->getOpcode() == Instruction::ICmp) {
                            ConditionBase *conBase = new ConditionBase();

                            ICmpInst *iCmpInst = dyn_cast<ICmpInst>(user);

                            Value *conValue = iCmpInst->getOperand(1);
                            ConstantInt *conInst = dyn_cast<ConstantInt>(conValue);

                            conBase->predicate = iCmpInst->getPredicate();
                            conBase->value = conInst->getSExtValue();

                            // TODO:: FIX ME
                            if(conBase->value == stateBase->value) {
                                continue;
                            }

                            TerminatorInst *termInst = loadInst->getParent()->getTerminator();
                            if (BranchInst *branInst = dyn_cast<BranchInst>(termInst)) {
                                BasicBlock *trueBB = branInst->getSuccessor(0);
                                BasicBlock *falseBB = branInst->getSuccessor(1);
                                if (findAPath(trueBB, storeBB, pLoopBBSet, loopHeader)) {
                                    conBase->direction = "Yes";

                                } else if(findAPath(falseBB, storeBB, pLoopBBSet, loopHeader)) {
                                    conBase->direction = "Not";
                                }
                            }

                            condBaseVec.push_back(conBase);

//                            errs() << icmpString(iCmpInst->getPredicate()) <<
//                                   " " << conBase->direction + " " + to_string(conBase->value) << "\n";
                        }
                    }
                }
            }

            poState->condVec = condBaseVec;
            poStateVec.push_back(poState);
        }

        // print
        printPoState(poStateVec);
    }

}


void FSMExtractor::getAnalysisUsage(AnalysisUsage &AU) const {
    AU.setPreservesAll();
    AU.addRequired<PostDominatorTreeWrapperPass>();
    AU.addRequired<DominatorTreeWrapperPass>();
    AU.addRequired<LoopInfoWrapperPass>();
}

FSMExtractor::FSMExtractor() : ModulePass(ID) {
    PassRegistry &Registry = *PassRegistry::getPassRegistry();
    initializePostDominatorTreeWrapperPassPass(Registry);
    initializeDominatorTreeWrapperPassPass(Registry);
    initializeLoopInfoWrapperPassPass(Registry);
}


bool FSMExtractor::isFSMLoop(Loop *pLoop) {

}

bool FSMExtractor::runOnModule(Module &M) {

    if (strFunctionName.empty()) {
        strFunctionName = "main";
    }

    // get main function and dump it
    Function *pFunc = M.getFunction(strFunctionName);
    assert(pFunc != NULL);

    // find the loop in this function
    LoopInfo &LoopInfo = getAnalysis<LoopInfoWrapperPass>(*pFunc).getLoopInfo();

    if (LoopInfo.empty()) {
        errs() << "There is no loop in function " << strFunctionName << "\n";
        return false;
    }

    for (auto &loop:LoopInfo) {
        collectStoreAndStore(loop);
    }

    return false;
}
