cmake_minimum_required(VERSION 3.13)

# Project name is arbitrary
project(pico_ci_blink C CXX ASM)

# Use pre-cloned SDK pointed to by environment variable
set(PICO_SDK_PATH $ENV{PICO_SDK_PATH})
include(${PICO_SDK_PATH}/external/pico_sdk_import.cmake)

pico_sdk_init()

# Add sub-directories with firmware targets
add_subdirectory(blink)
