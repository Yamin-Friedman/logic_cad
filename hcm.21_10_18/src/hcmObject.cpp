/*
 * hcmObject.c
 *
 *  Created on: Dec 8, 2013
 *      Author: Yosrie
 */

#include "hcm.h"

hcmObject::hcmObject(){
	destructorCalled = false;
}

const std::string hcmObject::getName() const {
	return name;
}

/*hcmRes hcmObject::getProp(std::string name, std::string &s){

}

hcmRes hcmObject::getProp(std::string name, long int &i);
hcmRes hcmObject::getProp(std::string name, double &d);
// implicitly create new prop or update it
hcmRes hcmObject::setProp(std::string name, std::string s);
hcmRes hcmObject::setProp(std::string name, long int i);
hcmRes hcmObject::setProp(std::string name, double d);
hcmRes hcmObject::delProp(std::string name);*/
