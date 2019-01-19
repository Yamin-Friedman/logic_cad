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
        if (((*itr).second->getPort()->getDirection()==OUT) {
            gate = (*itr).second->getInst();
            string name = gate->getName();
            if (name.find("FF") && FFs.find(name) == map.end()) {
                FFs.insert<(*itr).second->getInst()->getName(), (*itr).second->getInst()>;
            }
            break;
        }
        InNode=true; //this node is the final one - not pushed by anything
    }

    if(InNode) return; //this node is the final one - not pushed by anything

    //check on the gates pushing the node:
    map<string, hcmInstPort* > InstPorts_gate = gate->getInstPorts();
    map<string,hcmInstPort*>::iterator g_iter;
    for (g_iter=InstPorts.begin();g_iter!=InstPorts.end();g_iter++){
        hcmPort *port= (*g_iter).second->getPort();
        if(port->getDirection()==IN){
            //if port pushes a gate, need to traverse:
            hcmNode* node = (*g_iter).second->getNode();
            find_all_FFs(node,FFs);
        }
    }

}

vector<vector<Lit>> get_node_clauses(hcmNode* node) {
	vector<vector<Lit>> clauses;
    hcmInstance* gate;
	hcmResultTypes res;

	// This is a recursion breaking condition of having reached a node that we already know the clauses for. This can be
	// a PI that had its clause preset
	res = node->getProp("clauses",clauses);
	if (res == OK) {
		return clauses;
	}

	//Find gate pushing the node (only one)
    map<string, hcmInstPort* > InstPorts = node->getInstPorts();
    map<string,hcmInstPort*>::iterator iter;
    for (iter=InstPorts.begin();iter!=InstPorts.end();iter++){ //go over node's instPorts
        hcmPort *port= (*iter).second->getPort();
        if(port->getDirection()==OUT){ //if port pushes a gate
            gate = (*iter).second->getInst();
            break;
        }
    }

	//find the in-nodes of the gate:
	vector<int> in_vars;
    map<string, hcmInstPort* > InstPorts_gate = gate->getInstPorts();
    map<string,hcmInstPort*>::iterator g_iter;
    for (g_iter=InstPorts.begin();g_iter!=InstPorts.end();g_iter++){ //go over node's instPorts
        hcmPort *port= (*g_iter).second->getPort();
        if(port->getDirection()==IN){
            //if port pushes a gate, need to get its clauses, add to in_vars:
            hcmNode* input_node = (*g_iter).second->getNode();
            int var;
	        input_node->getProp("sat var",var);
            in_vars.push_back(var);
            vector<vector<Lit>> node_clauses = get_node_clauses(input_node);
            if (!node_clauses.empty()){
                clauses.insert(clauses.end(),node_clauses.begin(),node_clauses.end());
            }
        }
    }

    //calculate this gate's clause, with the input vars collected from nodes:
    vector<vector<Lit>> curr_clause;
    int gate_var;
    gate->getProp("sat var",gate_var);
	string name = gate->getName();

    if(name.find("nand")){
        curr_clause = nand_clause(in_vars, gate_var);
    }
    if(name.find("and")){
        curr_clause = and_clause(in_vars, gate_var);
    }
    if(name.find("nor")){
        curr_clause = nor_clause(in_vars, gate_var);
    }
    if(name.find("or")){
        curr_clause = or_clause(in_vars, gate_var);
    }
	if(name.find("not")){
		curr_clause = not_clause(in_vars[0], gate_var);
	}
	if(name.find("buffer")){
		curr_clause = buffer_clause(in_vars[0], gate_var);
	}
	if(name.find("xnor")){
		curr_clause = xnor2_clause(in_vars, gate_var);
	}
	if(name.find("xor")){
		curr_clause = xor2_clause(in_vars, gate_var);
	}

	// This is the case if the output of the gate is a constant. The variable name is no longer relevant because all
	// we need to know is the constant value.
    if (curr_clause[0][0] == 0 || curr_clause[0][0] == -1) {// Not sure if this will still work with Lit values
	    node->setProp("sat var",curr_clause[0][0]);
	    node->setProp("clauses",curr_clause);
	    return curr_clause;
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



	// We can also set the sat var for each node here. It doesn't matter what the order of the variables are assigned in
	// as long as there is a match between primary inputs

	int var_int = 1;

	//create a map with all the nodes in the spec circuit:
	map<string,hcmInstance*> FFs;

	map<string,hcmNode*>::iterator map_itr = spec_top_cell->getNodes().begin();
	for (;map_itr != spec_top_cell->getNodes().end(); map_itr++) {
		hcmNode *spec_node = map_itr->second;
		if (spec_node->getPort()->getDirection() == OUT) {
			find_all_FFs(spec_node, FFs);
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
			if((*port_itr).second->getPort()->getDirection()==OUT){
				hcmNode *imp_node = imp_top_cell->getNode(node->getName());
				PO_map.insert(pair<hcmNode*,hcmNode*>(node,imp_node));
				node->setProp("sat var",var_int);
				vector<vector<int>> clause;
				clause.push_back(vector<int>(var_int));
				node->setProp("clauses",clause);
				imp_node->setProp("sat var",var_int);
				imp_node->setProp("clauses",clause);
				var_int++;
			}
			else if((*port_itr).second->getPort()->getDirection()==IN){
				hcmNode *imp_node = imp_top_cell->getNode(node->getName());
				PI_map.insert(pair<hcmNode*,hcmNode*>(node,imp_node));
				node->setProp("sat var",var_int);
				vector<vector<int>> clause;
				clause.push_back(vector<int>(var_int));
				node->setProp("clauses",clause);
				imp_node->setProp("sat var",var_int);
				imp_node->setProp("clauses",clause);
				var_int++;
			}

		}

	}

	//map the rest of the PO, PI and give int_vars to all nodes:
	map<string,hcmNode*>::iterator map_it = spec_top_cell->getNodes().begin();
	for (;map_it != spec_top_cell->getNodes().end(); map_it++) {
		hcmNode *spec_node = map_it->second;
		if (spec_node->getPort()->getDirection() == IN) {
			hcmNode *imp_node = imp_top_cell->getNode(spec_node->getName());
			PI_map.insert(pair<hcmNode*,hcmNode*>(spec_node,imp_node));
			spec_node->setProp("sat var",var_int);
			vector<vector<int>> clause;
			clause.push_back(vector<int>(1,var_int));
			spec_node->setProp("clauses",clause);
			imp_node->setProp("sat var",var_int);
			imp_node->setProp("clauses",clause);
			var_int++;
		} else if ((*map_it).second->getPort()->getDirection() == OUT) {
			hcmNode *imp_node = imp_top_cell->getNode(spec_node->getName());
			PO_map.insert(pair<hcmNode*,hcmNode*>((*map_it).second,imp_top_cell->getNode((*map_it).second->getName())));
			map_it->second->setProp("sat var",var_int);
			imp_top_cell->getNode(map_it->second->getName())->setProp("sat var",var_int);
			vector<vector<int>> clause;
			clause.push_back(vector<int>(1,var_int));
			spec_node->setProp("clauses",clause);
			var_int++;
			clause[0] = vector<int>(1,var_int);
			imp_node->setProp("sat var",var_int);
			imp_node->setProp("clauses",clause);
			var_int++;
		} else {
			map_it->second->setProp("sat var",var_int);
			var_int++;
		}

		if ((*map_it).second->getName() == "VDD") {
			vector<vector<int>> clause;
			clause.push_back(vector<int>(1,-1));
			(*map_it).second->setProp("constant", 1);
			map_it->second->setProp("clauses",clause);// -1 is a special value that means the node is a constant 1
			imp_top_cell->getNode((*map_it).second->getName())->setProp("constant", 1);
		}
		if ((*map_it).second->getName() == "VSS") {
			vector<vector<int>> clause;
			clause.push_back(vector<int>(1,0));
			(*map_it).second->setProp("constant", 0);
			map_it->second->setProp("clauses",clause);// 0 is a special value that means the node is a constant 0
			imp_top_cell->getNode((*map_it).second->getName())->setProp("constant", 0);
		}
	}


	map_it = imp_top_cell->getNodes().begin();
	for (;map_it != imp_top_cell->getNodes().end(); map_it++) {
		int temp_int;
		hcmResultTypes res;
		res = map_it->second->getProp("sat var",temp_int);
		if (res == NOT_FOUND) {
			map_it->second->setProp("sat var",var_int);
			var_int++;
		}
	}


	// Loop over all the POs in the spec and imp, build clauses for them and compare with sat solver

	map<hcmNode*,hcmNode*>::iterator PO_map_it = PO_map.begin();
	for (;PO_map_it != PO_map.end(); PO_map_it++) {
		bool is_equal;

		vector<vector<Lit>> spec_clause = get_node_clauses(PO_map_it->first);
		vector<vector<Lit>> imp_clause = get_node_clauses(PO_map_it->second);

		// This should handle the special case where one of the outputs is a constant.
		if (spec_clause[0][0] == 0 || spec_clause[0][0] == -1 || imp_clause[0][0] == 0 || imp_clause[0][0]) {
			if (spec_clause[0][0] == imp_clause[0][0]) {
				is_equal = true;
			} else {
				is_equal = false;
			}
		} else { // sat solver
			vector<int> PO_vars;
			int var;
			PO_map_it->first->getProp("sat var",var);
			PO_vars.push_back(var);
			PO_map_it->second->getProp("sat var",var);
			PO_vars.push_back(var);
			vector<vector<Lit>> xnor_clause = xnor2_clause(PO_vars,var_int);

			vector<vector<Lit>> clauses;
			clauses.insert(clauses.end(),spec_clause.begin(),spec_clause.end());
			clauses.insert(clauses.end(),imp_clause.begin(),imp_clause.end());
			clauses.insert(clauses.end(),xnor_clause.begin(),xnor_clause.end());

			Solver S;

			S.verbosity = false;
			for (int i = 2; i < var_int; i++) {
				S.newVar();
			}
			for (int i = 0; i < clauses.size(); i++) {
				S.addClause(clauses[i]);
			}
			if (!S.simplify()) {
				is_equal == false;
			} else {
				is_equal == true;
			}
			if (!S.solve()) {
				is_equal == false;
			} else {
				is_equal == true;
			}
		}

		// If a PO is not equal we should print it here
		if (!is_equal) {
			cout << "There is a mismatch between the output of the spec and the output of the implementation for the output node: " << PO_map_it->first->getName() << endl;
		}

	}


}

