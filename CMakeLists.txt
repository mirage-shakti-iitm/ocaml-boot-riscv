set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR riscv)
set(CMAKE_CROSSCOMPILING 1)
set(CMAKE_CXX_COMPILER "riscv64-unknown-elf-g++")
set(CMAKE_C_COMPILER "riscv64-unknown-elf-gcc")
set(CMAKE_SHARED_LIBRARY_LINK_C_FLAGS "")
set(CMAKE_SHARED_LIBRARY_LINK_CXX_FLAGS "")
set(CMAKE_EXPORT_COMPILE_COMMANDS 1)
cmake_minimum_required(VERSION 3.5)

enable_language(ASM)

project(ocaml-boot-riscv VERSION 0.1)

# linker & compiler flags
# XXX: make this use set_target_properties
set(CMAKE_C_FLAGS "-mcmodel=medany -Og -g -DHTIF")
set(CMAKE_CXX_FLAGS "-mcmodel=medany -Og -g -DHTIF")

#Set Linker flags
set(CMAKE_EXE_LINKER_FLAGS "-static -Wl,-T${CMAKE_CURRENT_SOURCE_DIR}/linker.x -nostartfiles")

# build a library
add_library(ocaml-boot-riscv
    src/constructors.cc
    src/htif.cc
    src/startup.cc
    src/string.cc
    src/print.cc
    src/trap.cc
    src/uart.cc
    src/ocaml-freestanding-compat.cc
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
set_target_properties(ocaml-boot-riscv PROPERTIES VERSION ${PROJECT_VERSION})

# declare public header
set_target_properties(ocaml-boot-riscv PROPERTIES PUBLIC_HEADER ${CMAKE_CURRENT_SOURCE_DIR}/include/ocaml-boot-riscv.h)

# install library
include(GNUInstallDirs)
install(TARGETS ocaml-boot-riscv
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR} 
    PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
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
