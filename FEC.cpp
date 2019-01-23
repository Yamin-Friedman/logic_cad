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
#include "clauses.h"
#include <signal.h>
#include <zlib.h>
#define __STDC_LIMIT_MACROS
#define __STDC_FORMAT_MACROS
#include "utils/System.h"
#include "utils/ParseUtils.h"
#include "utils/Options.h"
#include "core/Dimacs.h"
#include "core/Solver.h"

using namespace Minisat;

using namespace std;

bool verbose = false;

void find_all_FFs(hcmNode *OutNode,map<string,hcmInstance*> &FFs){

	map<string,hcmInstPort*> ports = OutNode->getInstPorts();
    map<string,hcmInstPort*>::iterator itr=ports.begin();
    hcmInstance *gate;
    bool InNode=false;

    for(;itr!=ports.end();itr++){
        if ((*itr).second->getPort()->getDirection()==OUT) {
            gate = (*itr).second->getInst();
            string name = gate->masterCell()->getName();
            if (name.find("buffer")==string::npos && (name.find("ff")!= string::npos) && FFs.find(name) == FFs.end()) {
            	string name = (*itr).second->getInst()->getName();
				FFs.insert(pair<string,hcmInstance*>(name,(*itr).second->getInst()));
            }
            break;
        }
        InNode=true; //this node is the final one - not pushed by anything
    }

    if(InNode) return; //this node is the final one - not pushed by anything

    //check on the gates pushing the node:
    map<string, hcmInstPort* > InstPorts_gate = gate->getInstPorts();
    map<string,hcmInstPort*>::iterator g_iter;
    for (g_iter=InstPorts_gate.begin();g_iter!=InstPorts_gate.end();g_iter++){
        hcmPort *port= (*g_iter).second->getPort();
        if(port->getDirection()==IN){
            //if port pushes a gate, need to traverse:
            hcmNode* node = (*g_iter).second->getNode();
            find_all_FFs(node,FFs);
        }
    }

}

vector<vector<Lit> > get_node_clauses(hcmNode* node) {
	vector<vector<Lit> > clauses;
    hcmInstance* gate;
	hcmResultTypes res;
	vector<hcmNode*> node_vec;


	bool is_PI = false;
	node->getProp("PI",is_PI);
	if (is_PI) {
		cout << "reached PI:" << node->getName() << endl;
		return clauses;
	}
	// This is a recursion breaking condition of having reached a node that we already know the clauses for. This can be
	// a PI that had its clause preset
	vector<vector<Lit> > temp_clauses;
	res = node->getProp("clauses",temp_clauses);
	if (res == OK) {
		cout << "Already calced node" << node->getName() << endl;
		cout << "size of clauses:" << temp_clauses.size() << endl;
		for (int i = 0 ; i < temp_clauses.size(); i++) {
			cout << "size of clause:" << temp_clauses[i].size() << endl;
		}
		return temp_clauses;
	}

	cout << "enter get node clauses node name:" << node->getName() << endl;
	//Find gate pushing the node (only one)
	bool undriven=true;
    map<string, hcmInstPort* > InstPorts = node->getInstPorts();
    map<string,hcmInstPort*>::iterator iter;
    for (iter=InstPorts.begin();iter!=InstPorts.end();iter++){ //go over node's instPorts
        hcmPort *port= (*iter).second->getPort();
        if(port!=NULL && port->getDirection()==OUT){ //if port pushes a gate
            gate = (*iter).second->getInst();
            if(gate!=NULL) undriven=false;
            break;
        }
    }
    if(undriven){
	    cout << "node name:" << node->getName() << endl;
    	cout<<"error: node is undriven. exiting"<<endl;
    	exit(-1);
    }

	//find the in-nodes of the gate:
	vector<int> in_vars;
    map<string, hcmInstPort* > InstPorts_gate = gate->getInstPorts();
    map<string,hcmInstPort*>::iterator g_iter;
    for (g_iter=InstPorts_gate.begin();g_iter!=InstPorts_gate.end();g_iter++){ //go over node's instPorts
        hcmPort *port= (*g_iter).second->getPort();
        //cout<<"dir is: "<<port->getDirection()<<"and name is: "<<port->getName()<<endl;
        if(port!=NULL && port->getDirection()==IN){
            //if port pushes a gate, need to get its clauses, add to in_vars:
            hcmNode* input_node = (*g_iter).second->getNode();
            int var;
	        input_node->getProp("sat var",var);
            in_vars.push_back(var);
            vector<vector<Lit> > node_clauses = get_node_clauses(input_node);
            if (!node_clauses.empty()){
                clauses.insert(clauses.end(),node_clauses.begin(),node_clauses.end());
            }

	        node_vec.push_back(input_node);
        }
    }

    //calculate this gate's clause, with the input vars collected from nodes:
    vector<vector<Lit> > curr_clause;
    int gate_var;
    gate->getProp("sat var",gate_var);
	string name = gate->masterCell()->getName();
	node_vec.push_back(node);

	if(in_vars.size()==0) {
		cout<<" handle!"<<endl;
	}
    else if(name.find("nand")!= string::npos){
        curr_clause = nand_clause(in_vars, gate_var,node_vec);
    }
    else if(name.find("and")!= string::npos){
        curr_clause = and_clause(in_vars, gate_var,node_vec);
    }
    else if(name.find("nor")!= string::npos){
        curr_clause = nor_clause(in_vars, gate_var,node_vec);
    }
    else if(name.find("or")!= string::npos){
        curr_clause = or_clause(in_vars, gate_var,node_vec);
    }
	else if(name.find("inv")!= string::npos){
		curr_clause = not_clause(in_vars[0], gate_var,node_vec);
	}
	else if(name.find("buffer")!= string::npos){
		curr_clause = buffer_clause(in_vars[0], gate_var,node_vec);
	}
	else if(name.find("xnor")!= string::npos){
		curr_clause = xnor2_clause(in_vars, gate_var,node_vec);
	}
	else if(name.find("xor")!= string::npos){
		curr_clause = xor2_clause(in_vars, gate_var,node_vec);
	}


    //finally, get final clause vec:
    clauses.insert(clauses.end(),curr_clause.begin(),curr_clause.end());
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
		    string arg= argv[i];
			if (arg == "-v") {
				verbose = true;
			} else if (arg == "-s") {
				vlgFiles_ptr = spec_vlgFiles;
				*spec_top_cell_name = argv[i + 1];
				i++;
			} else if (arg == "-i") {
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

	hcmCell *spec_cell_flat = hcmFlatten(spec_top_cell_name + "_flat",spec_top_cell,globalNodes);
	hcmCell *imp_cell_flat = hcmFlatten(imp_top_cell_name + "_flat",imp_top_cell,globalNodes);


	// The spec PI/O is first and the imp PI/O is second
	map<hcmNode*,hcmNode*> PI_map;
	map<hcmNode*,hcmNode*> PO_map;

	//save a map of top cell nodes (not flattened):
	map<string,hcmNode*> spec_top_nodes = spec_top_cell->getNodes();
	map<string,hcmNode*> imp_top_nodes = imp_top_cell->getNodes();



	// We can also set the sat var for each node here. It doesn't matter what the order of the variables are assigned in
	// as long as there is a match between primary inputs

	int var_int = 0;

	//create a map with all the nodes in the spec circuit:
	map<string,hcmInstance*> FFs;

    map<string,hcmNode*>spec_map = spec_top_cell->getNodes();
	map<string,hcmNode*>::iterator map_itr = spec_map.begin();
	for (;map_itr!= spec_map.end(); map_itr++) {
		hcmNode *spec_node = (*map_itr).second;
		if (spec_node->getPort()!=NULL){
			//traverse on each output node and find FFs (TODO:can shorten now that we have flat):
			if ((spec_node->getPort()->getDirection()) == OUT) {
				//we want to traverse on flat model:
				hcmNode* flat_spec_node = spec_cell_flat->getNode(spec_node->getName());
				find_all_FFs(flat_spec_node, FFs);
			}
		}

	}




	//Add all FFs outputs to PO map, FF inputs to PI map
	//TODO: check that FF names actually match between spec and imp!!
	map<string,hcmInstance*>::iterator itr = FFs.begin();
	for (;itr!=FFs.end();itr++){
		hcmInstance* inst  = (*itr).second;
		string inst_name = (*itr).first;
		map<string, hcmInstPort*> instPorts = inst->getInstPorts();
		map<string,hcmInstPort*>::iterator port_itr = instPorts.begin();
		for (;port_itr!=instPorts.end();port_itr++){
			hcmNode *node = (*port_itr).second->getNode();
			hcmPort* port = (*port_itr).second->getPort();
			if (port==NULL){
				continue;
			}
			else if((*port_itr).second->getPort()->getDirection()==IN && port->owner()->getName()!="CLK"){
				hcmNode *imp_node = imp_cell_flat->getNode(node->getName());
				//cout<<"found FF: "<<node->getName()<<" and it's friend: "<<imp_node->getName()<<endl;
				PO_map.insert(pair<hcmNode*,hcmNode*>(node,imp_node));
				node->setProp("sat var",var_int);
				var_int++;
				imp_node->setProp("sat var",var_int);
				var_int++;
			}
			else if((*port_itr).second->getPort()->getDirection()==OUT){
				hcmNode *imp_node = imp_cell_flat->getNode(node->getName());
				PI_map.insert(pair<hcmNode*,hcmNode*>(node,imp_node));
				node->setProp("sat var",var_int);
				node->setProp("PI",true);
				imp_node->setProp("sat var",var_int);
				imp_node->setProp("PI",true);
				var_int++;
			}

		}

	}

	//map the rest of the PO, PI and give int_vars to all nodes:
	map<string,hcmNode*>::iterator map_it = spec_cell_flat->getNodes().begin();
	for (;map_it != spec_cell_flat->getNodes().end(); map_it++) {
		hcmNode *spec_node = map_it->second;
        //first make sure this node was not already assigned by FFs:
        if((PO_map.find(spec_node)!=PO_map.end())||(PI_map.find(spec_node)!=PI_map.end())) continue;

        //if this is a true top input node:

		else if (spec_node->getPort()!=NULL &&(spec_node->getPort()->getDirection() == IN)) {
			hcmNode *imp_node = imp_cell_flat->getNode(spec_node->getName());
			PI_map.insert(pair<hcmNode*,hcmNode*>(spec_node,imp_node));
			spec_node->setProp("sat var",var_int);
			spec_node->setProp("PI",true);
			imp_node->setProp("sat var",var_int);
			imp_node->setProp("PI",true);
			var_int++;

		//if this is a true top output node:
		} else if (spec_node->getPort()!=NULL &&(spec_node->getPort()->getDirection() == OUT)) {
			hcmNode *imp_node = imp_cell_flat->getNode(spec_node->getName());
			PO_map.insert(pair<hcmNode*,hcmNode*>(spec_node,imp_node));
			spec_node->setProp("sat var",var_int);
			var_int++;
			imp_node->setProp("sat var",var_int);
			var_int++;
		} else {
			spec_node->setProp("sat var",var_int);
			var_int++;
		}

		if (spec_node->getName() == "VDD") {
			vector<vector<Lit> > clause;
			clause.push_back(vector<Lit>(1,mkLit(var_int)));
			spec_node->setProp("constant", 1);
			spec_node->setProp("clauses",clause);
			spec_node->setProp("sat var",var_int);
			imp_cell_flat->getNode(spec_node->getName())->setProp("sat var",var_int);
			imp_cell_flat->getNode(spec_node->getName())->setProp("constant", 1);
			imp_cell_flat->getNode(spec_node->getName())->setProp("clauses", clause);
			var_int++;
		}
		if (spec_node->getName() == "VSS") {
			vector<vector<Lit> > clause;
			clause.push_back(vector<Lit>(1,~mkLit(var_int)));
			spec_node->setProp("constant", 0);
			spec_node->setProp("clauses",clause);
			spec_node->setProp("sat var",var_int);
			imp_cell_flat->getNode(spec_node->getName())->setProp("sat var",var_int);
			imp_cell_flat->getNode(spec_node->getName())->setProp("constant", 0);
			imp_cell_flat->getNode(spec_node->getName())->setProp("clauses", clause);
			var_int++;
		}
	}


	//give sat var for all imp nodes not traversed:
	map_it = imp_cell_flat->getNodes().begin();
	for (;map_it != imp_cell_flat->getNodes().end(); map_it++) {
		int temp_int;
		hcmResultTypes res;
		res = map_it->second->getProp("sat var",temp_int);
		if (res == NOT_FOUND) {
			map_it->second->setProp("sat var",var_int);
			var_int++;
		}
	}


	// Loop over all the POs in the spec and imp, build clauses for them and compare with sat solver
	spec_cell_flat->createNode("dummy");

	map<hcmNode*,hcmNode*>::iterator PO_map_it = PO_map.begin();
	bool overall_equal=true;
	for (;PO_map_it != PO_map.end(); PO_map_it++) {
		bool is_equal=true;
		vector<vector<Lit> > spec_clause = get_node_clauses(PO_map_it->first);
		vector<vector<Lit> > imp_clause = get_node_clauses(PO_map_it->second);

		// sat solver
		vector<int> PO_vars;
		int var;

		vector<hcmNode*> node_vec;
		node_vec.push_back(PO_map_it->first);
		node_vec.push_back(PO_map_it->second);
		node_vec.push_back(spec_cell_flat->getNode("dummy"));

		PO_map_it->first->getProp("sat var",var);
		PO_vars.push_back(var);
		PO_map_it->second->getProp("sat var",var);
		PO_vars.push_back(var);
		vector<vector<Lit> > xor_clause = xor2_clause(PO_vars,var_int,node_vec);

		vector<vector<Lit> > clauses;
		clauses.insert(clauses.end(),spec_clause.begin(),spec_clause.end());
		clauses.insert(clauses.end(),imp_clause.begin(),imp_clause.end());
		clauses.insert(clauses.end(),xor_clause.begin(),xor_clause.end());

		int constant = -1;
		spec_cell_flat->getNode("dummy")->getProp("constant",constant);
		if (constant != -1) {
			if (constant == 0) {
				is_equal = true;
			} else if (constant == 1) {
				is_equal = false;
			}
		} else {
			cout << "enter solver for output node:" << PO_map_it->first->getName() << endl;
			Solver S;

			S.verbosity = false;
			for (int i = 0; i < var_int; i++) {
				S.newVar();
			}
			for (int i = 0; i < clauses.size(); i++) {
				vector<Lit> original = clauses[i];
				vec<Lit> newVec;
				for (int j = 0; j < original.size(); j++) {
					cout << "before push" << endl;
					Lit p;
					p.x = original[j].x;
					newVec.push(mkLit(j));
				}
				cout << "before add clause" << endl;
				S.addClause(newVec);
			}


			if (!S.solve()) {
				is_equal = true;
				cout << "The PO:" << PO_map_it->first->getName() << " is equal" << endl;
			} else {
				is_equal = false;
			}
		}
		// If a PO is not equal we should print it here
		if (!is_equal) {
			overall_equal=false;
			cout << "There is a mismatch between the output of the spec and the output of the implementation for the output node: " << PO_map_it->first->getName() << endl;
//			exit(-1);
		}

	}
	if(overall_equal) cout<<"The files match!"<<endl;
	else cout<<"The files do not match!"<<endl;

}

