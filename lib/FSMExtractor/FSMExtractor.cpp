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

void FSMExtractor::collectStoreAndStore(Loop *pLoop) {

    std::vector<StructFieldInfo *> structFieldStoreSet;
    std::vector<StructFieldInfo *> structFieldLoadSet;
    std::map<StructFieldInfo *, StoreInst *> storeFieldMap;
    std::map<StructFieldInfo *, LoadInst *> loadFieldMap;


    for (BasicBlock *BB: pLoop->getBlocks()) {

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

    Function *F = pLoop->getHeader()->getParent();
    ControlDependenceGraphBase CDG;
    PostDominatorTree *PDT = &getAnalysis<PostDominatorTreeWrapperPass>(*F).getPostDomTree();
    CDG.graphForFunction(*F, *PDT);

    // filter struct field by struct type and field offset
    for (vector<StructFieldInfo *>::iterator itS = structFieldStoreSet.begin();
         itS != structFieldStoreSet.end(); itS++) {

        StructFieldInfo *SS = *itS;
//        errs() << "Find a struct field store " << SS->Stype << "," << SS->FieldOffset << "\n" ;

        for (vector<StructFieldInfo *>::iterator itL = structFieldLoadSet.begin();
             itL != structFieldLoadSet.end(); ++itL) {
            StructFieldInfo *LL = *itL;
//            errs() << "Find a struct field load " << storeLL->Stype << "," << storeLL->FieldOffset << "\n" ;

            if (LL->Stype == SS->Stype && SS->FieldOffset == LL->FieldOffset) {
                BasicBlock *loadBB = loadFieldMap[LL]->getParent();
                BasicBlock *storeBB = storeFieldMap[SS]->getParent();
                if (CDG.controls(loadBB, storeBB) && fieldTypeFilter(LL->FieldType)) {
                    SS->Stype->dump();
                    storeFieldMap[SS]->dump();
                    LL->FieldType->dump();
                    errs() << "Find a struct field load and store " << SS->Stype << ";" << SS->FieldOffset << ";"
                           << SS->FieldType << "\n";
                }
            }
        }
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
