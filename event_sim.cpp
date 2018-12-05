#include <sstream>
#include <fstream>
#include <set>
#include <algorithm>
#include <list>
#include <queue>
#include "hcm.h"
#include "flat.h"

using namespace std;

bool verbose = false;

typedef int (*gate_operator)(vector<int>&);

//This gets the fanout on node and pushes the gates into the gate
void process_event(hcmNode* node, queue<hcmInstance*> gate_queue){
	map<string, hcmInstPort* > InstPorts = node->getInstPorts();
	if(InstPorts.empty())
		return;
	map<string,hcmInstPort*>::const_iterator iter;
	for (iter=InstPorts.begin();iter!=InstPorts.end();iter++){
		hcmPort *port= (*iter).second->getPort();
		if(port->getDirection()==OUT){
		    hcmInstance* curr_gate = (*iter).second->getInst();
		    gate_queue.push(curr_gate);
		}
	}
}

// inv_func: Inverts the input
int inv_func(vector<int>& input_vec){
	int res = input_vec[0];

	return !res;
}

// buffer_func: returns the input
int buffer_func(vector<int>& input_vec){
	int res = input_vec[0];

	return res;
}

// or_func: Computes OR between all the inputs received in the input_vec
int or_func(vector<int>& input_vec){
	int res = input_vec[0];

	for(int i = 1;i < input_vec.size();i++){
		res |= input_vec[i];
	}

	return res;
}

// nor_func: Computes NOR between all the inputs received in the input_vec
int nor_func(vector<int>& input_vec){
	int res = input_vec[0];

	for(int i = 1;i < input_vec.size();i++){
		res |= input_vec[i];
	}

	return !res;
}

// and_func: Computes AND between all the inputs received in the input_vec
int and_func(vector<int>& input_vec){
	int res = input_vec[0];

	for(int i = 1;i < input_vec.size();i++){
		res &= input_vec[i];
	}

	return res;
}

// nand_func: Computes NAND between all the inputs received in the input_vec
int nand_func(vector<int>& input_vec){
	int res = input_vec[0];

	for(int i = 1;i < input_vec.size();i++){
		res &= input_vec[i];
	}

	return !res;
}

// xor_func: Computes XOR between all the inputs received in the input_vec
int xor_func(vector<int>& input_vec){
	int res = input_vec[0];

	for(int i = 1;i < input_vec.size();i++){
		res ^= input_vec[i];
	}

	return res;
}

gate_operator get_gate_type(string gate_name){
	if(gate_name.find("buffer") != string::npos){
		return buffer_func;
	}
	if(gate_name.find("inv") != string::npos){
		return inv_func;
	}
	if(gate_name.find("nand") != string::npos){
		return nand_func;
	}
	if(gate_name.find("and") != string::npos){
		return and_func;
	}
	if(gate_name.find("nor") != string::npos){
		return nor_func;
	}
	if(gate_name.find("xor") != string::npos){
		return xor_func;
	}
	if(gate_name.find("or") != string::npos){
		return or_func;
	}
}

void process_gate(hcmInstance *gate,queue<hcmNode*> &event_queue){
	vector<int> input_vals;
	hcmNode *output_node;
	int output_value, old_output_value;
	gate_operator gate_func;

	map< string , hcmInstPort *>::iterator inst_port_it = gate->getInstPorts().begin();

	for(;inst_port_it != gate->getInstPorts().end();inst_port_it++){
		hcmInstPort *inst_port = (*inst_port_it).second;
		hcmNode *node = inst_port->getNode();
		if(inst_port->getPort()->getDirection() == IN){
			int val;
			node->getProp("value",val);
			input_vals.emplace_back(val);
		} else{
			output_node = node;
		}
	}
	gate->getProp("gate_type",gate_func);
	output_value = gate_func(input_vals);
	output_node->getProp("value",old_output_value);
	if(output_value != old_output_value){
		output_node->setProp("value",output_value);
		event_queue.push(output_node);
	}
}

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

		for (int argIdx = 4;argIdx < argc; argIdx++) {
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

	hcmCell *top_cell_flat = hcmFlatten(top_cell_name + "_flat",top_cell,globalNodes);

	vcdFormatter vcd(top_cell_name + ".vcd", top_cell, globalNodes);
	if (!vcd.good()) {
		printf("-E- Could not create vcdFormatter for cell: %s\n",
		       top_cell_name.c_str());
		exit(1);
	}

	queue<hcmNode*> event_queue;
	queue<hcmInstance*> gate_queue;

	map<string, hcmInstance* >::iterator gate_it = top_cell_flat->getInstances().begin();
	for(gate_it;gate_it != top_cell_flat->getInstances().end(); gate_it++){
		hcmInstance *gate = (*gate_it).second;
		gate_operator gate_type = get_gate_type(gate->getName());
		gate->setProp("gate_type",gate_type);
	}

	map<string, hcmNode* >::iterator node_it = top_cell_flat->getNodes().begin();
	for(;node_it != top_cell_flat->getNodes().end(); node_it++){
		hcmNode *node = (*node_it).second;
		node->setProp("value",0);
	}

	int t = 0;
	//Simulate vector
	while (!event_queue.empty() || !gate_queue.empty()){
		vcd.changeTime(t);
		t++;
		while (!event_queue.empty()) {
			hcmNode *node = event_queue.front();
			event_queue.pop();
			process_event(node, gate_queue);//This gets the fanout on node and pushes the gates into the gate queue
		}
		while (!gate_queue.empty()){
			hcmInstance *gate = gate_queue.front();
			gate_queue.pop();
			process_gate(gate,event_queue);//This gets the node that is pushed by the gate and adds an event if the value is changed
		}
	}



	// Outputs the results into a file
	ofstream output_file;
	output_file.open((top_cell_name + ".ranks").c_str(), fstream::out);
	output_file.close();

	delete design;
}