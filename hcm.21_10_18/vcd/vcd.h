//
// A Library for VCD output 
// 

#include <fstream>
#include <list>
#include <set>
#include <map>
#include <string>

using namespace std;

// NOTE: the created VCD only contains top level nodes for nodes 
// that are external to an instance. 

// An occurrence node is defined by a context:
class vcdNodeCtx {
  list<std::string> parentInstNames;
  std::string nodeName;
 public:
  vcdNodeCtx(list<std::string> &p, std::string n);
  std::string getName() const;
  list<std::string> &getParents() {return(parentInstNames);};
  std::string getNode() {return(nodeName);};
  friend class cmpNodeCtx;
  friend class vcdFormatter;
};

class cmpNodeCtx {
 public:
  bool operator()(const vcdNodeCtx& a, const vcdNodeCtx& b) const {
    list<std::string>::const_iterator apI = a.parentInstNames.begin();
    list<std::string>::const_iterator bpI = b.parentInstNames.begin();
    while ((apI != a.parentInstNames.end()) && (bpI != b.parentInstNames.end())) {
      if ((*apI) != (*bpI)) {
		  return ((*apI) < (*bpI));
      }
      apI++; bpI++;
    }
    if (apI != a.parentInstNames.end()) {
      return false;
    } 
    if (bpI != b.parentInstNames.end()) {
      return true;
    }
    return (a.nodeName < b.nodeName);
  };

  bool operator()(const vcdNodeCtx *a, const vcdNodeCtx *b) const {
    list<std::string>::const_iterator apI = a->parentInstNames.begin();
    list<std::string>::const_iterator bpI = b->parentInstNames.begin();
    while ((apI != a->parentInstNames.end()) && (bpI != b->parentInstNames.end())) {
      if ((*apI) != (*bpI)) {
		  return ((*apI) < (*bpI));
      }
      apI++; bpI++;
    }
    if (apI != a->parentInstNames.end()) {
      return false;
    } 
    if (bpI != b->parentInstNames.end()) {
      return true;
    }
    return (a->nodeName < b->nodeName);
  };
};

class vcdFormatter {
  std::ofstream vcd;
  bool is_good;
  std::map< const vcdNodeCtx *, std::string, cmpNodeCtx > codeByNodeCtx;
  std::string topCellName;

  // write out scope for a given instance
  int genVCDScope(std::set< vcdNodeCtx, cmpNodeCtx > &vcdNodes);
  
  // given an identifier create the VCD code
  std::string getVCDId(int id);

  // Write the header and initialize internal data structure 
  int genVCDHeader(std::set< vcdNodeCtx, cmpNodeCtx > &vcdNodes);

 public:
  // constractor
  vcdFormatter(std::string fileName, 
					std::string cellName, 
					std::set< vcdNodeCtx, cmpNodeCtx > &vcdNodes);

  // destructor = close the file
  ~vcdFormatter();

  // is really opened?
  bool good() {return(is_good);};

  // Change the time
  int changeTime(unsigned long int newTime);

  // get the code of the given node context
  string getNodeCtxCode(const vcdNodeCtx *nodeCtx);

  // Declare a change of value
  // return 0 if successful (-1 if node does not exist)
  int changeValue(string code, bool value);
};



