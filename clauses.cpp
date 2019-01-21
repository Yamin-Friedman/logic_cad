#include "clauses.h"

using namespace std;

vector<vector<Lit>> buffer_clause(int input_var, int output_var) {
	vector<vector<Lit>> clauses;

	if (input_var == 0) {
		clauses.push_back(vector<Lit>(1,mkLit(0)));
	} else if (input_var == -1) {
		clauses.push_back(vector<Lit>(1,~mkLit(1)));
	} else {
		vector<Lit> pos_clause{mkLit(input_var), ~mkLit(output_var)};
		vector<Lit> neg_clause{~mkLit(input_var), mkLit(output_var)};
		clauses.push_back(pos_clause);
		clauses.push_back(neg_clause);
	}

	return clauses;
}

vector<vector<Lit>> not_clause(int input_var, int output_var) {
	vector<vector<Lit>> clauses;

	if (input_var == 0) {
		clauses.push_back(vector<Lit>(1,~mkLit(1)));
	} else if (input_var == -1) {
		clauses.push_back(vector<Lit>(1,mkLit(0)));
	} else {
		vector<Lit> pos_clause{mkLit(input_var), mkLit(output_var)};
		vector<Lit> neg_clause{~mkLit(input_var), ~mkLit(output_var)};
		clauses.push_back(pos_clause);
		clauses.push_back(neg_clause);
	}

	return clauses;
}

vector<vector<Lit>> and_clause(vector<int> input_var, int output_var) {
	vector<vector<Lit>> clauses;
	vector<Lit> sum_clause{mkLit(output_var)};

	for (int i = 0; i < input_var.size(); i++) {
		if (input_var[i] == 0) {
			return vector<vector<Lit>>(1,vector<Lit>(1,mkLit(0)));
		} else if (input_var[i] == -1) {
			continue;
		} else {
			sum_clause.push_back(~mkLit(input_var[i]));
			vector<Lit> clause{~mkLit(output_var), mkLit(input_var[i])};
			clauses.push_back(clause);
		}
	}

	clauses.push_back(sum_clause);

	return clauses;
}

vector<vector<Lit>> nand_clause(vector<int> input_var, int output_var) {
	vector<vector<Lit>> clauses;
	vector<Lit> sum_clause{~mkLit(output_var)};

	for (int i = 0; i < input_var.size(); i++) {
		if (input_var[i] == 0) {
			return vector<vector<Lit>>(1,vector<Lit>(1,~mkLit(1)));
		} else if (input_var[i] == -1) {
			continue;
		} else {
			sum_clause.push_back(~mkLit(input_var[i]));
			vector<Lit> clause{mkLit(output_var), mkLit(input_var[i])};
			clauses.push_back(clause);
		}
	}

	clauses.push_back(sum_clause);

	return clauses;
}

vector<vector<Lit>> or_clause(vector<int> input_var, int output_var) {
	vector<vector<Lit>> clauses;
	vector<Lit> sum_clause{~mkLit(output_var)};

	for (int i = 0; i < input_var.size(); i++) {
		if (input_var[i] == 0) {
			continue;
		} else if (input_var[i] == -1) {
			return vector<vector<Lit>>(1,vector<Lit>(1,~mkLit(1)));
		} else {
			sum_clause.push_back(mkLit(input_var[i]));
			vector<Lit> clause{mkLit(output_var), ~mkLit(input_var[i])};
			clauses.push_back(clause);
		}
	}

	clauses.push_back(sum_clause);

	return clauses;
}

vector<vector<Lit>> nor_clause(vector<int> input_var, int output_var) {
	vector<vector<Lit>> clauses;
	vector<Lit> sum_clause{mkLit(output_var)};

	for (int i = 0; i < input_var.size(); i++) {
		if (input_var[i] == 0) {
			continue;
		} else if (input_var[i] == -1) {
			return vector<vector<Lit>>(1,vector<Lit>(1,mkLit(0)));
		} else {
			sum_clause.push_back(mkLit(input_var[i]));
			vector<Lit> clause{~mkLit(output_var), ~mkLit(input_var[i])};
			clauses.push_back(clause);
		}
	}

	clauses.push_back(sum_clause);

	return clauses;
}

vector<vector<Lit>> xnor2_clause(vector<int> input_var, int output_var) {

	if (input_var[0] == -1) {
		return buffer_clause(input_var[1],output_var);
	} else if (input_var[0] == 0) {
		return not_clause(input_var[1],output_var);
	} else {
		vector<Lit> first_clause{~mkLit(output_var), mkLit(input_var[0]), ~mkLit(input_var[1])};
		vector<Lit> sec_clause{~mkLit(output_var), ~mkLit(input_var[0]), mkLit(input_var[1])};
		vector<vector<Lit>> clauses{first_clause, sec_clause};
		return clauses;
	}
}

vector<vector<Lit>> xor2_clause(vector<int> input_var, int output_var) {

	if (input_var[0] == 0) {
		return buffer_clause(input_var[1],output_var);
	} else if (input_var[0] == -1) {
		return not_clause(input_var[1],output_var);
	} else {
		vector<Lit> first_clause{mkLit(output_var), mkLit(input_var[0]), ~mkLit(input_var[1])};
		vector<Lit> sec_clause{mkLit(output_var), ~mkLit(input_var[0]), mkLit(input_var[1])};
		vector<vector<Lit>> clauses{first_clause, sec_clause};
		return clauses;
	}
}

