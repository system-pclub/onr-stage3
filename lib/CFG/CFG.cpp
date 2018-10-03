#include <deque>

#include "llvm/ADT/PostOrderIterator.h"
#include "llvm/IR/Instructions.h"

#include "CFG/CFG.h"


using namespace std;
using namespace llvm;

void ControlDependenceNode::addTrue(ControlDependenceNode *Child) {
    TrueChildren.insert(Child);
}

void ControlDependenceNode::addFalse(ControlDependenceNode *Child) {
    FalseChildren.insert(Child);
}

void ControlDependenceNode::addOther(ControlDependenceNode *Child) {
    OtherChildren.insert(Child);
}

void ControlDependenceNode::addParent(ControlDependenceNode *Parent) {
    assert(std::find(Parent->begin(), Parent->end(), this) != Parent->end()
           && "Must be a child before adding the parent!");
    Parents.insert(Parent);
}

void ControlDependenceNode::removeTrue(ControlDependenceNode *Child) {
    node_iterator CN = TrueChildren.find(Child);
    if (CN != TrueChildren.end())
        TrueChildren.erase(CN);
}

void ControlDependenceNode::removeFalse(ControlDependenceNode *Child) {
    node_iterator CN = FalseChildren.find(Child);
    if (CN != FalseChildren.end())
        FalseChildren.erase(CN);
}

void ControlDependenceNode::removeOther(ControlDependenceNode *Child) {
    node_iterator CN = OtherChildren.find(Child);
    if (CN != OtherChildren.end())
        OtherChildren.erase(CN);
}

void ControlDependenceNode::removeParent(ControlDependenceNode *Parent) {
    node_iterator PN = Parents.find(Parent);
    if (PN != Parents.end())
        Parents.erase(PN);
}

const ControlDependenceNode *ControlDependenceNode::enclosingRegion() const {
    if (this->isRegion()) {
        return this;
    } else {
        assert(this->Parents.size() == 1);
        const ControlDependenceNode *region = *this->Parents.begin();
        assert(region->isRegion());
        return region;
    }
}

ControlDependenceNode::EdgeType ControlDependenceGraphBase::getEdgeType(const BasicBlock *A, const BasicBlock *B) {
    if (const BranchInst *b = dyn_cast<const BranchInst>(A->getTerminator())) {
        if (b->isConditional()) {
            if (b->getSuccessor(0) == B) {
                return ControlDependenceNode::TRUE;
            } else if (b->getSuccessor(1) == B) {
                return ControlDependenceNode::FALSE;
            } else {
                assert(false && "Asking for edge type between unconnected basic blocks!");
            }
        }
    }

    return ControlDependenceNode::OTHER;
}

void ControlDependenceGraphBase::computeDependencies(Function &F, PostDominatorTree &pdt) {
    root = new ControlDependenceNode();
    nodes.insert(root);

    for (Function::iterator BI = F.begin(), E = F.end(); BI != E; ++BI) {
        BasicBlock *BB = &*BI;

        ControlDependenceNode *bn = new ControlDependenceNode(BB);
        nodes.insert(bn);
        bbMap[BB] = bn;
    }

    for (Function::iterator BI = F.begin(), E = F.end(); BI != E; ++BI) {
        BasicBlock *BB = &*BI;
        BasicBlock *A = BB;
        ControlDependenceNode *AN = bbMap[A];

        for (succ_iterator succ = succ_begin(A), end = succ_end(A); succ != end; ++succ) {
            BasicBlock *B = *succ;
            assert(A && B);

            if (A == B || !pdt.dominates(B, A)) {

                BasicBlock *L = pdt.findNearestCommonDominator(A, B);
#ifdef DEBUG_SONGLH
                errs() << A->getName() << "->" << B->getName() << ": " << L->getName() << "\n";
#endif
                ControlDependenceNode::EdgeType type = ControlDependenceGraphBase::getEdgeType(A, B);
                if (A == L) {
                    switch (type) {
                        case ControlDependenceNode::TRUE:
                            AN->addTrue(AN);
                            break;
                        case ControlDependenceNode::FALSE:
                            AN->addFalse(AN);
                            break;
                        case ControlDependenceNode::OTHER:
                            AN->addOther(AN);
                            break;
                    }

                    AN->addParent(AN);
#ifdef DEBUG_SONGLH
                    errs() << AN->getBlock()->getName() << "->"  << AN->getBlock()->getName() << "\n";
#endif
                }

                for (DomTreeNode *cur = pdt[B]; cur && cur != pdt[L]; cur = cur->getIDom()) {
                    ControlDependenceNode *CN = bbMap[cur->getBlock()];
                    switch (type) {
                        case ControlDependenceNode::TRUE:
                            AN->addTrue(CN);
                            break;
                        case ControlDependenceNode::FALSE:
                            AN->addFalse(CN);
                            break;
                        case ControlDependenceNode::OTHER:
                            AN->addOther(CN);
                            break;
                    }
                    assert(CN);
                    CN->addParent(AN);
#ifdef DEBUG_SONGLH
                    errs() << AN->getBlock()->getName() << "->"  << CN->getBlock()->getName() << "\n";
#endif
                }
#ifdef DEBUG_SONGLH
                errs() << "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\n";
#endif
            }
        }
    }

    // ENTRY -> START
    for (DomTreeNode *cur = pdt[&F.getEntryBlock()]; cur; cur = cur->getIDom()) {
        if (cur->getBlock()) {
            ControlDependenceNode *CN = bbMap[cur->getBlock()];
            assert(CN);
            root->addOther(CN);
            CN->addParent(root);
        }
    }
}

void ControlDependenceGraphBase::insertRegions(PostDominatorTree &pdt) {
    typedef po_iterator<PostDominatorTree *> po_pdt_iterator;
    typedef std::pair<ControlDependenceNode::EdgeType, ControlDependenceNode *> cd_type;
    typedef std::set<cd_type> cd_set_type;
    typedef std::map<cd_set_type, ControlDependenceNode *> cd_map_type;

    cd_map_type cdMap;
    cd_set_type initCDs;
    initCDs.insert(std::make_pair(ControlDependenceNode::OTHER, root));
    cdMap.insert(std::make_pair(initCDs, root));

    for (po_pdt_iterator DTN = po_pdt_iterator::begin(&pdt), END = po_pdt_iterator::end(&pdt); DTN != END; ++DTN) {
        if (!DTN->getBlock()) {
            continue;
        }

        ControlDependenceNode *node = bbMap[DTN->getBlock()];
        assert(node);

        cd_set_type cds;
        for (ControlDependenceNode::node_iterator P = node->Parents.begin(), E = node->Parents.end(); P != E; ++P) {
            ControlDependenceNode *parent = *P;
            if (parent->TrueChildren.find(node) != parent->TrueChildren.end()) {
                cds.insert(std::make_pair(ControlDependenceNode::TRUE, parent));
            }

            if (parent->FalseChildren.find(node) != parent->FalseChildren.end()) {
                cds.insert(std::make_pair(ControlDependenceNode::FALSE, parent));
            }

            if (parent->OtherChildren.find(node) != parent->OtherChildren.end()) {
                cds.insert(std::make_pair(ControlDependenceNode::OTHER, parent));
            }
        }

        cd_map_type::iterator CDEntry = cdMap.find(cds);
        ControlDependenceNode *region;

        if (CDEntry == cdMap.end()) {
            region = new ControlDependenceNode();
            nodes.insert(region);
            cdMap.insert(std::make_pair(cds, region));
            for (cd_set_type::iterator CD = cds.begin(), CDEnd = cds.end(); CD != CDEnd; ++CD) {
                switch (CD->first) {
                    case ControlDependenceNode::TRUE:
                        CD->second->addTrue(region);
                        break;
                    case ControlDependenceNode::FALSE:
                        CD->second->addFalse(region);
                        break;
                    case ControlDependenceNode::OTHER:
                        CD->second->addOther(region);
                        break;
                }

                region->addParent(CD->second);
            }
        } else {
            region = CDEntry->second;
        }

        for (cd_set_type::iterator CD = cds.begin(), CDEnd = cds.end(); CD != CDEnd; ++CD) {
            switch (CD->first) {
                case ControlDependenceNode::TRUE:
                    CD->second->removeTrue(node);
                    break;
                case ControlDependenceNode::FALSE:
                    CD->second->removeFalse(node);
                    break;
                case ControlDependenceNode::OTHER:
                    CD->second->removeOther(node);
                    break;
            }

            region->addOther(node);
            node->addParent(region);
            node->removeParent(CD->second);
        }
    }

    // Make sure that each node has at most one true or false edge
    for (std::set<ControlDependenceNode *>::iterator N = nodes.begin(), E = nodes.end(); N != E; ++N) {
        ControlDependenceNode *node = *N;
        assert(node);
        if (node->isRegion()) {
            continue;
        }

        // Fix too many true nodes
        if (node->TrueChildren.size() > 1) {
            ControlDependenceNode *region = new ControlDependenceNode();
            nodes.insert(region);
            for (ControlDependenceNode::node_iterator C = node->true_begin(), CE = node->true_end(); C != CE; ++C) {
                ControlDependenceNode *child = *C;
                assert(node);
                assert(child);
                assert(region);
                region->addOther(child);
                child->addParent(region);
                child->removeParent(node);
                node->removeTrue(child);
            }
            node->addTrue(region);
        }

        // Fix too many false nodes
        if (node->FalseChildren.size() > 1) {
            ControlDependenceNode *region = new ControlDependenceNode();
            nodes.insert(region);
            for (ControlDependenceNode::node_iterator C = node->false_begin(), CE = node->false_end(); C != CE; ++C) {
                ControlDependenceNode *child = *C;
                region->addOther(child);
                child->addParent(region);
                child->removeParent(node);
                node->removeFalse(child);
            }

            node->addFalse(region);
        }
    }
}


void ControlDependenceGraphBase::graphForFunction(Function &F, PostDominatorTree &pdt) {
    computeDependencies(F, pdt);
    //insertRegions(pdt);
}

bool ControlDependenceGraphBase::controls(BasicBlock *A, BasicBlock *B) const {
    const ControlDependenceNode *n = getNode(B);
    assert(n && "Basic block not in control dependence graph!");
    while (n->getNumParents() == 1) {
        n = *n->parent_begin();
        if (n->getBlock() == A) {
            return true;
        }
    }
    return false;
}


bool ControlDependenceGraphBase::influences(BasicBlock *A, BasicBlock *B) const {
    const ControlDependenceNode *n = getNode(B);
    assert(n && "Basic block not in control dependence graph!");

    std::deque<ControlDependenceNode *> worklist;
    worklist.insert(worklist.end(), n->parent_begin(), n->parent_end());

    std::set<ControlDependenceNode *> setProcessed;
    ControlDependenceNode::node_iterator itParentBegin = n->parent_begin();
    ControlDependenceNode::node_iterator itParentEnd = n->parent_end();

    for (; itParentBegin != itParentEnd; itParentBegin++) {
        setProcessed.insert(*itParentBegin);
    }

    while (!worklist.empty()) {
        n = worklist.front();
        worklist.pop_front();
        if (n->getBlock() == A) {
            return true;
        }

        itParentBegin = n->parent_begin();
        itParentEnd = n->parent_end();

        for (; itParentBegin != itParentEnd; itParentBegin++) {
            if (setProcessed.find(*itParentBegin) != setProcessed.end()) {
                continue;
            }
            setProcessed.insert(*itParentBegin);
            worklist.insert(worklist.end(), *itParentBegin);
        }

    }
    return false;

}


/*
bool ControlDependenceGraphBase::influences(BasicBlock *A, BasicBlock *B) const {
	const ControlDependenceNode *n = getNode(B);
	assert(n && "Basic block not in control dependence graph!");
	std::deque<ControlDependenceNode *> worklist;
	worklist.insert(worklist.end(), n->parent_begin(), n->parent_end());
	while (!worklist.empty()) {
		n = worklist.front();
		worklist.pop_front();
		if (n->getBlock() == A) return true;
		worklist.insert(worklist.end(), n->parent_begin(), n->parent_end());
	}
	return false;
}
*/

const ControlDependenceNode *ControlDependenceGraphBase::enclosingRegion(BasicBlock *BB) const {
    if (const ControlDependenceNode *node = this->getNode(BB)) {
        return node->enclosingRegion();
    } else {
        return NULL;
    }
}
