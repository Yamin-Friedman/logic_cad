/*
 * auxiliary.h
 *
 *  Created on: Dec 15, 2013
 *      Author: Yosrie
 */

#ifndef AUXILIARY_H_
#define AUXILIARY_H_


#include <set>

using namespace std;

template <class T>
void cleanAndDestroy(map<string,T*> mapToClean) {
	set<string> names;
	for(typename map<string,T*>::iterator it = mapToClean.begin(); it != mapToClean.end(); ++it) {
		names.insert(it->first);
	}
	for(set<string>::iterator it = names.begin(); it != names.end() ; ++it){
		T* tmp = mapToClean[*it];
		mapToClean.erase(*it);
		delete tmp;
	}
}

#endif /* AUXILIARY_H_ */
