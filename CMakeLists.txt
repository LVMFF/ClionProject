cmake_minimum_required(VERSION 3.15)

include(build/modules/build_library.cmake)
include(build/env.cmake)
include(build/tool_chain.cmake)


# project 已在 build_library.cmake 中重新定义
project(ClionProject)

add_subdirectory(code)
