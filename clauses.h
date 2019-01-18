

#ifndef CLAUSES_H
#define CLAUSES_H

#include <vector>

std::vector<std::vector<int>> buffer_clause(int input_var, int output_var);

std::vector<std::vector<int>> not_clause(int input_var, int output_var);

std::vector<std::vector<int>> and_clause(std::vector<int> input_var, int output_var);

std::vector<std::vector<int>> nand_clause(std::vector<int> input_var, int output_var);

std::vector<std::vector<int>> or_clause(std::vector<int> input_var, int output_var);

std::vector<std::vector<int>> nor_clause(std::vector<int> input_var, int output_var);

std::vector<std::vector<int>> xnor2_clause(std::vector<int> input_var, int output_var);

std::vector<std::vector<int>> xor2_clause(std::vector<int> input_var, int output_var);

#endif //CLAUSES_H
