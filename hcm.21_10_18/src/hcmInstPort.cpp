/*
 * hcmInstPort.cpp
 *
 *  Created on: Dec 15, 2013
 *      Author: Yosrie
 */

#include "hcm.h"
using namespace std;

void hcmInstPort::printInfo(){
  cout << "\t\tInstPort: " +name; 
  if (connectedNode) 
    cout << " Node: " << connectedNode->getName();
  cout << endl;
}

hcmInstPort::hcmInstPort(hcmInstance* instance, hcmNode* node, hcmPort* port){
	inst = instance;
	connectedNode = node;
	connectedPort = port;
	// required to be unique name as node instPort is map by name !!!
	name = inst->getName()+'%'+port->getName();
}

hcmInstPort::~hcmInstPort(){
	destructorCalled = true;
	hcmCell::disConnect(this);
	inst = NULL;
	connectedNode = NULL;
	connectedPort = NULL;
}
