//
// DEMO of writing VCD using libhcmvcd
// 

#include <errno.h>
#include <signal.h>
#include <sstream>
#include <fstream>
#include <set>
#include "hcm.h"
#include "hcmvcd.h"

using namespace std;

bool verbose = false;

///////////////////////////////////////////////////////////////////////////

// get an internal node name by randomly selecting it and the decend level
hcmNodeCtx *
getRandomNodeCtx(const hcmCell* cell, 
                 list<const hcmInstance*> parentInsts, 
                 set<string> &glbNodes) {
  bool descend = (rand() % 2 == 0);
  hcmNodeCtx *res = NULL;
  if (descend && cell->getInstances().size()) {
    // find a random instance
    unsigned int instIdx = rand() % cell->getInstances().size();
    map< string, hcmInstance* >::const_iterator iI = cell->getInstances().begin();
    for (unsigned int i = 0; i < instIdx; i++) iI++;
    const hcmInstance *inst = (*iI).second;
    const hcmCell *master = inst->masterCell();
    list<const hcmInstance*> subPI = parentInsts;
    subPI.push_back(inst);
    if ((res = getRandomNodeCtx(master, subPI, glbNodes)))
      return(res);
  }

  // no lower level context found. Get a random top node here.
  map< string, hcmNode* >::const_iterator nI;
  const map< string, hcmNode* > &nodesMap = cell->getNodes();
  set< const hcmNode *> internalNodes;
  for (nI = nodesMap.begin(); nI != nodesMap.end(); nI++) {
    const hcmNode *node = (*nI).second;
    string name = node->getName();
    if (node->getPort()) 
      continue;

    if (glbNodes.find(name) != glbNodes.end()) 
      continue;

    internalNodes.insert(node);
  }

  if (internalNodes.empty())
    return(NULL);

  unsigned int nodeIdx = rand() % internalNodes.size();
  set< const hcmNode* >::const_iterator snI = internalNodes.begin();
  for (unsigned int i = 0; i < nodeIdx; i++) snI++;
  const hcmNode *node = (*snI);
  res = new hcmNodeCtx(parentInsts, node);
  cout << "-I- Add random node: " << res->getName() << endl;
  return(res);
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
  
  vcdFormatter vcd(cellName + ".vcd", topCell, globalNodes);
  if (!vcd.good()) {
    printf("-E- Could not create vcdFormatter for cell: %s\n", 
           cellName.c_str());
    exit(1);
  }

  if (shortRun) {
	 try {
		// Example for creating a NodeCtx assuming the design contains the 
		// following node "line1" inside the hierarchy M4/UM4_3/CalcCy/Cla12_0
		// (that is true for cell TopLevel2670 provided in c2670high.v)
		// To test run: 
		// 
		
		// first we populate the list of parent insts and node
		list<const hcmInstance *> parents;
		const hcmNode *node;
		const hcmInstance* inst;
		const hcmCell* master;
		if (!(inst = topCell->getInst("M4"))) {
		  cerr << "-E- Could not find instance M4 in top cell" << endl;
		  throw(1);
		}
		parents.push_back(inst);
		master = inst->masterCell();
		if (!(inst = master->getInst("UM4_3"))) {
		  cerr << "-E- Could not find instance UM4_3 in cell:" << master->getName() << endl;
		  throw(1);
		}
		parents.push_back(inst);
		master = inst->masterCell();
		if (!(inst = master->getInst("CalcCy"))) {
		  cerr << "-E- Could not find instance CalcCy in cell:" << master->getName() << endl;
		  throw(1);
		}
		master = inst->masterCell();
		parents.push_back(inst);
		if (!(inst = master->getInst("Cla12_0"))) {
		  cerr << "-E- Could not find instance Cla12_0 in cell:" << master->getName() << endl;
		  throw(1);
		}
		master = inst->masterCell();
		parents.push_back(inst);
		
		if (!(node = master->getNode("line1"))) {
		  cerr << "-E- Could not find node line1 in cell:" << master->getName() << endl;
		  throw(1);
		}
		
		hcmNodeCtx *ctx = new hcmNodeCtx(parents, node);
		vcd.changeValue(ctx, false);
		vcd.changeTime(1);
		vcd.changeValue(ctx, true);
		vcd.changeTime(2);
		vcd.changeValue(ctx, true);
		vcd.changeTime(3);
		vcd.changeValue(ctx, false);
		cout << "-I- Wrote " << cellName << ".vcd" << endl;
		exit(0);
	 } 
	 catch (int e) {
		cerr << "  run: ./test_vcd -s TopLevel2670 ../ISCAS-85/stdcell.v ../ISCAS-85/c2670high.v "
			  << endl;
		exit(1);
	 }
  }

  // Example for case where we want to keep track of object values and
  // declare their changes. We randomize selection of some nodes and 
  // show their changes.
  map< const hcmNodeCtx, bool, cmpNodeCtx > valByNodeCtx;
  list<const hcmInstance*> noInsts;

  // randomize some changes of values and write them out
  for (unsigned int t = 1; t < 100; t++) {
    for (int i = 0;  i < 20; i++) {
      hcmNodeCtx *nodeCtx = getRandomNodeCtx(topCell, noInsts, globalNodes); 
      if (nodeCtx) {
        if (valByNodeCtx.find(*nodeCtx) == valByNodeCtx.end()) {
          valByNodeCtx[*nodeCtx] = 1;
        }
        bool newVal = !valByNodeCtx[*nodeCtx];
        valByNodeCtx[*nodeCtx] = newVal;
        vcd.changeValue(nodeCtx, newVal);
      }
    }
    vcd.changeTime(t);
  }

  return(0);
}
