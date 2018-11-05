//
// DEMO of Parsing Sigs and Vecs
// 
#include <iostream>
#include <sstream>
#include <fstream>
#include <set>
#include <string.h>
#include <stdlib.h>
#include "hcmsigvec.h"

using namespace std;

bool verbose = false;

///////////////////////////////////////////////////////////////////////////

int main(int argc, char **argv) {
  int argIdx = 1;
  int anyErr = 0;
  string sigsFileName;
  string vecsFileName;

  if (argc < 3) {
    anyErr++;
  } else {
    if (!strcmp(argv[argIdx], "-v")) {
      argIdx++;
      verbose = true;
    }

	 sigsFileName = string(argv[argIdx++]);
	 vecsFileName = string(argv[argIdx++]);
  }

  if (anyErr) {
    cerr << "Usage: " << argv[0] << "  [-v] sigs-file vecs-file \n";
    exit(1);
  }

  hcmSigVec parser(sigsFileName, vecsFileName, verbose);
  set<string> sigs;
  parser.getSignals(sigs);
  for (set<string>::iterator I= sigs.begin(); I != sigs.end(); I++) {
	 cout << "SIG: " << (*I) << endl;
  }

  cout << "-I- Reading vectors ... " << endl;
  while (parser.readVector() == 0) {
	 for (set<string>::iterator I= sigs.begin(); I != sigs.end(); I++) {
		string name = (*I);
		bool val;
		parser.getSigValue(name, val);
		cout << "  " << name << " = " << (val? "1" : "0")  << endl;
	 }
	 cout << "-I- Reading next vectors ... " << endl;
  }

  return(0);
}
