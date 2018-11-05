#include "hcmsigvec.h"
#include <iostream>
#include <sstream>
#include <stdlib.h>

using namespace std;

hcmSigVec::hcmSigVec(std::string sfn, std::string vfn, bool v)
{
  isGood = true;
  verbose = v;
  vecLineNum = 0;
  sigsFileName = sfn;
  sigs.open(sfn.c_str());
  
  vecsFileName = vfn;
  vecs.open(vfn.c_str());
  
  if (!sigs.good()) {
    cerr << "-E- Failed opening Signal file: " << sfn << endl;
	 isGood = false;
  }

  if (!vecs.good()) {
    cerr << "-E- Failed opening Vector file: " << vfn << endl;
	 isGood = false;
  }

  if (isGood) {
	 if (parseSignalsFile()) {
		cerr << "-E- Failed to parse signals file: " << sfn << endl;
		isGood = false;
	 }
  }
}

int 
hcmSigVec::getSigValue(std::string sigName, bool &val)
{
  if (!isGood) {
	 cerr << "-E- getSigValue: But hcmSigVec object not initialized correctly." << endl;
	 return 1;
  }

  if (signalVecIdx.find(sigName) == signalVecIdx.end()) {
	 cerr << "-E- Could not find signal: " << sigName << endl;
	 return 1;
  }
  size_t idx = signalVecIdx[sigName];
  if (idx >= sigValsByIdx.size()) {
	 cerr << "-E- BUG signal: " << sigName << " idx: " << idx
			<< " >= sigValsByIdx.size() " << sigValsByIdx.size() << endl;
	 return 1;
  }
  val = sigValsByIdx[idx];
  return 0;
}

// return number of signals and fill the set of signals with names
int 
hcmSigVec::getSignals(std::set< std::string > &signals)
{
  for (map<std::string, int>::const_iterator I = signalVecIdx.begin();
		 I != signalVecIdx.end(); I++) {
	 signals.insert((*I).first);
  }
  return(signals.size());
}

////////////////////////////////////////////////////////////////////////////////////////
// Private
int 
hcmSigVec::readVector()
{
  if (vecs.eof()) 
    return(-1);

  string line;
  getline(vecs, line);
  vecLineNum++;
  // the line is a long hexadecimal number as string.
  // we need to extract one bit at a time...

  // first lets check we have enough length...
  size_t strLen = line.length();
  if (!strLen) {
    cerr << "-E- Empty line in vector files (line: " << vecLineNum << ")" << endl;
    return(1);
  }

  if (strLen < ((sigValsByIdx.size()+3)/4)) {
    cerr << "-E- Not enough hexadecimal digits (" << strLen
			<< " < " << ((sigValsByIdx.size()+3)/4) << ") in line:"
			<< vecLineNum << " = " << line << endl;
    return(1);
  }

  // convert the line string to bits assigning them by index to each signal
  char c = line[--strLen];
  unsigned digit =  strtoul(&c, (char **) NULL, 16);
  for (unsigned int i = 0; i < sigValsByIdx.size(); i++) {
    sigValsByIdx[i] = digit & 1;
    if (verbose) 
      cout << "-D- Signal idx: " << i << " = " << sigValsByIdx[i] << " dig:" << digit << endl;
    
    digit = digit >> 1;
    if ((i+1) % 4 == 0) {
		c = line[--strLen];
		digit = strtoul(&c, (char **) NULL, 16);
		digit &= 0xff;
    }
  }
  return(0);
}

static string 
busNodeName(string busName, int index){
  ostringstream result;
  result << busName << '[' << index << ']';
  return result.str();
}

static string 
trim(const std::string& str,
     const std::string& whitespace = " \t\n")
{
  const size_t strBegin = str.find_first_not_of(whitespace);
  if (strBegin == std::string::npos)
    return ""; // no content
  
  const size_t strEnd = str.find_last_not_of(whitespace);
  const size_t strRange = strEnd - strBegin + 1;
  
  return str.substr(strBegin, strRange);
}

int 
hcmSigVec::parseSignalsFile()
{
  string line;
  string prefix, fromStr, toStr;
  size_t lbrace, rbrace, colon;
  int idx = 0;
  while (sigs.good()) {
    getline(sigs, line);
    string name = trim(line);
    if (name.length() == 0)
      continue;
    lbrace = name.find("[");
    colon = name.find(":");
    rbrace = name.find("]");
    if ((lbrace != string::npos) &&
		  (rbrace != string::npos) &&
		  (colon != string::npos)	) {
      prefix = name.substr(0, lbrace);
      fromStr = name.substr(lbrace + 1, colon - lbrace - 1);
      toStr = name.substr(colon + 1, rbrace - colon - 1 );
      unsigned int from = atoi(fromStr.c_str());
      unsigned int to = atoi(toStr.c_str());
      if (from <= to) {
		  for (unsigned int i = to; i >= from; i--) {
			 string sig = busNodeName(prefix,i);
			 if (verbose) 
				cout << "-D- Signal: " << sig << " idx: " << idx << endl;
			 signalVecIdx[sig] = idx++;
		  }
      } else {
		  for (unsigned int i = to; i <= from; i++) {
			 string sig = busNodeName(prefix,i);
			 if (verbose) 
				cout << "-D- Signal: " << sig << " idx: " << idx << endl;
			 signalVecIdx[sig] = idx++;
		  }
      }
    } else {
      if (verbose) 
		  cout << "-D- Signal: " << name << " idx: " << idx << endl;
      signalVecIdx[name] = idx++;
    }
  }

  // initialize false value for all signals
  sigValsByIdx.resize(signalVecIdx.size(), false);
  
  return(0);
}
