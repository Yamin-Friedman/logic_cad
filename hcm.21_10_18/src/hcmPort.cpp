/*
 * hcmPort.cpp
 *
 *  Created on: Dec 8, 2013
 *      Author: Yosrie
 */

#include "hcm.h"
#include <list>
#include "auxiliary.h"
using namespace std;

void hcmPort::printInfo(){

}

hcmPort::hcmPort(std::string portName, hcmNode* ownerNode , hcmPortDir direction){
	name = portName;
	dir = direction;
	node = ownerNode;
}

hcmPort::~hcmPort() {
	destructorCalled = true;
	cleanAndDestroy(instPorts);
	node->deletePort();
	node = NULL;
}

hcmNode* hcmPort::owner(){
	return node;
}

