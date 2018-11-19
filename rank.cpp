
#include <sstream>
#include <fstream>
#include <set>
#include <algorithm>
#include <list>
#include "hcm.h"
#include "flat.h"

using namespace std;

bool verbose = false;

bool check_gate_can_be_ranked(hcmInstance &curr_gate){
	map<string,hcmInstPort*>::iterator it;
	int rank;
	int max_rank = 0;

	if(curr_gate.getProp("rank",rank) != NOT_FOUND)
		return false;

	for (it = curr_gate.getInstPorts().begin(); it != curr_gate.getInstPorts().end(); it++){
		hcmInstPort *inst_port = (*it).second;
		if (inst_port->getPort()->getDirection() == IN){
			if (inst_port->getNode()->getProp("rank",rank) == NOT_FOUND)
				return false;
			else
				if (rank > max_rank)
					max_rank = rank;
		}
	}
	curr_gate.setProp("rank",max_rank);
	return true;
}

struct rank_compare {
	bool operator() (hcmInstance* lhs, hcmInstance* rhs) const {
		int rank1, rank2;
		lhs->getProp("rank",rank1);
		rhs->getProp("rank",rank2);
		if (rank1 < rank2)
			return true;
		else if (rank1 > rank2)
			return false;
		else {
			string name1, name2;
			name1 = lhs->getName();
			name2 = rhs->getName();
			return name1 < name2;
		}
	}
};

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
		printf("-I- Parsing verilog %s ...\n", vlgFiles[i].c_str());
		if (!design->parseStructuralVerilog(vlgFiles[i].c_str())) {
			cerr << "-E- Could not parse: " << vlgFiles[i] << " aborting." << endl;
			exit(1);
		}
	}

	hcmCell *top_cell = design->getCell(top_cell_name);

	hcmCell *top_cell_flat = hcmFlatten(top_cell_name + "_flat",top_cell,globalNodes);

	list<hcmNode*> node_list;
	list<hcmInstance*> gate_list;
	set<hcmInstance*,rank_compare> rank_set;

	map<string,hcmNode*>::iterator NI;

	for (NI = top_cell_flat->getNodes().begin();NI != top_cell_flat->getNodes().end();NI++){
		if ((*NI).second->getPort() && (*NI).second->getPort()->getDirection() == IN){
			(*NI).second->setProp("rank",0);
			node_list.emplace_back((*NI).second);
		}
	}

	while(!node_list.empty() || !gate_list.empty()){
		list<hcmNode*>::iterator NVI;
		for (NVI = node_list.begin();NVI != node_list.end();){
			map<string,hcmInstPort*>::iterator instp_MI;
			for (instp_MI = (*NVI)->getInstPorts().begin(); instp_MI != (*NVI)->getInstPorts().end();instp_MI++){
				hcmInstance *curr_gate = (*instp_MI).second->getInst();
				if(check_gate_can_be_ranked(*curr_gate)){
					int rank;
					curr_gate->getProp("rank",rank);
					rank_set.insert(curr_gate);
					gate_list.emplace_back(curr_gate);
				}
			}
			node_list.erase(NVI++);
		}
		list<hcmInstance*>::iterator inst_VI;
		for (inst_VI = gate_list.begin(); inst_VI != gate_list.end();){
			map<string,hcmInstPort*>::iterator instp_MI;
			for (instp_MI = (*inst_VI)->getInstPorts().begin(); instp_MI != (*inst_VI)->getInstPorts().end(); instp_MI++){
				hcmNode *curr_node = (*instp_MI).second->getNode();
				int rank;
				if(curr_node->getProp("rank",rank) == NOT_FOUND){
					(*inst_VI)->getProp("rank",rank);
					curr_node->setProp("rank",rank + 1);
					node_list.emplace_back(curr_node);
				}
			}
			gate_list.erase(inst_VI++);
		}
	}

	ofstream output_file;
	output_file.open(top_cell_name + ".ranks");

	set<hcmInstance*,rank_compare>::iterator set_it;
	for (set_it = rank_set.begin(); set_it != rank_set.end(); set_it++){
		int rank;
		(*set_it)->getProp("rank",rank);
		output_file << rank << " " + (*set_it)->getName() << endl;
	}

	output_file.close();

	delete design;
}