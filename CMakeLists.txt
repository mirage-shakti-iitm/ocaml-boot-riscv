cmake_minimum_required(VERSION 3.5)

# cross-compiling setup
# CMAKE_CXX_COMPILER can't be set twice
if(NOT CMAKE_CROSSCOMPILING)
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
endif(NOT CMAKE_CROSSCOMPILING)

project(ocaml-boot-riscv
    VERSION 0.1
    LANGUAGES ASM CXX 
    )

set(CMAKE_EXPORT_COMPILE_COMMANDS 1)


# build a library
add_library(boot
    src/constructors.cc
    src/htif.cc
    src/print.cc
    src/string.cc
    src/trap.cc
    src/uart.cc
    src/startup.cc
    src/startup.S
)

target_compile_options(boot INTERFACE
    "-mcmodel=medany"
    )

set(OUTPUT_MODE "htif" CACHE STRING "set the output mode to use, possible values are htif, qemu (for qemu uart) or shakti")
if(OUTPUT_MODE STREQUAL "htif")
    target_compile_definitions(boot PRIVATE HTIF)
elseif(OUTPUT_MODE STREQUAL "qemu")
    target_compile_definitions(boot PRIVATE QEMU_UART)
elseif(OUTPUT_MODE STREQUAL "shakti")
    target_compile_definitions(boot PRIVATE SHAKTI_UART)
else()
    message(FATAL_ERROR "please define a valid output mode to use, possible values include: htif, qemu or shakti")
endif()


# includes
target_include_directories(boot
    PUBLIC
    $<INSTALL_INTERFACE:include> 
    $<INSTALL_INTERFACE:include/ocaml-boot-riscv> 
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include/ocaml-boot-riscv>
    PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/src
    )

# set VERSION properly
set_target_properties(boot
    PROPERTIES VERSION ${PROJECT_VERSION}
    )

set_target_properties(boot
    PROPERTIES PUBLIC_HEADER 
    ${CMAKE_CURRENT_SOURCE_DIR}/include/ocaml-boot-riscv.h
    )

# installing include
include(GNUInstallDirs)
# install library
install(TARGETS boot EXPORT boot-targets
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR} 
    PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
    INCLUDES DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}/ocaml-boot-riscv/"
    )
install(
    DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/include/" 
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
    )

# generate boot{Config,Version}.cmake
include(CMakePackageConfigHelpers)
write_basic_package_version_file(
  "${CMAKE_CURRENT_BINARY_DIR}/ocaml-boot-riscv/bootConfigVersion.cmake"
  VERSION ${PROJECT_VERSION}
  COMPATIBILITY AnyNewerVersion
)

set(ConfigPackageLocation lib/cmake/ocaml-boot-riscv)
configure_file(cmake/bootConfig.cmake
  "${CMAKE_CURRENT_BINARY_DIR}/ocaml-boot-riscv/bootConfig.cmake"
  COPYONLY
)
install(
  FILES
    cmake/bootConfig.cmake
    "${CMAKE_CURRENT_BINARY_DIR}/ocaml-boot-riscv/bootConfigVersion.cmake"
  DESTINATION
    ${ConfigPackageLocation}
)

#export targets
export(EXPORT boot-targets
  FILE "${CMAKE_CURRENT_BINARY_DIR}/ocaml-boot-riscv/bootTargets.cmake"
  NAMESPACE ocaml-boot-riscv::
)
install(EXPORT boot-targets
    FILE
    bootTargets.cmake
    NAMESPACE
    ocaml-boot-riscv::
    DESTINATION
    ${ConfigPackageLocation}
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
