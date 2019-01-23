

#ifndef CLAUSES_H
#define CLAUSES_H

#include <vector>
#include "hcm.h"

#include <signal.h>
#include <zlib.h>
#include "utils/System.h"
#include "utils/ParseUtils.h"
#include "utils/Options.h"
#include "core/Dimacs.h"
#include "core/Solver.h"

// This function calculates the clauses for buffers. The node_vec is needed to support handling of constants.
std::vector<std::vector<Minisat::Lit> > buffer_clause(int input_var, int output_var, std::vector< hcmNode* > &node_vec);

// This function calculates the clauses for inverters. The node_vec is needed to support handling of constants.
std::vector<std::vector<Minisat::Lit> > not_clause(int input_var, int output_var, std::vector< hcmNode* > &node_vec);

// This function calculates the clauses for and. The node_vec is needed to support handling of constants.
std::vector<std::vector<Minisat::Lit> > and_clause(std::vector<int> input_var, int output_var, std::vector< hcmNode* > &node_vec);

// This function calculates the clauses for nand. The node_vec is needed to support handling of constants.
std::vector<std::vector<Minisat::Lit> > nand_clause(std::vector<int> input_var, int output_var, std::vector< hcmNode* > &node_vec);

// This function calculates the clauses for or. The node_vec is needed to support handling of constants.
std::vector<std::vector<Minisat::Lit> > or_clause(std::vector<int> input_var, int output_var, std::vector< hcmNode* > &node_vec);

// This function calculates the clauses for nor. The node_vec is needed to support handling of constants.
std::vector<std::vector<Minisat::Lit> > nor_clause(std::vector<int> input_var, int output_var, std::vector< hcmNode* > &node_vec);

// This function calculates the clauses for two input xnor. The node_vec is needed to support handling of constants.
std::vector<std::vector<Minisat::Lit> > xnor2_clause(std::vector<int> input_var, int output_var, std::vector< hcmNode* > &node_vec);

// This function calculates the clauses for two input xor. The node_vec is needed to support handling of constants.
std::vector<std::vector<Minisat::Lit> > xor2_clause(std::vector<int> input_var, int output_var, std::vector< hcmNode* > &node_vec);

#endif //CLAUSES_H
