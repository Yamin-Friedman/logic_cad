#include "clauses.h"

using namespace std;

vector<vector<int>> buffer_clause(int input_var, int output_var) {
	vector<vector<int>> clauses;

	if (input_var == 0) {
		clauses.push_back(vector<int>(1,0));
	} else if (input_var == -1) {
		clauses.push_back(vector<int>(1,-1));
	} else {
		vector<int> pos_clause{input_var, -output_var};
		vector<int> neg_clause{-input_var, output_var};
		clauses.push_back(pos_clause);
		clauses.push_back(neg_clause);
	}

	return clauses;
}

vector<vector<int>> not_clause(int input_var, int output_var) {
	vector<vector<int>> clauses;

	if (input_var == 0) {
		clauses.push_back(vector<int>(1,-1));
	} else if (input_var == -1) {
		clauses.push_back(vector<int>(1,0));
	} else {
		vector<int> pos_clause{input_var, output_var};
		vector<int> neg_clause{-input_var, -output_var};
		clauses.push_back(pos_clause);
		clauses.push_back(neg_clause);
	}

	return clauses;
}

vector<vector<int>> and_clause(vector<int> input_var, int output_var) {
	vector<vector<int>> clauses;
	vector<int> sum_clause{output_var};

	for (int i = 0; i < input_var.size(); i++) {
		if (input_var[i] == 0) {
			return vector<vector<int>>(1,vector<int>(1,0));
		} else if (input_var[i] == -1) {
			continue;
		} else {
			sum_clause.push_back(-input_var[i]);
			vector<int> clause{-output_var, input_var[i]};
			clauses.push_back(clause);
		}
	}

	clauses.push_back(sum_clause);

	return clauses;
}

vector<vector<int>> nand_clause(vector<int> input_var, int output_var) {
	vector<vector<int>> clauses;
	vector<int> sum_clause{-output_var};

	for (int i = 0; i < input_var.size(); i++) {
		if (input_var[i] == 0) {
			return vector<vector<int>>(1,vector<int>(1,-1));
		} else if (input_var[i] == -1) {
			continue;
		} else {
			sum_clause.push_back(-input_var[i]);
			vector<int> clause{output_var, input_var[i]};
			clauses.push_back(clause);
		}
	}

	clauses.push_back(sum_clause);

	return clauses;
}

vector<vector<int>> or_clause(vector<int> input_var, int output_var) {
	vector<vector<int>> clauses;
	vector<int> sum_clause{-output_var};

	for (int i = 0; i < input_var.size(); i++) {
		if (input_var[i] == 0) {
			continue;
		} else if (input_var[i] == -1) {
			return vector<vector<int>>(1,vector<int>(1,-1));
		} else {
			sum_clause.push_back(input_var[i]);
			vector<int> clause{output_var, -input_var[i]};
			clauses.push_back(clause);
		}
	}

	clauses.push_back(sum_clause);

	return clauses;
}

vector<vector<int>> nor_clause(vector<int> input_var, int output_var) {
	vector<vector<int>> clauses;
	vector<int> sum_clause{output_var};

	for (int i = 0; i < input_var.size(); i++) {
		if (input_var[i] == 0) {
			continue;
		} else if (input_var[i] == -1) {
			return vector<vector<int>>(1,vector<int>(1,0));
		} else {
			sum_clause.push_back(input_var[i]);
			vector<int> clause{-output_var, -input_var[i]};
			clauses.push_back(clause);
		}
	}

	clauses.push_back(sum_clause);

	return clauses;
}

vector<vector<int>> xnor2_clause(vector<int> input_var, int output_var) {

	vector<int> first_clause{-output_var,input_var[0],-input_var[1]};
	vector<int> sec_clause{-output_var,-input_var[0],input_var[1]};
	vector<vector<int>> clauses{first_clause,sec_clause};

	return clauses;
}

