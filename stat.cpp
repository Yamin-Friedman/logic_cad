
#include <sstream>
#include <fstream>
#include <set>
#include <list>
#include "hcm.h"

using namespace std;

bool verbose = false;

// This function gets the number of heirarchies that the node traverses recursively
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

// This function finds the top cell node that traverses the most levels of heirarchy and returns the depth
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

// This function counts the number of nands in the entire design
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

// This function counts the number of ands in the folded model recursively
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

// This function returns the number of ands in the folded model
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

// This function recursively finds the heirarchical names of the nodes that are deepest
void get_list_deep_nodes(hcmCell *top_cell,list<string> &deep_node_list,int &max_node_depth, int curr_depth, string prefix, set< string> &globalNodes){
	map<string, hcmNode* >::iterator node_it;
	map<string,hcmInstance*>::iterator inst_it;
	for ( node_it = top_cell->getNodes().begin();  node_it != top_cell->getNodes().end();  node_it++){
		hcmNode *node = (*node_it).second;
		if (!node->getPort() && globalNodes.find(node->getName()) == globalNodes.end()){ // Makes sure that the node doesn't have a higher connection
			if (curr_depth >= max_node_depth){
				if (curr_depth > max_node_depth){ // If we have found a deeper node than we have to clear all the previous names
					max_node_depth = curr_depth;
					deep_node_list.clear();
				}
				deep_node_list.push_back(prefix + node->getName());
			}
		}
	}
	// Loops recursively over all instances in the current cell
	for (inst_it = top_cell->getInstances().begin(); inst_it != top_cell->getInstances().end(); inst_it++){
		hcmInstance *inst = (*inst_it).second;
		hcmCell *cell = (*inst_it).second->masterCell();
		get_list_deep_nodes(cell, deep_node_list,max_node_depth, curr_depth + 1,prefix + inst->getName() + "/", globalNodes);
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

	if (anyErr) {
		cerr << "Usage: " << argv[0] << "  [-v] top-cell file1.v [file2.v] ... \n";
		exit(1);
	}

	// Build HCM design
	set< string> globalNodes;
	globalNodes.insert("VDD");
	globalNodes.insert("VSS");

	hcmDesign* design = new hcmDesign("design");
	for (i = 0; i < vlgFiles.size(); i++) {
		if (!design->parseStructuralVerilog(vlgFiles[i].c_str())) {
			cerr << "-E- Could not parse: " << vlgFiles[i] << " aborting." << endl;
			exit(1);
		}
	}

	hcmCell *top_cell = design->getCell(top_cell_name);

	// Answer to part a
	int num_instances = top_cell->getInstances().size();

	// Answer to part b
	int num_nodes = top_cell->getNodes().size();

	// Answer to part c
	int max_depth = get_max_depth(top_cell);

	// Answer to part d
	int num_ands_folded = count_ands_folded(top_cell);

	// Answer to part e
	int num_nands = count_nands(top_cell);

	// Answer to part f
	list<string> deep_node_list;
	int max_node_depth = 0;
	get_list_deep_nodes(top_cell,deep_node_list,max_node_depth, 0, "", globalNodes);

	// Print the output to a file
	ofstream output_file;
	output_file.open((top_cell_name + ".stat").c_str(),fstream::out);
	output_file << "a. Num top instances: " << num_instances << endl;
	output_file << "b. Num top nodes: " << num_nodes << endl;
	output_file << "c. Max reach depth: " << max_depth << endl;
	output_file << "d. Num and in folded: " << num_ands_folded << endl;
	output_file << "e. Num nand in hierarchy: " << num_nands << endl;
	output_file << "f. Max depth node: " << max_node_depth << endl;
	list<string>::iterator list_it;
	for(list_it = deep_node_list.begin(); list_it != deep_node_list.end(); list_it++){
		output_file << "f. Node: " << (*list_it) << endl;
	}
	output_file.close();

	delete design;

}
