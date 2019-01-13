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


void parse_input(int argc, char **argv, vector<string> *spec_vlgFiles, vector<string> *implementation_vlgFiles,
                 string *spec_top_cell_name, string *implementation_top_cell_name) {
	vector<string> *vlgFiles_ptr = NULL;
	int any_err = 0;

	if (argc < 7) {
		any_err++;
	} else {
		for (int i = 1; i < argc; i++) {
			if (argv[i] == "-v") {
				verbose = true;
			} else if (argv[i] == "-s") {
				vlgFiles_ptr = spec_vlgFiles;
				*spec_top_cell_name = argv[i + 1];
				i++;
			} else if (argv[i] == "-i") {
				vlgFiles_ptr = implementation_vlgFiles;
				*implementation_top_cell_name = argv[i + 1];
				i++;
			} else {
				vlgFiles_ptr->push_back(argv[i]);
			}
		}
	}

	if (any_err > 0) {
		cerr << "Usage: " << argv[0] << "   [-v] -s <spec-cell > <verilog-1> [<verilog-2> … ] -i <implemenattion-cell > <verilog-1> [<verilog-2> … ]" << endl;
		exit(1);
	}
}

int main(int argc, char **argv) {
	unsigned int i;
	vector<string> spec_vlgFiles;
	vector<string> implementation_vlgFiles;
	string spec_top_cell_name;
	string implementation_top_cell_name;


	parse_input(argc,argv,&spec_vlgFiles,&implementation_vlgFiles,&spec_top_cell_name,&implementation_top_cell_name);


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

