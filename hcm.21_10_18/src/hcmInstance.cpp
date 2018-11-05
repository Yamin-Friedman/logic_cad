/*
 * hcmInstance.cpp
 *
 *  Created on: Dec 8, 2013
 *      Author: Yosrie
 */


#include "hcm.h"
#include "auxiliary.h"

bool startsWith(string source, string prefix) {
  return source.substr(0,prefix.length()) == prefix;
}


void hcmInstance::printInfo(){
  cout << "\tInstance " + name + " owner: " + cell->getName() + " master: " + master->getName() << endl;
  for(map<string,hcmInstPort*>::iterator it = instPorts.begin(); it != instPorts.end(); ++it) {
    it->second->printInfo();
  }
}

hcmInstance::hcmInstance(std::string instanceName, hcmCell* masterCell){
  name = instanceName;
  master = masterCell;
  cell = NULL;
}

hcmInstance::~hcmInstance(){
  destructorCalled = true;
  cell->deleteInst(name);
  cleanAndDestroy(instPorts);
  master = NULL;
  cell = NULL;
}

bool hcmInstance::connectInstance(hcmCell* containingCell){
  if(cell != NULL){
    return false;
  }
  cell = containingCell;
  return true;
}

hcmCell* hcmInstance::owner(){
  return cell;
}

hcmCell* hcmInstance::masterCell(){
  return master;
}

vector<hcmPort*> hcmInstance::getAvailablePorts(){
  vector<hcmPort*> allPorts = master->getPorts();
  vector<hcmPort*> availablePorts;
  for(vector<hcmPort*>::iterator it = allPorts.begin(); it != allPorts.end() ; it++) {
    bool found = false;
    for(map<string,hcmInstPort*>::iterator ipit = instPorts.begin(); ipit != instPorts.end(); ++ipit) {
      if((*it)->getName() == ipit->second->getPort()->getName()) {
        found = true;
        break;
      }
    }
    if(!found) { 
      availablePorts.push_back(*it); 
    }
  }
  return availablePorts;
}

vector<hcmPort*> hcmInstance::getAvailablePorts(std::string nodeName){
  vector<hcmPort*> allPorts = master->getPorts();
  vector<hcmPort*> availablePorts;

  // if the node name is a known bus
  if (master->buses.find(nodeName) != master->buses.end()) {
    int from = master->buses[nodeName].first;
    int to = master->buses[nodeName].second;
    // loop over all bus nodes and add to available port if they are ports...
    if (from <= to) {
      for (int i = from; i <= to; i++) {
	hcmPort *port = master->getPort(busNodeName(nodeName, i));
	if (port) 
	  availablePorts.push_back(port);
      }
    } else {
      for (int i = from; i >= to; i--) {
	hcmPort *port = master->getPort(busNodeName(nodeName, i));
	if (port) 
	  availablePorts.push_back(port);
      }
    }
  } else {
    hcmPort *port = master->getPort(nodeName);
    if (port) {
      availablePorts.push_back(port);
    }
  }

  // making sure not ALREADY CONNECTED
  for(vector<hcmPort*>::iterator it = availablePorts.begin(); it != availablePorts.end() ; it++) {
    for(map<string,hcmInstPort*>::iterator ipit = instPorts.begin(); ipit != instPorts.end(); ++ipit) {
      if((*it)->getName() == ipit->second->getPort()->getName()) {
        //This bus is in use!
        availablePorts.clear();
        return availablePorts;
      }
    }
  }
  return availablePorts;
}

hcmInstPort* 
hcmInstance::getInstPort(string name)
{
  map< std::string , hcmInstPort *>::iterator iI = instPorts.find(name);
  if (iI == instPorts.end()) {
    return NULL;
  } else {
    return (*iI).second;
  }
}

const hcmInstPort* 
hcmInstance::getInstPort(string name) const
{
  map< std::string , hcmInstPort *>::const_iterator iI = instPorts.find(name);
  if (iI == instPorts.end()) {
    return NULL;
  } else {
    return (*iI).second;
  }
}

std::map<std::string, hcmInstPort* > &
hcmInstance::getInstPorts()
{
  return instPorts;
}

const std::map<std::string, hcmInstPort* > &
hcmInstance::getInstPorts() const
{
  return instPorts;
}

