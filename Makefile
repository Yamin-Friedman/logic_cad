# Update the paths below according to your directory structure
HCMPATH=$(shell pwd)
MINISAT=HCMPATH/minisat/

# required for adding code of minisat to your program
MINISAT_OBJS=$(MINISAT)/core/Solver.o $(MINISAT)/utils/Options.o $(MINISAT)/utils/System.o

CXXFLAGS=-ggdb -O0 -fPIC -I$(HCMPATH)/include -I$(MINISAT)
CFLAGS=-ggdb -O0 -fPIC -I$(HCMPATH)/include -I$(MINISAT)
CC=g++
LDFLAGS= $(MINISAT_OBJS) -L$(HCMPATH)/src -lhcm -Wl,-rpath=$(HCMPATH)/src 

all: FEC # add your executable name here

FEC.o: FEC.cpp clauses.h clauses.cpp 
	g++ -o $@ $^ $(LDFLAGS)
	
clauses.o: clauses.h clauses.cpp
	g++ -o $@ $^ $(LDFLAGS)

#FEC.o: FEC.cc clauses.h clauses.c

# add rules for your executable similar to minisat_api_example

clean: 
	@ rm *.o FEC
