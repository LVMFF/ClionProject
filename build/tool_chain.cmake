cmake_minimum_required(VERSION 3.15)

set(CMAKE_CXX_STANDARD 17)
# 确保 c++17 生效
set(CMAKE_CXX_STANDARD_REQUIRED on)
# 生成 compile_commands.json 文件，包含所有编译单元所执行的指令
set(CMAKE_EXPORT_COMPILE_COMMANDS on)

# macro(get_WIN32_WINNT version)
#     if (WIN32 AND CMAKE_SYSTEM_VERSION)
#         set(ver ${CMAKE_SYSTEM_VERSION})
#         string(REPLACE "." "" ver ${ver})
#         string(REGEX REPLACE "([0-9])" "0\\1" ver ${ver})

#         set(${version} "0x${ver}")
#     endif()
# endmacro()

# get_WIN32_WINNT(ver)
# add_definitions(-D_WIN32_WINNT=${ver})

# if(WIN32)
#     set(CMAKE_SYSTEM_NAME Windows)
#     set(CMAKE_C_COMPILER D:/Users/h00679994/scoop/apps/Clion/2022.1/installed/bin/mingw/bin/gcc.exe CACHE PATH "gcc compiler")
#     set(CMAKE_CXX_COMPILER  D:/Users/h00679994/scoop/apps/Clion/2022.1/installed/bin/mingw/bin/g++.exe CACHE PATH "g++ compiler")
# else()
    set(CMAKE_SYSTEM_NAME Linux)
    set(CMAKE_C_COMPILER    /root/cpp/ClionProject/build/buildtools/gcc-7.3.0/bin/gcc CACHE PATH "gcc compiler")
    set(CMAKE_CXX_COMPILER  /root/cpp/ClionProject/build/buildtools/gcc-7.3.0/bin/g++ CACHE PATH "g++ compiler")
# endif()

set(CMAKE_C_FLAGS "-m32 -g -fno-PIE -no-pie -Wall -fPIC -fno-strict-aliasing -MD -MP -MT -pedantic")
set(CMAKE_CXX_FLAGS "-m32 -g -Wall -Werror -fPIC")