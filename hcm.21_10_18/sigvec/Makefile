HCMPATH=$(shell pwd)/../

CXXFLAGS=-Wall -pedantic -ggdb -O0 -fPIC -I$(HCMPATH)/include
CFLAGS=  -Wall -pedantic -ggdb -O0 -fPIC -I$(HCMPATH)/include
CC=g++
LDFLAGS=-L$(HCMPATH)/src -lhcm -Wl,-rpath=$(HCMPATH)/src -Wl,-rpath=$(shell pwd)

all: libhcmsigvec.so test_sigvec

libhcmsigvec.so: sigvec.o hcmsigvec.h
	g++ -shared $(CXXFLAGS) -o $@ $^ $(LDFLAGS) 

test_sigvec: main.o 
	g++ -o $@ $^ -L. -lhcmsigvec $(LDFLAGS)

clean: 
	@ rm test_sigvec $(wildcard *.o) \
	$(wildcard *.so) $(wildcard *.d) $(wildcard *~) || true
