/*
 * main.cpp
 *
 *  Created on: Dec 8, 2013
 *      Author: Yosrie
 */

#include "hcm.h"
using namespace std;


void testBuses() {
	hcmDesign* d = new hcmDesign("MyDesign");
	hcmCell* A = d->createCell("A");
	A->createBus("address",6,0,NOT_PORT);
	A->createNode("address");
	d->printInfo();
	cout << "----------------------------" << endl;
	A->deleteBus("address");
	A->createNode("address");
	d->printInfo();
}
void testParsing() {
	hcmDesign* d = new hcmDesign("MyDesign");
	d->parseStructuralVerilog("myrisc.v");
	d->printInfo();
	delete d;
}

int test1(){
	hcmDesign* d = new hcmDesign("MyDesign");
	hcmCell* A = d->createCell("A");
	hcmCell* B = d->createCell("B");
	hcmCell* C = d->createCell("C");
	hcmNode* aVcc = d->getCell("A")->createNode("vcc");
	hcmNode* aVss = d->getCell("A")->createNode("vss");
	A->setProp("tcd", 0.5);

	double tcd = 0;
	A->getProp("tcd",tcd);
	cout << "TCD-A = " << tcd << endl;

	A->delProp<double>("tcd");
	assert(A->getProp("tcd",tcd) == NOT_FOUND);
	//Testing NULLS + BAD_PARAMETERS
	cout << "Testing NULLS" << endl;
	assert(A->connect(NULL,NULL,"") == NULL);
	assert(A->connect(NULL,aVcc,"aVcc") == NULL);
	assert(A->connect(NULL,aVss,"aVss") == NULL);
	assert(A->getInst("A") == NULL);
	assert(B->deleteNode("vcc") == BAD_PARAM);
	assert(B->deleteInst("B") == BAD_PARAM);

	//Test < ..... >
	hcmPort* aVccInPort = aVcc->createPort(IN);
	assert(aVccInPort != NULL);
	hcmInstance* aInB = B->createInst("a","A");
	assert(aInB != NULL);
	hcmInstPort* instPort1 = B->connect(aInB,aVcc,aVccInPort->getName());
	assert(instPort1 == NULL);

	assert(B->getNode("vcc") == NULL);
	hcmNode* bVcc = d->getCell("B")->createNode("vcc");
	hcmPort* bVccInPort = bVcc->createPort(IN);
	assert(bVccInPort != NULL);

	hcmInstance* bInA = A->createInst("b","B");
	assert(bInA != NULL);
	hcmInstPort* instPort2 = A->connect(bInA,aVcc,bVccInPort->getName());
	assert(instPort2 != NULL);

	hcmNode* cVcciog = d->getCell("C")->createNode("vcciog");
	hcmInstance* aInC = C->createInst("a1","A");
	hcmInstance* bInC = C->createInst("b1","B");
	hcmInstPort* instPort3 = C->connect(aInC,cVcciog,aVccInPort->getName());
	assert(instPort3 != NULL);
	hcmInstPort* instPort4 = C->connect(bInC,cVcciog,bVccInPort->getName());
	assert(instPort4 != NULL);
//hcmPort* bVccInPort = bVcc->createPort(IN);
	//assert(aVcc->getInstPorts().size() == 1);
	//delete bVccInPort;
	//A->disConnect(instPort2);
	//assert(aVcc->getInstPorts().size() == 0);
	delete B;
//	delete C;
	//d->printInfo();
	delete d;
	cout << "Test Ended!" << endl;
	return 0;
}

int main() {
	//test1();
	//testBuses();
	testParsing();
}


