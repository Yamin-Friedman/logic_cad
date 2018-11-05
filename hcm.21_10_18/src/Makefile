CXXFLAGS=-Wall -pedantic -ggdb -O0 -fPIC -I../include -MP -MD 
CFLAGS=-Wall -pedantic -ggdb -O0 -fPIC -I../include   -MP -MD
CC=g++

HCMHDRS := $(wildcard ../include/*.h)

SRC =  	verilog.tab.cpp \
	lex.vlog.cpp  	\
	hcmCell.cpp     \
	hcmDesign.cpp   \
	hcmInstance.cpp \
	hcmInstPort.cpp \
	hcmNode.cpp     \
	hcmObject.cpp   \
	hcmPort.cpp

HCMOBJS = $(SRC:%.cpp=%.o)

all: libhcm.so 

libhcm.so: $(HCMOBJS)
	$(CC) -shared -o $@ $^

verilog.tab.cpp: verilog.ypp 
	bison -p vlog_ -b verilog -d verilog.ypp

lex.vlog.cpp: verilog.lpp
	flex -Pvlog_ -f verilog.lpp
	mv lex.vlog_.c lex.vlog.cpp

clean: 
	@ rm libhcm.so $(wildcard *.o) \
	 $(wildcard *.d) $(wildcard *~) || true

-include $(SRC:%.cpp=%.d)
