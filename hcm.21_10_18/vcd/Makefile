HCMPATH=$(shell pwd)/../

CXXFLAGS=-Wall -pedantic -ggdb -O0 -fPIC -I$(HCMPATH)/include # -std=c++11
CFLAGS=  -Wall -pedantic -ggdb -O0 -fPIC -I$(HCMPATH)/include 
CC=g++
LDFLAGS=-L$(HCMPATH)/src -lhcm -Wl,-rpath=$(HCMPATH)/src -Wl,-rpath=$(shell pwd)

all: libvcd.so test_vcd

libvcd.so: vcd.o vcd.h
	g++ -shared $(CXXFLAGS) -o $@ $^ $(LDFLAGS) 

test_vcd: main.o 
	g++ -o $@ $^ -L. -lvcd $(LDFLAGS)

clean: 
	@ rm test_vcd $(wildcard *.o) \
	$(wildcard *.so) $(wildcard *.d) $(wildcard *~) || true
