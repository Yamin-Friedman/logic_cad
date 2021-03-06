# Update the paths below according to your directory structure
HCMPATH=$(shell pwd)/hcm.21_10_18/
MINISAT=$(HCMPATH)/../minisat/
FLAT =$(HCMPATH)/flattener/

# required for adding code of minisat to your program
MINISAT_OBJS=$(MINISAT)/core/Solver.o $(MINISAT)/utils/Options.o $(MINISAT)/utils/System.o
FLAT_OBJS=$(HCMPATH)flattener/flat.o

CXXFLAGS=-ggdb -O0 -fPIC -I$(HCMPATH)/include -I$(MINISAT) -I$(FLAT)
CFLAGS=-ggdb -O0-fPIC -I$(HCMPATH)/include -I$(MINISAT) -I$(FLAT)
CC=g++ 
LDFLAGS= $(MINISAT_OBJS) $(FLAT_OBJS) -L$(HCMPATH)/src -lhcm -Wl,-rpath=$(HCMPATH)/src -I$(HCMPATH)/include -o gl_verilog_fev

gl_verilog_fev: FEC.o clauses.o
$(CC) FEC.o clauses.o $(LDFLAGS)

FEC.o: FEC.cpp clauses.o 
	$(CC) -c -o $@ $< $(CXXFLAGS)

clauses.o: clauses.cpp
	$(CC) -c -o $@ $< $(CXXFLAGS)


# add rules for your executable similar to minisat_api_example

clean: 
	@ rm *.o gl_verilog_fev
