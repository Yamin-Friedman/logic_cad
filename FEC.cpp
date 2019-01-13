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


vector<vector<int>> get_node_clasues(hcmNode* node) {
	vector<vector<int>> clauses;
	vector<hcmInstance*> gates;

	//Find all gates pushing the node

	//Calculate the clauses for each gate
	vector<hcmInstance*>::iterator gate_it = gates.begin();
	for (; gate_it != gates.end(); gate_it++) {
		vector<vector<int>> gate_clauses;


		clauses.insert(clauses.end(),gate_clauses.begin(),gate_clauses.end());

		// Add to clauses the clauses for all the nodes pushing the gate recursivly with get_node_clauses
	}

	// Once we have calculated the clauses for a specific node we should save it so that we don't need to calculate again
	node->setProp("clauses",clauses);
	return clauses;
}

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
	vector<string> imp_vlgFiles;
	string spec_top_cell_name;
	string imp_top_cell_name;


	parse_input(argc,argv,&spec_vlgFiles,&imp_vlgFiles,&spec_top_cell_name,&imp_top_cell_name);


	// Build HCM designs
	set<string> globalNodes;
	globalNodes.insert("VDD");
	globalNodes.insert("VSS");

	hcmDesign *spec_design = new hcmDesign("spec_design");
	for (i = 0; i < spec_vlgFiles.size(); i++) {
		if (!spec_design->parseStructuralVerilog(spec_vlgFiles[i].c_str())) {
			cerr << "-E- Could not parse: " << spec_vlgFiles[i] << " aborting." << endl;
			exit(1);
		}
	}

	hcmDesign *imp_design = new hcmDesign("imp_design");
	for (i = 0; i < imp_vlgFiles.size(); i++) {
		if (!imp_design->parseStructuralVerilog(imp_vlgFiles[i].c_str())) {
			cerr << "-E- Could not parse: " << imp_vlgFiles[i] << " aborting." << endl;
			exit(1);
		}
	}


	hcmCell *spec_top_cell = spec_design->getCell(spec_top_cell_name);
	hcmCell *imp_top_cell = imp_design->getCell(imp_top_cell_name);

	// The spec PI/O is first and the imp PI/O is second
	map<hcmNode*,hcmNode*> PI_map;
	map<hcmNode*,hcmNode*> PO_map;

	map<string,hcmNode*>::iterator map_it = spec_top_cell->getNodes().begin();
	for (;map_it != spec_top_cell->getNodes().end(); map_it++) {
		if ((*map_it).second->getPort()->getDirection() == IN) {
			PI_map.insert(pair<hcmNode*,hcmNode*>((*map_it).second,imp_top_cell->getNode((*map_it).second->getName())));
		}

		if ((*map_it).second->getPort()->getDirection() == OUT) {
			PO_map.insert(pair<hcmNode*,hcmNode*>((*map_it).second,imp_top_cell->getNode((*map_it).second->getName())));
		}

		if ((*map_it).second->getName() == "VDD") {
			(*map_it).second->setProp("constant", 1);
			imp_top_cell->getNode((*map_it).second->getName())->setProp("constant", 1);
		}
		if ((*map_it).second->getName() == "VSS") {
			(*map_it).second->setProp("constant", 0);
			imp_top_cell->getNode((*map_it).second->getName())->setProp("constant", 0);
		}
	}

	// Loop over all the POs in the spec and imp, build clauses for them and compare with sat solver

	map<hcmNode*,hcmNode*>::iterator PO_map_it = PO_map.begin();
	for (;PO_map_it != PO_map.end(); PO_map_it++) {

		vector<vector<int>> spec_clause = get_node_clasues(PO_map_it->first);
		vector<vector<int>> imp_clause = get_node_clasues(PO_map_it->second);

	}

	hcmCell *top_cell_flat = hcmFlatten(top_cell_name + "_flat", top_cell, globalNodes);


}

