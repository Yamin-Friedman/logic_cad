//
// A Library for obtaining vectors of signal values given sigs and vector files
// 

#include <fstream>
#include <map>
#include <set>
#include <vector>

using namespace std;

// An occurrence node is defined by a context:
class hcmSigVec {
  bool verbose;
  bool isGood;
  unsigned int vecLineNum;
  ifstream sigs;
  ifstream vecs;
  string sigsFileName;
  string vecsFileName;
  vector<bool> sigValsByIdx; // signals value by the signal idx
  map<string, int> signalVecIdx; // mapping from signal name to idx
  
  // build iternal signal index by name; return 0 on success
  int parseSignalsFile();

 public:
  hcmSigVec(string sfn, string vfn, bool v = false);
  // return true if the parsers are OK or false otherwise
  bool good() {return isGood;};

  // read a line of the vector file and fill in internal map
  // return 1 if error -1 if could not since EOF or 0 if ok
  int readVector();

  // get the value of the givem signal name. 
  // Support only single bit values.
  // return 1 if the signal unknown
  int getSigValue(string sigName, bool &val);

  // return number of signals and fill the set of signals with names
  int getSignals(set< string > &signals);
};




