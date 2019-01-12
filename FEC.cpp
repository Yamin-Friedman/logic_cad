#include <sstream>
#include <fstream>
#include <set>
#include <algorithm>
#include <list>
#include <queue>
#include <map>
#include <vector>
#include "hcm.h"
#include "flat.h"
#include "hcmsigvec.h"
#include "hcmvcd.h"
#include "clauses.h"

using namespace std;

bool verbose = false;


//Clause functions:



int main(int argc, char **argv) {
	int anyErr = 0;
	unsigned int i;
	vector<string> vlgFiles;
	string top_cell_name;


	// Parse input
	if (argc < 4) {
		anyErr++;
	} else {
		top_cell_name = argv[1];

		for (int argIdx = 4; argIdx < argc; argIdx++) {
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
	set<string> globalNodes;
	globalNodes.insert("VDD");
	globalNodes.insert("VSS");

	hcmDesign *design = new hcmDesign("design");
	for (i = 0; i < vlgFiles.size(); i++) {
		if (!design->parseStructuralVerilog(vlgFiles[i].c_str())) {
			cerr << "-E- Could not parse: " << vlgFiles[i] << " aborting." << endl;
			exit(1);
		}
	}


	hcmCell *top_cell = design->getCell(top_cell_name);

	hcmCell *top_cell_flat = hcmFlatten(top_cell_name + "_flat", top_cell, globalNodes);


}

