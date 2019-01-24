#include "clauses.h"

using namespace std;

using namespace Minisat;

// This function calculates the clauses for buffers. The node_vec is needed to support handling of constants.
vector<vector<Lit> > buffer_clause(int input_var, int output_var, vector<hcmNode*> &node_vec) {
	vector<vector<Lit> > clauses;
	int constant = -1;
	node_vec[0]->getProp("constant",constant);

	if (constant == 0) {
		clauses.push_back(vector<Lit>(1,~mkLit(output_var)));
		node_vec[1]->setProp("constant",0);
	} else if (constant == 1) {
		clauses.push_back(vector<Lit>(1,mkLit(1)));
		node_vec[1]->setProp("constant",1);
	} else {
		vector<Lit> pos_clause;
		pos_clause.push_back(mkLit(input_var));
		pos_clause.push_back(~mkLit(output_var));
		vector<Lit> neg_clause;
		neg_clause.push_back(~mkLit(input_var));
		neg_clause.push_back(mkLit(output_var));
		clauses.push_back(pos_clause);
		clauses.push_back(neg_clause);
	}

	return clauses;
}

// This function calculates the clauses for inverters. The node_vec is needed to support handling of constants.
vector<vector<Lit> > not_clause(int input_var, int output_var, vector<hcmNode*> &node_vec) {
	vector<vector<Lit> > clauses;
	int constant = -1;
	node_vec[0]->getProp("constant",constant);

	if (constant == 0) {
		clauses.push_back(vector<Lit>(1,mkLit(output_var)));
		node_vec[1]->setProp("constant",1);
	} else if (constant == 1) {
		clauses.push_back(vector<Lit>(1,~mkLit(1)));
		node_vec[1]->setProp("constant",0);
	} else {
		vector<Lit> pos_clause;
		pos_clause.push_back(mkLit(input_var));
		pos_clause.push_back(mkLit(output_var));
		vector<Lit> neg_clause;
		neg_clause.push_back(~mkLit(input_var));
		neg_clause.push_back(~mkLit(output_var));
		clauses.push_back(pos_clause);
		clauses.push_back(neg_clause);
	}

	return clauses;
}

// This function calculates the clauses for and. The node_vec is needed to support handling of constants.
vector<vector<Lit> > and_clause(vector<int> input_var, int output_var, vector<hcmNode*> &node_vec) {
	vector<vector<Lit> > clauses;
	vector<Lit> sum_clause(1,mkLit(output_var));
	int constant = -1;

	for (int i = 0; i < input_var.size(); i++) {
		node_vec[i]->getProp("constant",constant);

		if (constant == 0) {
			node_vec[node_vec.size() - 1]->setProp("constant",0);
			return vector<vector<Lit> >(1,vector<Lit>(1,~mkLit(output_var)));
		} else if (constant == 1) {
			continue;
		} else {
			sum_clause.push_back(~mkLit(input_var[i]));
			vector<Lit> clause;
			clause.push_back(~mkLit(output_var));
			clause.push_back(mkLit(input_var[i]));
			clauses.push_back(clause);
		}

		constant = -1;
	}

	clauses.push_back(sum_clause);

	return clauses;
}

// This function calculates the clauses for nand. The node_vec is needed to support handling of constants.
vector<vector<Lit> > nand_clause(vector<int> input_var, int output_var, vector<hcmNode*> &node_vec) {
	vector<vector<Lit> > clauses;
	vector<Lit> sum_clause(1,~mkLit(output_var));
	int constant = -1;

	for (int i = 0; i < input_var.size(); i++) {
		node_vec[i]->getProp("constant",constant);

		if (constant == 0) {
			node_vec[node_vec.size() - 1]->setProp("constant",1);
			return vector<vector<Lit> >(1,vector<Lit>(1,mkLit(output_var)));
		} else if (constant == 1) {
			continue;
		} else {
			sum_clause.push_back(~mkLit(input_var[i]));
			vector<Lit> clause;
			clause.push_back(mkLit(output_var));
			clause.push_back(mkLit(input_var[i]));
			clauses.push_back(clause);
		}

		constant = -1;
	}

	clauses.push_back(sum_clause);

	return clauses;
}

// This function calculates the clauses for or. The node_vec is needed to support handling of constants.
vector<vector<Lit> > or_clause(vector<int> input_var, int output_var, vector<hcmNode*> &node_vec) {
	vector<vector<Lit> > clauses;
	vector<Lit> sum_clause(1,~mkLit(output_var));
	int constant = -1;

	for (int i = 0; i < input_var.size(); i++) {
		node_vec[i]->getProp("constant",constant);

		if (constant == 1) {
			node_vec[node_vec.size() - 1]->setProp("constant",1);
			return vector<vector<Lit> >(1,vector<Lit>(1,mkLit(output_var)));
		} else if (constant == 0) {
			continue;
		} else {
			sum_clause.push_back(mkLit(input_var[i]));
			vector<Lit> clause;
			clause.push_back(mkLit(output_var));
			clause.push_back(~mkLit(input_var[i]));
			clauses.push_back(clause);
		}

		constant = -1;
	}

	clauses.push_back(sum_clause);

	return clauses;
}

// This function calculates the clauses for nor. The node_vec is needed to support handling of constants.
vector<vector<Lit> > nor_clause(vector<int> input_var, int output_var, vector<hcmNode*> &node_vec) {
	vector<vector<Lit> > clauses;
	vector<Lit> sum_clause(1,mkLit(output_var));
	int constant = -1;

	for (int i = 0; i < input_var.size(); i++) {
		node_vec[i]->getProp("constant",constant);

		if ( constant == 1) {
			node_vec[node_vec.size() - 1]->setProp("constant",0);
			return vector<vector<Lit> >(1,vector<Lit>(1,~mkLit(output_var)));
		} else if (constant == 1) {
			continue;
		} else {
			sum_clause.push_back(mkLit(input_var[i]));
			vector<Lit> clause;
			clause.push_back(~mkLit(output_var));
			clause.push_back(~mkLit(input_var[i]));
			clauses.push_back(clause);
		}

		constant = -1;
	}

	clauses.push_back(sum_clause);

	return clauses;
}

// This function calculates the clauses for two input xnor. The node_vec is needed to support handling of constants.
vector<vector<Lit> > xnor2_clause(vector<int> input_var, int output_var, vector<hcmNode*> &node_vec) {
	int constant = -1;
	node_vec[0]->getProp("constant",constant);

	if (constant == 1) {
		vector<hcmNode*> new_vec;
		new_vec.insert(node_vec.begin() + 1,node_vec.end(),new_vec.end());
		return buffer_clause(input_var[1],output_var,new_vec);
	} else if (constant == 0) {
		vector<hcmNode*> new_vec;
		new_vec.insert(new_vec.end(),node_vec.begin() + 1,node_vec.end());
		return not_clause(input_var[1],output_var,new_vec);
	} else {
		vector<Lit> first_clause;
		first_clause.push_back(mkLit(output_var));
		first_clause.push_back(~mkLit(input_var[0]));
		first_clause.push_back(~mkLit(input_var[1]));
		vector<Lit> sec_clause;
		sec_clause.push_back(mkLit(output_var));
		sec_clause.push_back(mkLit(input_var[0]));
		sec_clause.push_back(mkLit(input_var[1]));
		vector<Lit> third_clause;
		third_clause.push_back(~mkLit(output_var));
		third_clause.push_back(mkLit(input_var[0]));
		third_clause.push_back(~mkLit(input_var[1]));
		vector<Lit> fourth_clause;
		fourth_clause.push_back(~mkLit(output_var));
		fourth_clause.push_back(~mkLit(input_var[0]));
		fourth_clause.push_back(mkLit(input_var[1]));
		vector<vector<Lit> > clauses;
		clauses.push_back(first_clause);
		clauses.push_back(sec_clause);
		clauses.push_back(third_clause);
		clauses.push_back(fourth_clause);
		return clauses;
	}
}

// This function calculates the clauses for two input xor. The node_vec is needed to support handling of constants.
vector<vector<Lit> > xor2_clause(vector<int> input_var, int output_var, vector<hcmNode*> &node_vec) {
	int constant = -1;
	node_vec[0]->getProp("constant",constant);

	if (constant == 1) {
		vector<hcmNode*> new_vec;
		new_vec.insert(node_vec.begin() + 1,node_vec.end(),new_vec.end());
		return not_clause(input_var[1],output_var,new_vec);
	} else if (constant == 0) {
		vector<hcmNode*> new_vec;
		new_vec.insert(new_vec.end(),node_vec.begin() + 1,node_vec.end());
		return buffer_clause(input_var[1],output_var,new_vec);
	} else {
		vector<Lit> first_clause;
		first_clause.push_back(~mkLit(output_var));
		first_clause.push_back(~mkLit(input_var[0]));
		first_clause.push_back(~mkLit(input_var[1]));
		vector<Lit> sec_clause;
		sec_clause.push_back(~mkLit(output_var));
		sec_clause.push_back(mkLit(input_var[0]));
		sec_clause.push_back(mkLit(input_var[1]));
		vector<Lit> third_clause;
		third_clause.push_back(mkLit(output_var));
		third_clause.push_back(mkLit(input_var[0]));
		third_clause.push_back(~mkLit(input_var[1]));
		vector<Lit> fourth_clause;
		fourth_clause.push_back(mkLit(output_var));
		fourth_clause.push_back(~mkLit(input_var[0]));
		fourth_clause.push_back(mkLit(input_var[1]));
		vector<vector<Lit> > clauses;
		clauses.push_back(first_clause);
		clauses.push_back(sec_clause);
		clauses.push_back(third_clause);
		clauses.push_back(fourth_clause);
		return clauses;
	}
}

