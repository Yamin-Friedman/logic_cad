#include <sstream>
#include <fstream>
#include <set>
#include <algorithm>
#include <list>
#include <queue>
#include <map>
#include "hcm.h"
#include "flat.h"
#include "hcmsigvec.h"
#include "hcmvcd.h"

using namespace std;

bool verbose = false;

typedef bool (*gate_operator)(vector<bool>&);

//This gets the fanout on node and pushes the gates into the gate
void process_event(hcmNode* node, queue<hcmInstance*> &gate_queue){
	map<string, hcmInstPort* > InstPorts = node->getInstPorts();
	if(InstPorts.empty())
		return;
	map<string,hcmInstPort*>::const_iterator iter;
	for (iter=InstPorts.begin();iter!=InstPorts.end();iter++){ //go over node's instPorts
		hcmPort *port= (*iter).second->getPort();
		if(port->getDirection()==IN){ //if port pushes a gate
		    hcmInstance* curr_gate = (*iter).second->getInst();
		    gate_queue.push(curr_gate);
		}
	}
}

// inv_func: Inverts the input
bool inv_func(vector<bool>& input_vec){
	int res = input_vec[0];

	return !res;
}

// buffer_func: returns the input
bool buffer_func(vector<bool>& input_vec){
	int res = input_vec[0];

	return res;
}

// or_func: Computes OR between all the inputs received in the input_vec
bool or_func(vector<bool>& input_vec){
	int res = input_vec[0];

	for(int i = 1;i < input_vec.size();i++){
		res |= input_vec[i];
	}

	return res;
}

// nor_func: Computes NOR between all the inputs received in the input_vec
bool nor_func(vector<bool>& input_vec){
	int res = input_vec[0];

	for(int i = 1;i < input_vec.size();i++){
		res |= input_vec[i];
	}

	return !res;
}

// and_func: Computes AND between all the inputs received in the input_vec
bool and_func(vector<bool>& input_vec){
	int res = input_vec[0];

	for(int i = 1;i < input_vec.size();i++){
		res &= input_vec[i];
	}

	return res;
}

// nand_func: Computes NAND between all the inputs received in the input_vec
bool nand_func(vector<bool>& input_vec){
	int res = input_vec[0];

	for(int i = 1;i < input_vec.size();i++){
		res &= input_vec[i];
	}

	return !res;
}

// xor_func: Computes XOR between all the inputs received in the input_vec
bool xor_func(vector<bool>& input_vec){
	int res = input_vec[0];

	for(int i = 1;i < input_vec.size();i++){
		res ^= input_vec[i];
	}

	return res;
}

// FF_func:
bool FF_func(vector<bool>& input_vec){
	if (input_vec[1] == true){
		return input_vec[0];
	} else {
		return input_vec[2];
	}
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
	if(gate_name.find("ff") != string::npos){
		return FF_func;
	}
}

void handle_FF_NOR_loop(hcmInstance *first_NOR, hcmInstance *second_NOR, queue<hcmInstance*> &gate_queue){

	// We must find out which is the output NOR
	hcmInstance *output_NOR = first_NOR;
	hcmInstance *inner_NOR = second_NOR;
	map< string , hcmInstPort *>::iterator inst_port_it = first_NOR->getInstPorts().begin();
	for(;inst_port_it != first_NOR->getInstPorts().end();inst_port_it++) {
		hcmInstPort *inst_port = (*inst_port_it).second;
		hcmNode *node = inst_port->getNode();
		if(inst_port->getPort()->getDirection() == OUT){
			if (node->getInstPorts().size() > 2) {
				break;
			}
			else {
				output_NOR = second_NOR;
				inner_NOR = first_NOR;
			}
		}
	}

	// Handle the loop and push output gates to the gate queue
	second_NOR->setProp("handled",true);
	// get inputs
	vector<bool> first_input_vals, second_input_vals;

	inst_port_it = first_NOR->getInstPorts().begin();
	for(;inst_port_it != first_NOR->getInstPorts().end();inst_port_it++){
		hcmInstPort *inst_port = (*inst_port_it).second;
		hcmNode *node = inst_port->getNode();
		if(inst_port->getPort()->getDirection() == IN){
			bool val;
			node->getProp("value",val);
			first_input_vals.emplace_back(val);
		}
	}

	inst_port_it = second_NOR->getInstPorts().begin();
	for(;inst_port_it != second_NOR->getInstPorts().end();inst_port_it++){
		hcmInstPort *inst_port = (*inst_port_it).second;
		hcmNode *node = inst_port->getNode();
		if(inst_port->getPort()->getDirection() == IN){
			bool val;
			node->getProp("value",val);
			second_input_vals.emplace_back(val);
		}
	}

	int out_1 = nor_func(first_input_vals);
	int out_2 = nor_func(second_input_vals);


}

// This function checks to see if we have a NOR loop such as appears only in the FF model and returns the second NOR if true.
hcmInstance *is_FF_NOR(hcmInstance *gate) {
	hcmNode *output_node;
	hcmInstance *second_NOR = NULL;
	gate_operator gate_func;

	map< string , hcmInstPort *>::iterator inst_port_it = gate->getInstPorts().begin();
	for(;inst_port_it != gate->getInstPorts().end();inst_port_it++) {
		hcmInstPort *inst_port = (*inst_port_it).second;
		hcmNode *node = inst_port->getNode();
		if(inst_port->getPort()->getDirection() == OUT){
			output_node = node;
			break;
		}
	}

	inst_port_it = output_node->getInstPorts().begin();
	for(;inst_port_it != output_node->getInstPorts().end();inst_port_it++) {
		hcmInstPort *inst_port = (*inst_port_it).second;
		hcmInstance *gate_tmp = inst_port->getInst();
		if(inst_port->getPort()->getDirection() == OUT){
			gate_tmp->getProp("gate_type",gate_func);
			if (gate_func == nor_func){
				second_NOR = gate_tmp;
			}
		}
	}

	if (second_NOR == NULL){
		return NULL;
	}

	inst_port_it = second_NOR->getInstPorts().begin();
	for(;inst_port_it != second_NOR->getInstPorts().end();inst_port_it++) {
		hcmInstPort *inst_port = (*inst_port_it).second;
		hcmNode *node = inst_port->getNode();
		if(inst_port->getPort()->getDirection() == OUT){
			output_node = node;
			break;
		}
	}

	inst_port_it = output_node->getInstPorts().begin();
	for(;inst_port_it != output_node->getInstPorts().end();inst_port_it++) {
		hcmInstPort *inst_port = (*inst_port_it).second;
		hcmInstance *gate_tmp = inst_port->getInst();
		if(inst_port->getPort()->getDirection() == OUT){
			gate_tmp->getProp("gate_type",gate_func);
			if (gate_func == nor_func){
				if (gate_tmp == gate){
					return second_NOR;
				}
			}
		}
	}

	return NULL;
}

void process_gate(hcmInstance *gate,queue<hcmNode*> &event_queue, queue<hcmInstance*> &gate_queue){
	vector<bool> input_vals;
	hcmNode *output_node;
	bool output_value, old_output_value;
	gate_operator gate_func;
	gate->getProp("gate_type",gate_func);
	input_vals.resize(3);

	map< string , hcmInstPort *>::iterator inst_port_it = gate->getInstPorts().begin();

	for(;inst_port_it != gate->getInstPorts().end();inst_port_it++){
		hcmInstPort *inst_port = (*inst_port_it).second;
		hcmNode *node = inst_port->getNode();
		bool val;
		if(inst_port->getPort()->getDirection() == IN){
			node->getProp("value",val);
			if (gate_func == FF_func){
				hcmPort *port = inst_port->getPort();
				hcmNode *port_node = port->owner();
				if (port_node->getName() == "D"){
					input_vals[0] = val;
				} else if ( port_node->getName() == "CLK") {
					input_vals[1] = val;
				}
				continue;
			}
			input_vals.emplace_back(val);
		} else{
			output_node = node;
			if (gate_func == FF_func) {
				node->getProp("value",val);
				input_vals[2] = val;
			}
		}
	}

	if (gate_func == nor_func) {
		bool handled;
		if(gate->getProp("handled",handled) == OK && handled == true) {
			gate->setProp("handled",false);
			return;
		}
		hcmInstance *second_NOR = is_FF_NOR(gate);
		if (second_NOR != NULL){
			handle_FF_NOR_loop(gate,second_NOR,gate_queue);
			return;
		}
	}
	output_value = gate_func(input_vals);
	output_node->getProp("value", old_output_value);
	if (output_value != old_output_value) {
		output_node->setProp("value", output_value);
		event_queue.push(output_node);
	}
}

int read_next_input(hcmSigVec &InputSigVec,set<hcmNode*> InputNodes, queue<hcmNode*> &event_queue) { //this function reads the next line, updates event_queue

    int res = InputSigVec.readVector();
    while (res != 0) { //will read until reaches a good line (not empty)
        if (res == -1)return res; //reached EOF
        res = InputSigVec.readVector();
    }
    bool val;
	bool prev_val;
    set<hcmNode *>::const_iterator itr = InputNodes.begin();
    for (itr; itr != InputNodes.end(); itr++) {
        hcmNode *currNode = (*itr);
        if (InputSigVec.getSigValue((*itr)->getName(),val)!=0){
            //could not read signal - handle error (should not happen since signal name is from signals set
            return -1; //may need to change
        }
	    currNode->getProp("value",prev_val);
        currNode->setProp("value",val); //setting the value of the node.
        event_queue.push(currNode); //add to event queue
    }
    return 0;
}

//this function updates ALL the output nodes of the design in the vcd to their current value. May need to add a check if the value has changed
void checkOutputs(set<hcmNode*> &outputNodes, vcdFormatter &vcd, map<string, hcmNodeCtx*> &outputCtx){
    set<hcmNode*>::const_iterator itr = outputNodes.begin();
    bool currVal;
	bool prevVal;
    for (itr;itr!=outputNodes.end();itr++){
        (*itr)->getProp("value",currVal);
	    (*itr)->getProp("prev value",prevVal);
        hcmNodeCtx* ctx = outputCtx.at((*itr)->getName());
	    if (currVal != prevVal) {
		    vcd.changeValue(ctx, currVal);
		    (*itr)->setProp("prev val",currVal);
	    }
    }
}


int main(int argc, char **argv) {
	int anyErr = 0;
	unsigned int i;
	vector<string> vlgFiles;
	string top_cell_name;

	// Parse input
//	if (argc < 4) {
//		anyErr++;
//	} else {
//		top_cell_name = argv[1];
//
//		for (int argIdx = 4;argIdx < argc; argIdx++) {
//			vlgFiles.push_back(argv[argIdx]);
//		}
//
//		if (vlgFiles.size() < 1) {
//			cerr << "-E- At least top-level and single verilog file required for spec model" << endl;
//			anyErr++;
//		}
//	}
//
//	if (anyErr) {
//		cerr << "Usage: " << argv[0] << "  [-v] top-cell file1.v [file2.v] ... \n";
//		exit(1);
//	}

	cin >> top_cell_name;
	string sig1;
	cin >> sig1;
	string sig2;
	cin >> sig2;
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
		if (!design->parseStructuralVerilog(vlgFiles[i].c_str())) {
			cerr << "-E- Could not parse: " << vlgFiles[i] << " aborting." << endl;
			exit(1);
		}
	}


	hcmCell *top_cell = design->getCell(top_cell_name);

	hcmCell *top_cell_flat = hcmFlatten(top_cell_name + "_flat",top_cell,globalNodes);


	///prepare VCD:///
	vcdFormatter vcd(top_cell_name + ".vcd", top_cell_flat, globalNodes);
	if (!vcd.good()) {
		printf("-E- Could not create vcdFormatter for cell: %s\n",
		       top_cell_name.c_str());
		exit(1);
	}
	map<string, hcmNode*> top_nodes = top_cell->getNodes();
	map<string, hcmNode*>::const_iterator pitr = top_nodes.begin();
    list<const hcmInstance *> parents; //keep parents empty for top - per instructions on hcmvcd/main
    set<hcmNode*> outputsNodes; //the set keeps the nodes connected to outputs for easier checks
    map<string, hcmNodeCtx*> outputCtx; //the map contains the node names and ctx for easier access to vcd
    for (pitr;pitr!=top_nodes.end();pitr++){
	    if (globalNodes.find((*pitr).second->getName()) != globalNodes.end())
		    continue;
	    hcmNodeCtx *ctx = new hcmNodeCtx(parents,top_cell_flat->getNode((*pitr).second->getName()));
	    outputCtx[(*pitr).second->getName()]=ctx; //the map contains the node names and ctx for easier access to vcd
	    outputsNodes.insert(top_cell_flat->getNode((*pitr).second->getName())); //the set keeps the nodes connected to outputs for easier checks
    }

    ///done with VCD///

    queue<hcmNode*> event_queue;
    queue<hcmInstance*> gate_queue;


	//parse signals input:
//	hcmSigVec InputSigVec(argv[2],argv[3],verbose); // temp
	hcmSigVec InputSigVec(sig1,sig2,verbose);
	if (!InputSigVec.good()){
	    //message was already printed while parsing
	    exit(1);
	}
//    int res=InputSigVec.readVector();
//	while(res!=0){ //will read until reaches a good line (not empty)
//	    if (res==-1) exit(0); //reached EOF //CHECK
//	    res = InputSigVec.readVector();
//	}
	vector<hcmPort*> ports = top_cell_flat->getPorts();
	set<hcmNode*> InputNodes;
    set< string > signals;
    bool val;
    int numOfSignals = InputSigVec.getSignals(signals);
    if (numOfSignals!=0){
	    set<string>::iterator it = signals.begin();
	    for (it; it != signals.end(); it++){
		    InputNodes.insert(top_cell_flat->getNodes()[(*it)]);
	    }
//        vector<hcmPort*>::const_iterator itr = ports.begin();
//        for (itr;itr!=ports.end();itr++){
//            if (signals.find((*itr)->getName())!=signals.end() && (*itr)->getDirection()==IN){  //found the signal. checking direction for safety
//                InputPorts.insert(*itr);
//                hcmNode *currNode = (*itr)->owner();
//                if (InputSigVec.getSigValue((*itr)->getName(),val)!=0){
//                    //could not read signal - handle error (should not happen since signal name is from signals set
//                   //if decide not to handle - delete 'if'
//                }
//                else{
//                    currNode->setProp("value",val); //setting the value of the node.
//	                currNode->setProp("prev value",val);
//                    event_queue.push(currNode); //add to event queue
//                }

    }



	map<string, hcmInstance* >::iterator gate_it = top_cell_flat->getInstances().begin();
	for(gate_it;gate_it != top_cell_flat->getInstances().end(); gate_it++){
		hcmInstance *gate = (*gate_it).second;
		gate_operator gate_type = get_gate_type(gate->masterCell()->getName());
		gate->setProp("gate_type",gate_type);
	}

	map<string, hcmNode* >::iterator node_it = top_cell_flat->getNodes().begin();
	for(;node_it != top_cell_flat->getNodes().end(); node_it++){
		hcmNode *node = (*node_it).second;
		if (globalNodes.find(node->getName()) != globalNodes.end())
			continue;
		node->setProp("value", false);
		node->setProp("prev value", false);
		hcmNodeCtx* ctx = outputCtx.at(node->getName());
		vcd.changeValue(ctx,false);
	}

	int t = 1;
	//Simulate vector
	while (read_next_input(InputSigVec,InputNodes,event_queue)!=-1){
	    //simulate:
        while (!event_queue.empty() || !gate_queue.empty()){
            while (!event_queue.empty()) {
                hcmNode *node = event_queue.front();
                event_queue.pop();
                process_event(node, gate_queue);//This gets the fanout on node and pushes the gates into the gate queue
            }
            while (!gate_queue.empty()){
                hcmInstance *gate = gate_queue.front();
                gate_queue.pop();
                process_gate(gate,event_queue, gate_queue);//This gets the node that is pushed by the gate and adds an event if the value is changed
            }
        }
        //check outputs:
		vcd.changeTime(t);
		t++;
        checkOutputs(outputsNodes,vcd,outputCtx);

	}

//	delete design;
}