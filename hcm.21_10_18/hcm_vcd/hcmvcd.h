//
// A Library for VCD output for an HCM top cell and sons
// 

#include "hcm.h"
#include <fstream>
#include <list>
#include <set>

using namespace std;

// NOTE: the created VCD only contains top level nodes for nodes 
// that are external to an instance. 

// An occurrence node is defined by a context:
class hcmNodeCtx {
  // const hcmCell *topCell;
  list<const hcmInstance *> parentInsts;
  const hcmNode *node;
 public:
  hcmNodeCtx(list<const hcmInstance *> &p, const hcmNode *n);
  std::string getName() const;
  // const hcmCell *getTopCell() {return(topCell);};
  list<const hcmInstance *> &getParents() {return(parentInsts);};
  const hcmNode *getNode() const {return(node);};
  friend class cmpNodeCtx;
};

class cmpNodeCtx {
 public:
  bool operator()(const hcmNodeCtx& a, const hcmNodeCtx& b) const {
    list<const hcmInstance *>::const_iterator apI = a.parentInsts.begin();
    list<const hcmInstance *>::const_iterator bpI = b.parentInsts.begin();
    while ((apI != a.parentInsts.end()) && (bpI != b.parentInsts.end())) {
      if ((*apI) != (*bpI)) {
	return ((*apI) < (*bpI));
      }
      apI++; bpI++;
    }
    if (apI != a.parentInsts.end()) {
      return false;
    } 
    if (bpI != b.parentInsts.end()) {
      return true;
    }
    return (a.node < b.node);
  };
};

class vcdFormatter {
  std::ofstream vcd;
  bool is_good;
  std::map< const hcmNodeCtx, std::string, cmpNodeCtx > codeByNodeCtx;
  const hcmCell *topCell;
  std::set<std::string> glbNodeNames;

  // write out scope for a given instance
  int dfsVCDScope(std::list<const hcmInstance *> &parentInsts);
  
  // given an identifier create the VCD code
  std::string getVCDId(int id);

  // Write the header and initialize internal data structure 
  int genVCDHeader();

 public:
  // constractor
  vcdFormatter(std::string fileName, const hcmCell *cell, 
	       std::set<std::string> &glbNodeNames);

  // destructor = close the file
  ~vcdFormatter();

  // is really opened?
  bool good() {return(is_good);};

  // Change the time
  int changeTime(unsigned long int newTime);

  // Declare a change of value
  // return 0 if successful (-1 if node does not exist)
  int changeValue(const hcmNodeCtx *nodeCtx, bool value);
};



