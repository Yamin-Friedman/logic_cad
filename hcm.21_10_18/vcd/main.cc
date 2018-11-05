//
// DEMO of writing VCD using libvcd
// 

#include <errno.h>
#include <signal.h>
#include <sstream>
#include <fstream>
#include <set>
#include "vcd.h"
#include "hcm.h"

using namespace std;

bool verbose = false;

///////////////////////////////////////////////////////////////////////////
const vcdNodeCtx *
getRandomNodeCtx(set< vcdNodeCtx, cmpNodeCtx > &vcdNodes) 
{
  set< vcdNodeCtx, cmpNodeCtx >::const_iterator I = vcdNodes.begin();
  size_t i = rand() % vcdNodes.size();
  for (size_t j = 0; j < i; j++) 
	 I++;
  return(&(*I));
}

int
prepVcdNodes(hcmCell *cell,
				 list<string> parentInstNames,
				 set< string> &glbNodeNames,
				 set< vcdNodeCtx, cmpNodeCtx > &vcdNodes)
{
  // dump out all local nodes in this level that are not external
  map< string, hcmNode* >::const_iterator nI;
  const map< string, hcmNode* > &nodesMap = cell->getNodes();
  for (nI = nodesMap.begin(); nI != nodesMap.end(); nI++) {
    const hcmNode *node = (*nI).second;
    string name = node->getName();
	 // we skip nodes connected from above if we are not on top 
    if (node->getPort() && !parentInstNames.empty()) 
      continue;
	 // we skip global nodes
    if (glbNodeNames.find(name) != glbNodeNames.end()) 
      continue;
	 vcdNodeCtx nodeCtx(parentInstNames, name);
	 vcdNodes.insert(nodeCtx);
  }
  
  // recurse on all instances
  map< string, hcmInstance* >::const_iterator iI;
  for (iI = cell->getInstances().begin(); iI != cell->getInstances().end(); iI++) { 
    list<string> iParents = parentInstNames;
    iParents.push_back((*iI).first);
	 hcmCell *master = (*iI).second->masterCell();
	 prepVcdNodes(master, iParents, glbNodeNames, vcdNodes);
  }

  return(0);
}

list<string> array_to_list(size_t s, string a[]) 
{
  list<string> r;
  for (size_t i = 0; i < s; i++) {
	 r.push_back(a[i]);
  }
  return r;
}

///////////////////////////////////////////////////////////////////////////

int main(int argc, char **argv) {
  int argIdx = 1;
  int anyErr = 0;
  unsigned int i;
  vector<string> vlgFiles;
  bool shortRun = false;

  if (argc < 3) {
    anyErr++;
  } else {
    if (!strcmp(argv[argIdx], "-v")) {
      argIdx++;
      verbose = true;
    }
    if (!strcmp(argv[argIdx], "-s")) {
      argIdx++;
      shortRun = true;
    }

    for (;argIdx < argc; argIdx++) {
      vlgFiles.push_back(argv[argIdx]);
    }
    
    if (vlgFiles.size() < 2) {
      cerr << "-E- At least top-level and single verilog file required for spec model" << endl;
      anyErr++;
    }
  }

  if (anyErr) {
    cerr << "Usage: " << argv[0] << "  [-v] top-cell file1.v [file2.v] ... \n";
    exit(1);
  }

  set< string> globalNodes;
  globalNodes.insert("VDD");
  globalNodes.insert("VSS");
  
  hcmDesign* design = new hcmDesign("design");
  string cellName = vlgFiles[0];
  for (i = 1; i < vlgFiles.size(); i++) {
    printf("-I- Parsing verilog %s ...\n", vlgFiles[i].c_str());
    if (!design->parseStructuralVerilog(vlgFiles[i].c_str())) {
      cerr << "-E- Could not parse: " << vlgFiles[i] << " aborting." << endl;
      exit(1);
    }
  }

  hcmCell *topCell = design->getCell(cellName);
  if (!topCell) {
    printf("-E- could not find cell %s\n", cellName.c_str());
    exit(1);
  }
  
  // prepare the set of node contexts to declare what teh VCD will contain
  list<string> emptyParents; // needed for starting the recursion with 0 parents
  set< vcdNodeCtx, cmpNodeCtx > vcdNodes; // collects all nodes contexts
  prepVcdNodes(topCell, emptyParents, globalNodes, vcdNodes); // recurse getting all nodes
  vcdFormatter vcd(cellName + ".vcd", cellName, vcdNodes); // initialize the VCD
  if (!vcd.good()) {
    printf("-E- Could not create vcdFormatter for cell: %s\n", 
           cellName.c_str());
    exit(1);
  }

  if (shortRun) {
	 // Example for creating a NodeCtx assuming the design contains the 
	 // following node "line1" inside the hierarchy M4/UM4_3/CalcCy/Cla12_0
	 // (that is true for cell TopLevel2670 provided in c2670high.v)
	 // To test run: 
	 // 
	 
	 // first we populate the list of parent insts and node - note this is the kind of code
	 // you may use for looking up a node...
	 string s[] = {"M4", "UM4_3", "CalcCy", "Cla12_0"};
	 list<string> parents = array_to_list(4, s);

	 vcdNodeCtx *ctx = new vcdNodeCtx(parents, "line1");
	 string code = vcd.getNodeCtxCode(ctx);
	 if (code.size() == 0) {
		cerr << "Could not get code for node: M4/UM4_3/CalcCy/Cla12_0/line1" << endl;
		cerr << "   run: ./test_vcd -s TopLevel2670 ../ISCAS-85/stdcell.v ../ISCAS-85/c2670high.v "
			  << endl;
		exit(1);
	 }
	 
	 vcd.changeValue(code, false);
	 vcd.changeTime(1);
	 vcd.changeValue(code, true);
	 vcd.changeTime(2);
	 vcd.changeValue(code, true);
	 vcd.changeTime(3);
	 vcd.changeValue(code, false);
	 cout << "-I- Wrote " << cellName << ".vcd" << endl;
	 exit(0);
  }

  // randomize some changes of values and write them out
  bool newVal = false;
  for (unsigned int t = 1; t < 100; t++) {
	 newVal = !newVal;
    for (int i = 0;  i < 20; i++) {
      const vcdNodeCtx *nodeCtx = getRandomNodeCtx(vcdNodes); 
      if (nodeCtx) {
		  string code = vcd.getNodeCtxCode(nodeCtx);
		  if (code.size() == 0) {
			 cerr << "Could not find code for node:" << nodeCtx->getName() << endl;
		  } else {
			 vcd.changeValue(code, newVal);
		  }
      }
    }
    vcd.changeTime(t);
  }

  cout << "-I- Wrote " << cellName << ".vcd" << endl;
  return(0);
}
