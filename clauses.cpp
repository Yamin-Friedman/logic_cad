#include "clauses.h"

using namespace std;

vector<vector<int>> not_clause(int input_var, int output_var) {
	vector<int> pos_clause{input_var,output_var};
	vector<int> neg_clause{-input_var,-output_var};
	vector<vector<int>> clauses{pos_clause,neg_clause};

	return clauses;
}

vector<vector<int>> and_clause(vector<int> input_var, int output_var) {
	vector<vector<int>> clauses;
	vector<int> sum_clause{output_var};

	for (int i = 0; i < input_var.size(); i++) {
		sum_clause.push_back(-input_var[i]);
		vector<int> clause{-output_var,input_var[i]};
		clauses.push_back(clause);
	}

	clauses.push_back(sum_clause);

	return clauses;
}

vector<vector<int>> nand_clause(vector<int> input_var, int output_var) {
	vector<vector<int>> clauses;
	vector<int> sum_clause{-output_var};

	for (int i = 0; i < input_var.size(); i++) {
		sum_clause.push_back(-input_var[i]);
		vector<int> clause{output_var,input_var[i]};
		clauses.push_back(clause);
	}

	clauses.push_back(sum_clause);

	return clauses;
}

vector<vector<int>> or_clause(vector<int> input_var, int output_var) {
	vector<vector<int>> clauses;
	vector<int> sum_clause{-output_var};

	for (int i = 0; i < input_var.size(); i++) {
		sum_clause.push_back(input_var[i]);
		vector<int> clause{output_var,-input_var[i]};
		clauses.push_back(clause);
	}

	clauses.push_back(sum_clause);

	return clauses;
}

vector<vector<int>> nor_clause(vector<int> input_var, int output_var) {
	vector<vector<int>> clauses;
	vector<int> sum_clause{output_var};

	for (int i = 0; i < input_var.size(); i++) {
		sum_clause.push_back(input_var[i]);
		vector<int> clause{-output_var,-input_var[i]};
		clauses.push_back(clause);
	}

	clauses.push_back(sum_clause);

	return clauses;
}

