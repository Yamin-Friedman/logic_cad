cmake_minimum_required(VERSION 3.6)
project(ClionProject)

set(CMAKE_CXX_STANDARD 11)
set(SOURCE_FILES

       FEC.cpp clauses.h clauses.cpp)
file(GLOB hcm.21_10_18
        "*.h"
        "*.cc"
        "*.cpp"
        )
file(GLOB SOURCES
        minisat/core*.h
        minisat/core*.cc
        hcm.21_10_18/include/*.h
        hcm.21_10_18/include/*.cpp
        hcm.21_10_18/src/*.h
        hcm.21_10_18/src/*.cpp
        hcm.21_10_18/flattener/*.h
        hcm.21_10_18/flattener/flat.cc
        hcm.21_10_18/sigvec/*.h
        hcm.21_10_18/sigvec/sigvec.cc
        hcm.21_10_18/hcm_vcd/*.h
        hcm.21_10_18/hcm_vcd/vcd.cc
        hcm.21_10_18/*.h
        hcm.21_10_18/*.cpp
        )

include_directories(
        minisat/core
        minisat
        hcm.21_10_18
        hcm.21_10_18/src
        hcm.21_10_18/include
        hcm.21_10_18/hcm_vcd
        hcm.21_10_18/flattener
        hcm.21_10_18/vcd
        hcm.21_10_18/sigvec)

add_executable(ClionProject ${SOURCE_FILES} ${hcm.21_10_18} ${SOURCES})