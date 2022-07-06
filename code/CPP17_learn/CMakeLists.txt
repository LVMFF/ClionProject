# 为了方便测试各个知识点，每个源文件都编译成一个可执行文件

set(CPP17_LEARN_INSTALL_PREFIX ${INSTALL_PREFIX}/CPP17_LEARN)


file(GLOB src_list ${CMAKE_CURRENT_SOURCE_DIR}/ *.cpp)

foreach(exec_file ${src_list})
    get_filename_component(testName ${exec_file} NAME_WE)
    add_executable(${testName} ${exec_file})
    target_include_directories(${testName} PRIVATE ${ROOT_DIR}/code/CPP17_learn)

    set_target_properties(${testName} PROPERTIES LINKER_LANGUAGE CXX)
    install(TARGETS ${testName} DESTINATION ${CPP17_LEARN_INSTALL_PREFIX})
endforeach(exec_file ${src_list})