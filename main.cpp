//
// Created by Yamin on 11/7/2018.
//

#include <errno.h>
#include <signal.h>
#include <sstream>
#include <fstream>
#include <set>
#include "hcm.h"
#include "hcmvcd.h"

using namespace std;

int get_depth_node(hcmNode *curr_node){

}

int get_max_depth(hcmCell *top_node){
	map<string,hcmNode*>::const_iterator nI;
	int curr_depth = 0;
	int max_depth = 0;
	for(nI = top_node->getNodes().begin();nI != top_node->getNodes().end(); nI++){
		curr_depth = get_depth_node((*nI).second);
		if (curr_depth > max_depth)
			max_depth = curr_depth;
	}
	return max_depth;
}

int main(int argc, char **argv) {
	int anyErr = 0;
	unsigned int i;
	vector<string> vlgFiles;

	// Parse input
	if (argc < 2) {
		anyErr++;
	} else {
		string top_cell_name = argv[1];

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
	for (i = 1; i < vlgFiles.size(); i++) {
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
}
