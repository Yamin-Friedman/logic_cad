#include "hcm.h"
#include <set>
#include <fstream>
#include <sstream>
#include <algorithm>

using namespace std;

extern bool verbose;

class hcmCtx {
  string getHName(size_t fromLevel);
public:
  // we use vectors as it is easier to copy than lists...
  // note that lower instance is later by index
  vector<const hcmInstance *> insts;
  string getHName();
  // get the name of the top most node connected to the given inst port name
  int getInstPortTopNodeHName(string ipName, string &name, 
			      set< string> &globalNodes);
};

string
hcmCtx::getHName(size_t fromLevel)
{
  string res;
  if (fromLevel >= insts.size()) {
    fromLevel = insts.size() - 1;
  }
  for (size_t i = 0; i <= fromLevel; i++) {
    if (i) res += string("/");
    res += insts[i]->getName();
  }
  return(res);
}

string
hcmCtx::getHName() {
  return(getHName(insts.size()));
}

int
hcmCtx::getInstPortTopNodeHName(string ipName, string &name, 
				set< string> &globalNodes)
{
  string nodeName = ipName;
  for (int i = insts.size() - 1; i >= 0; i--) {
    const hcmInstance *inst = insts[i];
    string instPortName = inst->getName() + string("%") + nodeName;
    const hcmInstPort *instPort = inst->getInstPort(instPortName);
    if (instPort == NULL) {
      if (verbose) 
	cout << "-V- Could not find instance port: " << nodeName
	     << " on inst: " << inst->getName() 
	     << " in ctx: " << getHName(i)
	     << endl;
      return(1);
    }
    
    // we continue up until the node connected to instance is not connected 
    // to a port
    const hcmNode *node = instPort->getNode();
    if (node == NULL) {
      // the inst port not connected - use it
      name = getHName(i) + string("/") + nodeName;
      if (verbose) 
	cout << "-V- No conn of instance port: " << instPort->getName()
	     << " using internal node: " << name
	     << " in ctx: " << getHName(i)
	     << endl;
      return(0);
    }

    nodeName = node->getName();

    // we might have just stopped at this level
    if (node->getPort() == NULL) {
      // may be a global node so exist
      if (globalNodes.find(nodeName) != globalNodes.end()) {
	name = nodeName;
      } else {
	// the inst port not connected - use it
	string inHierName("");
	if (i > 0) 
	  inHierName = getHName(i-1) + string("/");
	name = inHierName + nodeName;
	if (verbose) 
	  cout << "-V- No port on node: " << nodeName
	       << " connected on inst port: " << instPort->getName()
	       << " in hier: " << inHierName
	       << " in ctx: " << getHName(i)
	       << endl;
      }
      return(0);      
    }
  }
  
  name = nodeName;
  return(0);
}

// Given a context and a given source cell sCell copy over to a 
// flat cell dCell
static int
flatten(hcmCtx ctx, hcmCell *sCell, hcmCell *dCell, 
	set< string> &globalNodes)
{
  // if have sub instances it is not a primitive so just dive
  if (sCell->getInstances().size()) {
    int res = 0;
    map< std::string, hcmInstance* >::iterator iI;
    for (iI = sCell->getInstances().begin();
	 iI != sCell->getInstances().end(); iI++) {
      hcmInstance *inst = (*iI).second;
      hcmCtx instCtx = ctx;
      instCtx.insts.push_back(inst);
      res += flatten(instCtx, inst->masterCell(), dCell, globalNodes);
    }
    return 0;
  }

  // if got here must be a primitive. Add it as new instance and connect.
  string hName = ctx.getHName();
  hcmInstance *newInst = dCell->createInst(hName, sCell);
  if (newInst == NULL) {
    cerr << "-F- Could not create new instance: " << hName
	 << " { " << sCell->getName() << " }" << endl;
    exit(1);
  }

  std::map< std::string, hcmNode* >::const_iterator nI;
  for (nI = sCell->getNodes().begin(); nI != sCell->getNodes().end(); nI++) {
    const hcmNode *node = (*nI).second;

    // may be a global node
    string topNodeName;
    if (ctx.getInstPortTopNodeHName(node->getName(), topNodeName, globalNodes))
      continue;

    // now lets get the node or create it
    hcmNode *newNode = dCell->getNode(topNodeName);
    if (newNode == NULL) {
      newNode = dCell->createNode(topNodeName);
      if (newNode == NULL) {
	cerr << "-F- Could not create new node: " << topNodeName
	     << endl;
	exit(1);
      }
    }
    
    // now lets connect to the new instance
    dCell->connect(newInst, newNode, node->getName());
  }
  return 0;
}

hcmCell *
hcmFlatten(string flatCellName, hcmCell *sCell, set< string> &globalNodes)
{
  // first create the cell in same design
  hcmCell *dCell = sCell->owner()->createCell(flatCellName);
  if (dCell == NULL) {
    cerr << "-F- Could not create new cell: " << flatCellName
	 << endl;
    exit(1);
  }
  
  // copy over all ports
  std::map< std::string, hcmNode* >::const_iterator nI;
  for (nI = sCell->getNodes().begin(); nI != sCell->getNodes().end(); nI++) {
    const hcmNode *node = (*nI).second;
    const hcmPort *port = node->getPort();
    if (port == NULL) 
      continue;

    hcmNode *newNode = dCell->createNode(node->getName());
    if (newNode == NULL) {
      cerr << "-F- Could not create new node for port: "
	   << node->getName() << endl;
      exit(1);
    }
    hcmPort *newPort = newNode->createPort(port->getDirection());
    if (newPort == NULL) {
      cerr << "-F- Could not create new port: "
	   << node->getName() << endl;
      exit(1);
    }
  }

  hcmCtx ctx; // empty context for the top cell...
  if (flatten(ctx, sCell, dCell, globalNodes)) {
    cerr << "-F- Could not populate new cell: " << flatCellName
	 << endl;
    exit(1);
  }
  return dCell;
}

int 
hcmWriteCellVerilog(hcmCell *topCell, string fileName)
{
  ofstream fv(fileName.c_str());
  if (!fv.good()) {
    cerr << "-E- Could not open file:" << fileName << endl;
    exit(1);
  }

  fv << "module " << topCell->getName() << " (" << endl;
  // ports list
  vector<hcmPort*> ports = topCell->getPorts();
  vector<hcmPort*>::iterator iP;
  for (iP = ports.begin(); iP != ports.end(); ++iP) {
    if (iP != ports.begin()) 
      fv << "," << endl;
    fv << "   " << (*iP)->owner()->getName();
  }
  fv << ");" << endl;

  for (iP = ports.begin(); iP != ports.end(); ++iP) {
    if ((*iP)->getDirection() == IN) {
      fv << "   input " << (*iP)->owner()->getName() << " ;" << endl;
    } else {
      fv << "   output " << (*iP)->owner()->getName() << " ;" << endl;
    }
  }
  fv << endl;

  // go over all instances
  map< std::string, hcmInstance* >::const_iterator iI;
  for (iI = topCell->getInstances().begin(); iI != topCell->getInstances().end(); iI++) {
    hcmInstance *inst = (*iI).second;

    ostringstream is;
    // go over all the inst ports of the original inst and find their occ nodes etc ...
    is << "   " << inst->masterCell()->getName() << " " << inst->getName() << " (" << endl;
    
    map<std::string, hcmInstPort* >::const_iterator ipI;
    for (ipI = inst->getInstPorts().begin(); ipI != inst->getInstPorts().end(); ipI++) {
      hcmNode *node = (*ipI).second->getNode();
      string nn = node->getName() ;
      replace( nn.begin(), nn.end(), '%', '/');
      if (ipI != inst->getInstPorts().begin())
	is << "," << endl;
      is << "      ." << (*ipI).second->getPort()->getName()
	 << " ( " << nn << " ) ";
    }
    is << " ); \n" << endl;
    string str = is.str();
    replace( str.begin(), str.end(), '%', '/');
    fv << str;
  }

  fv << "endmodule" << endl;
  fv.close();

  cout << "-I- Wrote " << fileName << endl;
  return 0;
}
