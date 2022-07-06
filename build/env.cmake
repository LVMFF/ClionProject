cmake_minimum_required(VERSION 3.15)

if(NOT ROOT_DIR)
    get_filename_component(ROOT_DIR "${CMAKE_CURRENT_SOURCE_DIR}" ABSOLUTE)
endif()

set(INSTALL_PREFIX ${ROOT_DIR}/output)

message(STATUS ROOT_DIR: ${ROOT_DIR})
message(STATUS INSTALL_PREFIX: ${INSTALL_PREFIX})