HCMPATH=$(shell pwd)/../

CXXFLAGS=-Wall -pedantic -ggdb -O0 -fPIC -I../include -MP -MD 
CFLAGS=  -Wall -pedantic -ggdb -O0 -fPIC -I../include -MP -MD

CC=g++
LDFLAGS=-L$(HCMPATH)/src -lhcm -Wl,-rpath=$(HCMPATH)/src

all: hcm_test parse_test

hcm_test: main.o 
	g++ -o $@ $^ $(LDFLAGS)

parse_test: parse_test.o
	g++ -o $@ $^ $(LDFLAGS)

clean: 
	@ rm hcm_test parse_test $(wildcard *.o) \
	$(wildcard *.so) $(wildcard *.d) $(wildcard *~) || true

