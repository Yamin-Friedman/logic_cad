/*
 * hcmDesign.cpp
 *
 *  Created on: Dec 15, 2013
 *      Author: Yosrie
 */


#include "hcm.h"
#include "auxiliary.h"

using namespace std;

void hcmDesign::printInfo(){
	cout << "Design " + name + " info:" <<endl;
	for(map<string,hcmCell*>::iterator it = cells.begin(); it != cells.end(); ++it) {
		it->second->printInfo();
	}
	cout << "Done!" << endl;
}

hcmDesign::hcmDesign(std::string designName){
	name = designName;
}

hcmCell *hcmDesign::createCell(std::string name){
	if(cells.find(name) != cells.end()){
		cout << "Cell: " + name + " already exists in the design!" << endl;
		return NULL;
	}
	hcmCell* cell = new hcmCell(name,this);
	cell->createNode("VDD");
	cell->createNode("VSS");
	cells[name] =cell;
	return cell;
}

bool hcmDesign::deleteCell(std::string name){
	if(cells.count(name) == 0 ) {
		return false;
	}
	hcmCell* cell = cells[name];
	if(!(cell->destructorCalled)){
		delete cell;
	} else {
		cells.erase(name);
	}
	return true;
}

hcmCell *hcmDesign::getCell(std::string name){
	if(cells.count(name) == 0 ) {
			return NULL;
	}
	return cells[name];
}

hcmDesign::~hcmDesign(){
	cleanAndDestroy(cells);
}

hcmRes hcmDesign::parseStructuralVerilog(const char *fileName){
	extern int read_verilog(hcmDesign* design, const char *fn);
	if (read_verilog(this,fileName)) {
	  return BAD_PARAM;
	}
	return OK;
}

