cmake_minimum_required(VERSION 3.6)
project(ClionProject)

set(CMAKE_CXX_STANDARD 11)
set(SOURCE_FILES stat.cpp

        )
file(GLOB hcm.21_10_18
        "*.h"
        "*.cc"
        )
file(GLOB SOURCES
        hcm.21_10_18/include/*.h
        hcm.21_10_18/include/*.cpp
        hcm.21_10_18/src/*.h
        hcm.21_10_18/src/*.cpp
        hcm.21_10_18/flattener/*.h
        hcm.21_10_18/flattener/flat.cc
        )

include_directories(
        hcm.21_10_18
        hcm.21_10_18/src
        hcm.21_10_18/include
        hcm.21_10_18/hcm_vcd
        hcm.21_10_18/flattener
        hcm.21_10_18/vcd)

add_executable(ClionProject ${SOURCE_FILES} ${hcm.21_10_18} ${SOURCES})