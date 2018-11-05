#include "hcm.h"
#include <set>

hcmCell *
hcmFlatten(std::string cellName, hcmCell *dCell, 
	   std::set<std::string> &globalNodes);

int 
hcmWriteCellVerilog(hcmCell *topCell, std::string fileName);
