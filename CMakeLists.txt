cmake_minimum_required(VERSION 3.5)

# FIXME: should be in parent cmake file
# cross-compiling setup
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR riscv)
set(CMAKE_CROSSCOMPILING 1)
set(CMAKE_CXX_COMPILER "riscv64-unknown-elf-g++")
set(CMAKE_C_COMPILER "riscv64-unknown-elf-gcc")
set(CMAKE_ASM_COMPILER "riscv64-unknown-elf-gcc")
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

project(ocaml-boot-riscv
    VERSION 0.1
    LANGUAGES ASM CXX 
    )

set(CMAKE_EXPORT_COMPILE_COMMANDS 1)

# FIXME: should be in parent cmake file
# FIXME: make this use set_target_properties
# linker & compiler flags
set(CMAKE_C_FLAGS "-mcmodel=medany -Og -g -DHTIF")
set(CMAKE_CXX_FLAGS "-mcmodel=medany -Og -g -DHTIF")

# build a library
add_library(ocaml-boot-riscv
    src/constructors.cc
    src/htif.cc
    src/print.cc
    src/string.cc
    src/trap.cc
    src/uart.cc
    src/startup.cc
    src/startup.S
)

# includes
target_include_directories(ocaml-boot-riscv
    PUBLIC
    $<INSTALL_INTERFACE:include> 
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/src
    )

# set VERSION properly
set_target_properties(ocaml-boot-riscv 
    PROPERTIES VERSION ${PROJECT_VERSION}
    )

# declare public header
set_target_properties(ocaml-boot-riscv  
    PROPERTIES PUBLIC_HEADER 
    ${CMAKE_CURRENT_SOURCE_DIR}/include/boot.h
    )

# install library
include(GNUInstallDirs)
install(TARGETS ocaml-boot-riscv
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR} 
    PUBLIC_HEADER DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}/ocaml-boot-riscv/"
    INCLUDES DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}/ocaml-boot-riscv/"
    )
install(
    DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/include/" DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}/ocaml-boot-riscv"
    )

# pkg-config support
configure_file(
	${CMAKE_CURRENT_SOURCE_DIR}/ocaml-boot-riscv.pc.in 
	ocaml-boot-riscv.pc 
	@ONLY
)
install(
	FILES ${CMAKE_BINARY_DIR}/ocaml-boot-riscv.pc 
	DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/pkgconfig
)
