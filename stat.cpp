
#include <errno.h>
#include <signal.h>
#include <sstream>
#include <fstream>
#include <set>
#include "hcm.h"
#include "hcmvcd.h"
#include "flat.h"

using namespace std;

bool verbose = false;

int get_depth_node(hcmNode *curr_node){
	int depth = 1;
	int curr_inst_port_depth;
	int max_inst_port_depth = 0;
	map<string,hcmInstPort*>::const_iterator nIP;
	if(curr_node->getInstPorts().empty())
		return 0;
	for(nIP = curr_node->getInstPorts().begin();nIP != curr_node->getInstPorts().end();nIP++){
		hcmPort *inst_port_port = (*nIP).second->getPort();
		hcmNode *inst_port_node = inst_port_port->owner();
		curr_inst_port_depth = get_depth_node(inst_port_node);
		if(curr_inst_port_depth > max_inst_port_depth)
			max_inst_port_depth = curr_inst_port_depth;
	}
	depth += max_inst_port_depth;
	return depth;
}

// What is this?
//set<string> get_deepest_node (hcmCell *top_cell){
//	set<string> NodesSet = new set<string>;
//
//}

int get_max_depth(hcmCell *top_cell){
	map<string,hcmNode*>::const_iterator nI;
	int curr_depth = 0;
	int max_depth = 0;
	for(nI = top_cell->getNodes().begin();nI != top_cell->getNodes().end(); nI++){
		curr_depth = get_depth_node((*nI).second);
		if (curr_depth > max_depth)
			max_depth = curr_depth;
	}
	return max_depth;
}

int count_nands(hcmCell *cell) {
	map<string, hcmInstance*>::const_iterator nIn;
	int count = 0;
	if (cell->getInstances().empty()) return count;
	for (nIn = cell->getInstances().begin(); nIn != cell->getInstances().end(); nIn++) {
		string name = (*nIn).second->masterCell()->getName();
		if (name == "nand") {
			count++;
		}
		else count += count_nands((*nIn).second->masterCell());
	}
	return count;
}

void count_ands_folded_rec(hcmCell *cell, map<string,int> &visitedCellsCount) {

	if (visitedCellsCount.find(cell->getName()) != visitedCellsCount.end()) return; //if already visited, return.
	if (cell->getInstances().empty()) return;

	map<string, hcmInstance*>::const_iterator nIn;
	int count = 0;

	for (nIn = cell->getInstances().begin(); nIn != cell->getInstances().end(); nIn++) {
		string name = (*nIn).second->masterCell()->getName();
		if (name == "and") { //count only AND instances in curr cell
			count++;
		}
		else count_ands_folded_rec((*nIn).second->masterCell(),visitedCellsCount); //recursive
	}
	if (count!=0) visitedCellsCount[cell->getName()] = count;
}

int count_ands_folded(hcmCell *topCell) {
	map<string, int> visitedCellsCount;
	count_ands_folded_rec(topCell, visitedCellsCount);
	map<string, int>::const_iterator itr;
	int count = 0;
	for (itr = visitedCellsCount.begin(); itr != visitedCellsCount.end(); itr++) {
		count += (*itr).second;
	}
	return count;
}

int count_in_String(string s) {
	int count = 0;
	for (int i = 0; i < s.size(); i++)
		if (s[i] == '/') count++;
	return count;
}
void print_topmost_nodes(hcmCell *topCell, set< string> &globalNodes) {
	set<string> Nodes;
	hcmCell *top_cell_flat = hcmFlatten(topCell->getName() + "_flat", topCell, globalNodes);
	map<string, hcmNode*>::iterator NI;
	int maxLevel = 0;
	for (NI = top_cell_flat->getNodes().begin(); NI != top_cell_flat->getNodes().end(); NI++) {
		int curr = count_in_String((*NI).first);
		if (curr > maxLevel) { //new depth
			maxLevel = curr;
			Nodes.clear();
			Nodes.insert((*NI).first);
		}
		else if (curr = maxLevel) {
			Nodes.insert((*NI).first);
		}
	}
	cout << "f. Max depth node: " << maxLevel << endl;
	set<string>::iterator itr;
	for (itr = Nodes.begin(); itr != Nodes.end(); itr++) { //print out nodes
		cout << "f. Node: " << (*itr) << endl;
	}
}





int main(int argc, char **argv) {
	int anyErr = 0;
	unsigned int i;
	vector<string> vlgFiles;
	string top_cell_name;

	// Parse input
	if (argc < 2) {
		anyErr++;
	} else {
		top_cell_name = argv[1];

		for (int argIdx = 2;argIdx < argc; argIdx++) {
			vlgFiles.push_back(argv[argIdx]);
		}

		if (vlgFiles.size() < 1) {
			cerr << "-E- At least top-level and single verilog file required for spec model" << endl;
			anyErr++;
		}
	}

//	if (anyErr) {
//		cerr << "Usage: " << argv[0] << "  [-v] top-cell file1.v [file2.v] ... \n";
//		exit(1);
//	}
	cin >> top_cell_name;
	string file;
	cin >> file;
	vlgFiles.push_back(file);
	cin >> file;
	vlgFiles.push_back(file);
	// Build HCM design
	set< string> globalNodes;
	globalNodes.insert("VDD");
	globalNodes.insert("VSS");

	hcmDesign* design = new hcmDesign("design");
	for (i = 0; i < vlgFiles.size(); i++) {
		printf("-I- Parsing verilog %s ...\n", vlgFiles[i].c_str());
		if (!design->parseStructuralVerilog(vlgFiles[i].c_str())) {
			cerr << "-E- Could not parse: " << vlgFiles[i] << " aborting." << endl;
			exit(1);
		}
	}

	hcmCell *top_cell = design->getCell(top_cell_name);

	int num_instances = top_cell->getInstances().size();

	int num_nodes = top_cell->getNodes().size();

	int max_depth = get_max_depth(top_cell);

	int num_ands_folded = count_ands_folded(top_cell);

	int num_nands = count_nands(top_cell);

	cout << "ia. Num top instances: " << num_instances << endl;
	cout << "b. Num top nodes: " << num_nodes << endl;
	cout << "c. Max reach depth: " << max_depth << endl;
	cout << "d. Num and in folded: " << num_ands_folded << endl;
	cout << "e. Num nand in hierarchy: " << num_nands << endl;

	print_topmost_nodes(top_cell,globalNodes);
}
