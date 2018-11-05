/*
 * main.cpp
 *
 *  Created on: Dec 8, 2013
 *      Author: Yosrie
 */

#include "hcm.h"
using namespace std;

int main(int argc, char **argv) {
  if (argc < 2) {
    printf("Usage: %s file1.v [file2.v] ...\n", argv[0]);
    exit(1);
  }

  hcmDesign* d = new hcmDesign("MyDesign");
  for (int i = 1; i < argc; i++) {
    printf("parsing %s ...\n", argv[i]);
    d->parseStructuralVerilog(argv[i]);
  }
  d->printInfo();
  delete d;
}


