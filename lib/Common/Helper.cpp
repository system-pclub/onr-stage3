#include "llvm/IR/DebugInfo.h"
#include "llvm/IR/MDBuilder.h"

#include "Common/Helper.h"

using namespace llvm;
using namespace std;


std::string printSrcCodeInfo(Instruction *pInst) {
    const DILocation *DIL = pInst->getDebugLoc();

    if (!DIL)
        return "";

    char pPath[400];

    std::string sFileName = DIL->getDirectory().str() + "/" + DIL->getFilename().str();
    realpath(sFileName.c_str(), pPath);
    sFileName = std::string(sFileName);
    unsigned int numLine = DIL->getLine();
    return sFileName + ": " + std::to_string(numLine);

}