HCMPATH=$(shell pwd)/../

CXXFLAGS=-Wall -pedantic -ggdb -O0 -fPIC -I$(HCMPATH)/include 
CFLAGS=  -Wall -pedantic -ggdb -O0 -fPIC -I$(HCMPATH)/include 
CC=g++
LDFLAGS=-L$(HCMPATH)/src -lhcm -Wl,-rpath=$(HCMPATH)/src -Wl,-rpath=$(shell pwd)

all: libhcmvcd.so test_vcd

libhcmvcd.so: vcd.o hcmvcd.h
	g++ -shared $(CXXFLAGS) -o $@ $^ $(LDFLAGS) 

test_vcd: main.o 
	g++ -o $@ $^ -L. -lhcmvcd $(LDFLAGS)

clean: 
	@ rm test_vcd $(wildcard *.o) \
	$(wildcard *.so) $(wildcard *.d) $(wildcard *~) || true
