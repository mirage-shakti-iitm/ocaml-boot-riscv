set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR riscv)
set(CMAKE_CROSSCOMPILING 1)
set(CMAKE_CXX_COMPILER "riscv64-unknown-elf-g++")
set(CMAKE_C_COMPILER "riscv64-unknown-elf-gcc")
set(CMAKE_SHARED_LIBRARY_LINK_C_FLAGS "")
set(CMAKE_SHARED_LIBRARY_LINK_CXX_FLAGS "")
set(CMAKE_EXPORT_COMPILE_COMMANDS 1)
cmake_minimum_required(VERSION 2.6)

enable_language(ASM)

project(ocaml-boot)

set(CMAKE_C_FLAGS "-mcmodel=medany -Og -g -DHTIF")
set(CMAKE_CXX_FLAGS "-mcmodel=medany -Og -g -DHTIF")
#Set Linker flags
set(CMAKE_EXE_LINKER_FLAGS "-static -Wl,-T${CMAKE_CURRENT_SOURCE_DIR}/linker.x -nostartfiles")

# build arch specific library
include_directories(arch)
add_subdirectory(arch)
