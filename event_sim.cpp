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

typedef int (*gate_operator)(vector<int>&);

// This struct is used in the set of nodes to allow proper sorting based on rank and name
struct node_rank_compare {
	bool operator() (hcmNode* lhs, hcmNode* rhs) const {
		int rank1, rank2;
		lhs->getProp("rank",rank1);
		rhs->getProp("rank",rank2);
		if (rank1 > rank2)
			return true;
		else if (rank1 < rank2)
			return false;
		else {
			string name1, name2;
			name1 = lhs->getName();
			name2 = rhs->getName();
			return name1 < name2;
		}
	}
};

// This struct is used in the set of gates to allow proper sorting based on rank and name
struct gate_rank_compare {
	bool operator() (hcmInstance* lhs, hcmInstance* rhs) const {
		int rank1, rank2;
		lhs->getProp("rank",rank1);
		rhs->getProp("rank",rank2);
		if (rank1 > rank2)
			return true;
		else if (rank1 < rank2)
			return false;
		else {
			string name1, name2;
			name1 = lhs->getName();
			name2 = rhs->getName();
			return name1 < name2;
		}
	}
};

// This function checks to see if all the ports leading into this gate have been ranked allowing the rank for this gate to be decided and ranks it accordingly
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

void rank_hcm_design(hcmCell *top_cell){
	list<hcmNode*> node_list;
	list<hcmInstance*> gate_list;

	map<string,hcmNode*>::iterator NI;

	// Give a rank of 0 to all the input nodes
	for (NI = top_cell->getNodes().begin();NI != top_cell->getNodes().end();NI++){
		if ((*NI).second->getPort() && (*NI).second->getPort()->getDirection() == IN){
			(*NI).second->setProp("rank",0);
			node_list.push_back((*NI).second);
		}
	}

	// Loops until all the gates and nodes in the flat model are ranked
	while(!node_list.empty() || !gate_list.empty()){
		list<hcmNode*>::iterator NVI;
		for (NVI = node_list.begin();NVI != node_list.end();){
			map<string,hcmInstPort*>::iterator instp_MI;
			// Goes over all of the nodes that have just been ranked and checks to see if the gates attached to them can be ranked
			for (instp_MI = (*NVI)->getInstPorts().begin(); instp_MI != (*NVI)->getInstPorts().end();instp_MI++){
				hcmInstance *curr_gate = (*instp_MI).second->getInst();
				if(check_gate_can_be_ranked(*curr_gate)){
					int rank;
					curr_gate->getProp("rank",rank);
					gate_list.push_back(curr_gate);
				}
			}
			node_list.erase(NVI++);
		}
		list<hcmInstance*>::iterator inst_VI;
		for (inst_VI = gate_list.begin(); inst_VI != gate_list.end();){
			map<string,hcmInstPort*>::iterator instp_MI;
			// Loops over all the gates that have just been ranked and ranks any previously unranked nodes connected to them and adds them to the nodes list
			for (instp_MI = (*inst_VI)->getInstPorts().begin(); instp_MI != (*inst_VI)->getInstPorts().end(); instp_MI++){
				hcmNode *curr_node = (*instp_MI).second->getNode();
				int rank;
				if(curr_node->getProp("rank",rank) == NOT_FOUND){
					(*inst_VI)->getProp("rank",rank);
					curr_node->setProp("rank",rank + 1);
					node_list.push_back(curr_node);
				}
			}
			gate_list.erase(inst_VI++);
		}
	}
}

//This gets the fanout on node and pushes the gates into the gate
void process_event(hcmNode* node, priority_queue<hcmInstance*, vector<hcmInstance*>, gate_rank_compare> &gate_queue){
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

void process_gate(hcmInstance *gate,priority_queue<hcmNode*, vector<hcmNode*>, node_rank_compare> &event_queue){
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

int read_next_input(hcmSigVec &InputSigVec,set<hcmPort*> InputPorts, priority_queue<hcmNode*, vector<hcmNode*>, node_rank_compare> &event_queue) { //this function reads the next line, updates event_queue

    int res = InputSigVec.readVector();
    while (res != 0) { //will read until reaches a good line (not empty)
        if (res == -1)return res; //reached EOF
        res = InputSigVec.readVector();
    }
    bool val;
    set<hcmPort *>::const_iterator itr = InputPorts.begin();
    for (itr; itr != InputPorts.end(); itr++) {
        hcmNode *currNode = (*itr)->owner();
        if (InputSigVec.getSigValue((*itr)->getName(),val)!=0){
            //could not read signal - handle error (should not happen since signal name is from signals set
            return -1; //may need to change
        }
        currNode->setProp("value",val); //setting the value of the node. //check if handles buses properly
        event_queue.push(currNode); //add to event queue
    }
    return 0;
}

//this function updates ALL the output nodes of the design in the vcd to their current value. May need to add a check if the value has changed
void checkOutputs(set<hcmNode*> &outputNodes, vcdFormatter &vcd, map<string, hcmNodeCtx*> &outputCtx){
    set<hcmNode*>::const_iterator itr = outputNodes.begin();
    int currVal;
    for (itr;itr!=outputNodes.end();itr++){
        (*itr)->getProp("value",currVal);
        hcmNodeCtx* ctx = outputCtx.at((*itr)->getName());
        vcd.changeValue(ctx,(bool)currVal);
    }
}

//This function recieves a node , checks if one of design output nodes and if so updates VCD
/*void EventIsOutput(hcmNode* currOutNode, set<hcmNode*> outputNodes, vcdFormatter vcd, map<string, hcmNodeCtx*> outputCtx){
    int Val;
    if(outputNodes.find(currOutNode)!=outputNodes.end()){ //this really is an output node
        currOutNode->getProp("value",Val);
        hcmNodeCtx* ctx = outputCtx.at(currOutNode->getName());
        vcd.changeValue(ctx,(bool)Val); //update VCD
    }
}*/

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


	///prepare VCD:///
	vcdFormatter vcd(top_cell_name + ".vcd", top_cell, globalNodes);
	if (!vcd.good()) {
		printf("-E- Could not create vcdFormatter for cell: %s\n",
		       top_cell_name.c_str());
		exit(1);
	}
    vector<hcmPort*> top_ports = top_cell->getPorts();
    vector<hcmPort*>::const_iterator pitr = top_ports.begin();
    list<const hcmInstance *> parents; //keep parents empty for top - per instructions on hcmvcd/main
    set<hcmNode*> outputsNodes; //the set keeps the nodes connected to outputs for easier checks
    map<string, hcmNodeCtx*> outputCtx; //the map contains the node names and ctx for easier access to vcd
    for (pitr;pitr!=top_ports.end();pitr++){
        if(((*pitr)->getDirection())==OUT){  //ports on top cell that are "OUT" should be outputs(?)
            hcmNodeCtx *ctx = new hcmNodeCtx(parents,(*pitr)->owner());
            outputCtx[(*pitr)->owner()->getName()]=ctx; //the map contains the node names and ctx for easier access to vcd
            outputsNodes.insert((*pitr)->owner()); //the set keeps the nodes connected to outputs for easier checks
        }
    }
    ///done with VCD///

	///Ranks all the nodes and gates in the flattened design to aid in processing in the right order
	rank_hcm_design(top_cell_flat);

    priority_queue<hcmNode*, vector<hcmNode*>, node_rank_compare> event_queue;
	priority_queue<hcmInstance*, vector<hcmInstance*>, gate_rank_compare> gate_queue;


	//parse signals input:
	hcmSigVec InputSigVec(argv[2],argv[3],verbose);
	if (!InputSigVec.good()){
	    //message was already printed while parsing
	    exit(1);
	}
    int res=InputSigVec.readVector();
	while(res!=0){ //will read until reaches a good line (not empty)
	    if (res==-1) exit(0); //reached EOF //CHECK
	    res = InputSigVec.readVector();
	}
	vector<hcmPort*> ports = top_cell_flat->getPorts();
	set<hcmPort*> InputPorts;
    set< string > signals;
    bool val;
    int numOfSignals = InputSigVec.getSignals(signals);
    if (numOfSignals!=0){
        vector<hcmPort*>::const_iterator itr = ports.begin();
        for (itr;itr!=ports.end();itr++){
            if (signals.find((*itr)->getName())!=signals.end() && (*itr)->getDirection()==IN){  //found the signal. checking direction for safety
                InputPorts.insert(*itr);
                hcmNode *currNode = (*itr)->owner();
                if (InputSigVec.getSigValue((*itr)->getName(),val)!=0){
                    //could not read signal - handle error (should not happen since signal name is from signals set
                   //if decide not to handle - delete 'if'
                }
                else{
                    currNode->setProp("value",val); //setting the value of the node. //check if handles buses properly
                    event_queue.push(currNode); //add to event queue
                }

            }
        }
    }



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
	while (read_next_input(InputSigVec,InputPorts,event_queue)!=-1){
	    //simulate:
        while (!event_queue.empty() || !gate_queue.empty()){
            vcd.changeTime(t);
            t++;
            while (!event_queue.empty()) {
                hcmNode *node = event_queue.top();
                event_queue.pop();
                process_event(node, gate_queue);//This gets the fanout on node and pushes the gates into the gate queue
            }
            while (!gate_queue.empty()){
                hcmInstance *gate = gate_queue.top();
                gate_queue.pop();
                process_gate(gate,event_queue);//This gets the node that is pushed by the gate and adds an event if the value is changed
            }

        }
        //check outputs:
        checkOutputs(outputsNodes,vcd,outputCtx);
	}






	/* Outputs the results into a file
	ofstream output_file;
	output_file.open((top_cell_name + ".ranks").c_str(), fstream::out);
	output_file.close();
	 */

	delete design;
}