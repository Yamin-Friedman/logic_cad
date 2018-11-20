HCMPATH=$(shell pwd)/../

CXXFLAGS=-ggdb -O0 -fPIC -I$(HCMPATH)/include -I$(HCMPATH)/flattener
CFLAGS=-ggdb -O0 -fPIC -I$(HCMPATH)/include -I$(HCMPATH)/flattener
CC=g++
LDFLAGS=-L$(HCMPATH)/src -lhcm -Wl,-rpath=$(HCMPATH)/src 

all: gl_rank gl_stat

gl_rank: rank.o 
	g++ -o $@ $^ $(LDFLAGS) $(HCMPATH)/flattener/flat.o

gl_stat: stat.o
	g++ -o $@ $^ $(LDFLAGS)

clean:
	 @ rm *.o gl_stat gl_rank
