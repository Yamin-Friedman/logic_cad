

#ifndef CLAUSES_H
#define CLAUSES_H

#include <vector>

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

std::vector<std::vector<Lit>> buffer_clause(int input_var, int output_var);

std::vector<std::vector<Lit>> not_clause(int input_var, int output_var);

std::vector<std::vector<Lit>> and_clause(std::vector<int> input_var, int output_var);

std::vector<std::vector<Lit>> nand_clause(std::vector<int> input_var, int output_var);

std::vector<std::vector<Lit>> or_clause(std::vector<int> input_var, int output_var);

std::vector<std::vector<Lit>> nor_clause(std::vector<int> input_var, int output_var);

std::vector<std::vector<Lit>> xnor2_clause(std::vector<int> input_var, int output_var);

std::vector<std::vector<Lit>> xor2_clause(std::vector<int> input_var, int output_var);

#endif //CLAUSES_H
