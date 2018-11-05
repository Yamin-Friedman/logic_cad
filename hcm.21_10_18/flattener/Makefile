HCMPATH=$(shell pwd)/../

CXXFLAGS=-Wall -pedantic -ggdb -O0 -fPIC -I$(HCMPATH)/include
CFLAGS=  -Wall -pedantic -ggdb -O0 -fPIC -I$(HCMPATH)/include
CC=g++
LDFLAGS=-L$(HCMPATH)/src -lhcm -Wl,-rpath=$(HCMPATH)/src

all: flattener

flattener: main.o flat.o
	g++ -o $@ $^ $(LDFLAGS)

clean: 
	@ rm flattener $(wildcard *.o) \
	$(wildcard *.so) $(wildcard *.d) $(wildcard *~) || true
