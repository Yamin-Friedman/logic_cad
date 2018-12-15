HCMPATH=$(shell pwd)/../

CXXFLAGS=-ggdb -O0 -fPIC -I$(HCMPATH)/include -I$(HCMPATH)/flattener -I$(HCMPATH)/sigvec -I$(HCMPATH)/hcm_vcd
CFLAGS=-ggdb -O0 -fPIC -I$(HCMPATH)/include -I$(HCMPATH)/flattener -I$(HCMPATH)/sigvec -I$(HCMPATH)/hcm_vcd
CC=g++
LDFLAGS=-L$(HCMPATH)/src -lhcm -Wl,-rpath=$(HCMPATH)/src  -L$(HCMPATH)/sigvec -lhcmsigvec -L$(HCMPATH)/hcm_vcd

all: event_sim

event_sim: event_sim.o
	g++ -o $@ $^ $(LDFLAGS) $(HCMPATH)/flattener/flat.o $(HCMPATH)/hcm_vcd/vcd.o


clean:
	 @ rm *.o gl_stat gl_rank
