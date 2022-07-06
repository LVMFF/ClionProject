<!-- TOC -->

- [CMake基础](#cmake基础)
  - [常用命令及内置变量](#常用命令及内置变量)
    - [常用命令](#常用命令)
    - [项目构建](#项目构建)
    - [常用内置变量](#常用内置变量)
  - [CMake-tutorial(原文)](#cmake-tutorial原文)
    - [一个基本的出发点 (Step1)](#一个基本的出发点-step1)
    - [添加一个版本号并配置头文件](#添加一个版本号并配置头文件)
    - [添加一个库 (Step 2)](#添加一个库-step-2)
    - [安装与测试 (Step 3)](#安装与测试-step-3)
    - [添加系统自检 (Step 4)](#添加系统自检-step-4)
    - [添加生成文件和生成器 (Step 5)](#添加生成文件和生成器-step-5)
    - [构建安装程序 (Step 6)](#构建安装程序-step-6)
    - [添加对仪表板的支持 (Step 7)](#添加对仪表板的支持-step-7)
- [SSMP_V3](#ssmp_v3)

<!-- /TOC -->

# CMake基础

[CMake汇总贴](http://3ms.huawei.com/hi/group/3145469/wiki_5433765.html)

[Cmake编码规范 -- 语法规范](http://3ms.huawei.com/hi/group/1008821/wiki_5908758.html)

华为公司ICT基础设施产品软件构建规范(见附件)

## 常用命令及内置变量

### 常用命令

下面三个命令的详细使用：  
[cmake：target_** 中的 PUBLIC，PRIVATE，INTERFACE:](https://zhuanlan.zhihu.com/p/82244559)  

```cmake
target_include_directories (<target> [SYSTEM] [BEFORE]
  <INTERFACE|PUBLIC|PRIVATE> [items1...]
  [<INTERFACE|PUBLIC|PRIVATE> [items2...] ...])
```
> 指定目标包含的头文件路径。指定编译目标文件的时候需要包含的路径和内容， <target> 必须是一个已经通过诸如 add_executable()或者add_library()函数创建了的目标，并且不是一个标注成IMPORTED目标。
> INTERFACE, PUBLIC 和 PRIVATE这些关键字用来指定后面这些参数的作用范围。PUBLIC和INTERFACE的条目会产生目标对象的INTERFACE_INCLUDE_DIRECTORIES属性（也就是说添加了的公共默认搜索路径），后面的参数定义了包含路径。
>指定的包含路径可以是绝对路径也可以是相对路径，重复调用相同的<target>会把这些条目按次序添加到对象上。如果指定了SYSTEM属性，则意味着这个路径是一个系统路径
> [官方文档](https://cmake.org/cmake/help/v3.15/command/target_include_directories.html?highlight=target_include_directories)

target_link_libraries()：指定目标链接的库。[官方文档](https://cmake.org/cmake/help/v3.15/command/target_link_libraries.html?highlight=target_link_libraries)

target_compile_options()：指定目标的编译选项。[官方文档](https://cmake.org/cmake/help/v3.15/command/target_compile_options.html#command:target_compile_options)

`include_directories ([AFTER|BEFORE] [SYSTEM] dir1 [dir2 ...])`  将指定目录添加到编译器的头文件搜索路径之下，指定的目录被解释成当前源码路径的相对路径。

`break()：` 从foreach循环或while循环跳出。

`continue()：` 开始迭代下一轮foreach循环或while循环。

`cmake_minimum_required(VERSION 3.10)：`要求的cmake最低版本，此处设置最低版本为3.10。

`configure_file()：` 将输入文件内容修改并拷贝到输出文件，使得在cmake中定义的变量在代码文件中也可以被使用，通常是宏定义作为开关。

`if(),else(),elseif()：` 判断命令，和代码中的逻辑判断一个用处。

foreach(),endforeach()：循环命令的开始和结束。
while(),endwhile()：循环命令的开始和结束。

[CMake 函数和宏](https://elloop.github.io/tools/2016-04-11/learning-cmake-3-function-macro)
`function(),endfunction()：` 自定义函数的开始和结尾。
`macro()、endmacro()：:` 与 function() 相比类似于宏替换

`execute_process :` 调用shell命令或者脚本
```cmake
execute_process(COMMAND <cmd1> [args1...]]
                [COMMAND <cmd2> [args2...] [...]]
                [WORKING_DIRECTORY <directory>]
                [TIMEOUT <seconds>]
                [RESULT_VARIABLE <variable>]
                [OUTPUT_VARIABLE <variable>]
                [ERROR_VARIABLE <variable>]
                [INPUT_FILE <file>]
                [OUTPUT_FILE <file>]
                [ERROR_FILE <file>]
                [OUTPUT_QUIET]
                [ERROR_QUIET]
                [OUTPUT_STRIP_TRAILING_WHITESPACE]
                [ERROR_STRIP_TRAILING_WHITESPACE])
```  
>  1. 按指定的先后顺序运行一个或多个命令，每个进程的输出通过管道连接作为下一个进程的输入。所有的进程使用单个的标准错误输出管道。 
>  2. 如果指定了 WORKING_DIRECTORY，则指定的目录将作为子进程当前的工作目录。
>  3. 如果指定了 TIMEOUT 值，则如果在指定的时间内（以秒为单位计算，允许有小数位）子进程执行仍未完成，则将会被中断。
>  4. 如果指定了 RESULT_VARIABLE 变量，则最后命令执行的结果将保存在该变量中，它是最后一个子进程执行完后的返回值或描述某种错误信息的字符串。
> 5. 如果指定了 OUTPUT_VARIABLE 或 ERROR_VARIABLE 变量，则该变量会分别保存标准输出和标准错误输出的内容。
> 6. 如果指定的变量是同一个，则输出会按产生的先后顺序保存在该变量中。
> 7. 如果指定了 INPUT_FILE，UTPUT_FILE或ERROR_FILE等文件名，则它们会分别与第一个子进程的标准输入，最后一个子进程的标准输出以及所有子进程的标准错误输出相关联。
> 8. 如果指定了OUTPUT_QUIET或ERROR_QUIET，则会忽略标准输出和错误输出。如果在同一管道中同时指定了多个OUTPUT_*或ERROR_*选项，则优先级顺序是未知的（应避免这种情况）。
> 9. 如果未指定任何OUTPUT_*或ERROR_*选项，则命令CMake所在进程共享输出管道。

`find_file() ：` 寻找文件的完整路径。
`find_library() ：` 在指定路径中寻找库。
`find_package() ；`查找并加载一个外来工程的设置。
`find_path() ：`查找给定文件的路径。
`find_program() ：`查找程序。

```cmake
get_filename_component(<VAR> FileName
                       PATH|ABSOLUTE|NAME|EXT|NAME_WE|REALPATH
                       [CACHE])
```
> 将变量<VAR>设置为路径(PATH)，文件名(NAME)，文件扩展名(EXT)，去掉扩展名的文件名(NAME_WE)，完整路径(ABSOLUTE)，或者所有符号链接被解析出的完整路径(REALPATH)。注意，路径会被转换为Unix的反斜杠(/)，并且没有结尾的反斜杠。该命令已经考虑了最长的文件扩展名。如果指定了CACHE选项，得到的变量会被加到cache中。


`include() ：`从给定的文件或者模块中读取cmake中的命令代码，并立即执行。

list()：列表操作命令。使用set()命令可以创建一个list。
```cmake
    list(LENGTH <list><output variable>)                                      返回list的长度
    list(GET <list> <elementindex> [<element index> ...]<output variable>)    返回list中index的element到value中
    list(APPEND <list><element> [<element> ...])                              添加新element到list中
    list(FIND <list> <value><output variable>)                                返回list中element的index，没有找到返回-1
    list(INSERT <list><element_index> <element> [<element> ...])              将新element插入到list中index的位置
    list(REMOVE_ITEM <list> <value>[<value> ...])                             从list中删除某个element
    list(REMOVE_AT <list><index> [<index> ...])                               从list中删除指定index的element
    list(REMOVE_DUPLICATES <list>)                                            从list中删除重复的element
    list(REVERSE <list>)                                                      将list的内容反转
    list(SORT <list>)                                                         将list按字母顺序排序
```

math()：计算数学表达时后返回结果。

`message()：` 给用户显示一条信息，可设置关键字指定信息的级别。

`option()：`   为用户提供一个可选项。([深入学习](https://blog.csdn.net/haima1998/article/details/23352881))

return()：从一个文件，路径或者函数返回，把控制权传给父。

set_directory_properties()：为当前路径及其子路径设置属性。

`set()：` 将一个cmake变量设置为指定值。 ([深入学习](https://www.jianshu.com/p/c2c71d5a09e9))
`unset()：`撤销一个变量，使其变成未定义的。

set_property()：在给定的作用域内设置一个命名的属性。

variable_watch()：监控canke中变量的变化，发生变化的话会被打印。

工程命令
add_custom_command()：添加自定义个命令构建规则。 


`add_custom_target() ：` 添加一个目标，它没有输出，这样它总是被构建。
>

add_definitions(),remove_definitions()：在编译器的命令行上，为当前目录和其子目录里的所有源文件加入一些flag。

`add_dependencies() ：` 为顶层目标添加一个依赖关系，可以保证某个目标在其他的目标之前被构建。
> 假设我们需要生成一个可执行文件,该文件生成需要链接a.so b.so c.so d.so四个动态库
>  正常来讲,我们一把只需要以下两条指令即可:
>  ```cmake
>  ADD_EXECUTABLE(main main.cpp)
>  TARGET_LINK_LIBRARIES(main a.so b.so c.so d.so)
>  ```
>  但是编译的时候报错,一些符号的定义找不到,而这些符号恰恰就在这几个库中,假设在a.so 和 b.so中,在上述两条指令之间加上一条指令即可编译通过:
> ```cmake
> ADD_DEPENDENCIES(main a.so b.so)
> ```
>原因比较简单,生成main需要依赖a.so和b.so中的符号定义,然而a.so和b.so库的生成是在main编译生产之后的,添加这条语句就是提醒编译器需要先生成main的依赖(a.so,b.so),然后再去生成main.


`add_executable()：` 使用给定的源文件为工程生成一个可执行文件。

`add_library(<name> [STATIC | SHARED | MODULE] [EXCLUDE_FROM_ALL] source1 [source2 ...])：`  将指定的源文件生成链接文件，然后添加到工程中去
>   name：表示库文件的名字，该库文件会根据命令里列出的源文件来创建。
    [STATIC | SHARED | MODULE]
    STATIC：表示生成静态库，编译时生成
    SHARED：表示生成共享（动态）库，运行时被加载
    MODULE：一种不会被链接到其它目标中的插件，但是可能会在运行时动态加载
    OBJECT： 用来定义编译源代码生成的Object文件集合,它可以被作为其它目标的输入来源; 在链接阶段，使用`Object`库的其它目标会直接链接这些Object文件。
    add_library(archive OBJECT archive.cpp zip.cpp lzma.cpp)
    add_library(archiveExtras STATIC extras.cpp)
    target_link_libraries(archiveExtras PUBLIC archive)
    add_executable(test_exe test.cpp)
    target_link_libraries(test_exe archive)



```
set_target_properties(target1 target2 ...
                      PROPERTIES prop1 value1
                      prop2 value2 ...) 
```
为Target设置属性和编译标志等，举例如下：
```cmake
# 为Target设置属性
set_target_properties(my_library_shared
  PROPERTIES
    # -fPIC 生成位置无关代码
    POSITION_INDEPENDENT_CODE 1
    # 设置库版本号为工程主版本号
    SOVERSION ${PROJECT_VERSION_MAJOR}
    # 重设动态库输出的名称，my_library_shared → my_library
    OUTPUT_NAME "my_library"
    # 为Debug模式下生成的库添加后缀
    DEBUG_POSTFIX "_d"
    # 为该库指定PUBLIC可见的头文件，一般用于指定包含外部接口的头文件
    PUBLIC_HEADER
      ${CMAKE_CURRENT_SOURCE_DIR}/include/my_library.h
  )

# 为Target设置编译标志，编译标志的可见性同上所属
target_compile_options(my_library_shared
  PRIVATE
    -std=c++11
  )
```

`cmake_parse_arguments`: 参数解析
```cmake
cmake_minimum_required(VERSION 3.5)

project(test)

function(test_parse)
    set( options op1 op2 op3 )
    set( oneValueArgs v1 v2 v3 )
    set( multiValueArgs m1 m2 )
    message( STATUS "options ====== ${options}" )
    message( STATUS "oneValueArgs = ${oneValueArgs}" )
    message( STATUS "multiValueArgs = ${multiValueArgs}" )
    cmake_parse_arguments( MYPRE "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN} )
    message("op1  = ${MYPRE_op1}")
    message("op2  = ${MYPRE_op2}")
    message("op3  = ${MYPRE_op3}")

    message("v1  = ${MYPRE_v1}")
    message("v2  = ${MYPRE_v2}")
    message("v3  = ${MYPRE_v3}")

    message("m1  = ${MYPRE_m1}")
    message("m2  = ${MYPRE_m2}")
endfunction()

message( STATUS "\n" )
test_parse( A B C v1 aaa v2 111 v3 bbb m1 1 2 3 4 5 m2 a b c )

message( STATUS "\n" )
test_parse(op1 op3 v1 aaa v2 111 v3 bbb m1 1 2 3 4 5 m2 a b c )

message( STATUS "\n" )
test_parse(op1 op3 v1 aaa v2 v3 bbb m1 1 2 3 4 5  )

message( STATUS "\n" )
test_parse( op1  v1 aaa v2 op2 111 v3 bbb m1 1 2 3 4 5 m2 a b c op3 )
```

`add_subdirectory()：` 为构建添加一个子路径。

`add_test()：` 添加测试。

`aux_source_directory(<dir> <variable>)：` 查找在某个路径下的所有源码。主要用在使用显式模板实例化的工程上。

`target_sources() :` 添加用来构建目标的源文件  (C++的源文件指定为Private，是因为源文件只是在构建库文件是使用，头文件指定为Public是因为构建和编译时都会使用。)

- [add_compile_options、add_definitions、target_compile_definitions、build_command](https://www.cnblogs.com/the-capricornus/p/4766331.html)
  `add_compile_options() : ` 增加源文件的编译选项,eg: add_compile_options(-Wall -Wextra -pedantic -Werror -g)

  `add_definitions() :` 为源文件的编译添加由-D定义的标志

  `target_compile_definitions() :` 为目标增加编译定义。

  `build_command() :` 获取构建该工程的命令行。通常是供CTest模块的内部使用


[install()：](https://zhuanlan.zhihu.com/p/102955723)  指定在安装时要运行的规则。

link_directories()：指定连接器查找库的路径。

link_libraries()：

project()：

target_link_libraries : 将给定的库链接到目标上:
```cmake
target_link_libraries(<target> [item1 [item2 [...]]]
                      [[debug|optimized|general] <item>] ...)：
```
> 上述指令中的 <target> 是指通过 add_executable() 和 add_library() 指令生成已经创建的目标文件。而[item]表示库文件没有后缀的名字。默认情况下，库依赖项是传递的。当这个目标链接到另一个目标时，链接到这个目标的库也会出现在另一个目标的连接线上。这个传递的接口存储在 interface_link_libraries 的目标属性中，可以通过设置该属性直接重写传递接口。

生成器表达式: 语法是 `$<...>`


- `file :` :文件操作命令
    - file(GLOB variable [RELATIVE path] [globbing expressions]...) ： 产生一个由所有匹配 globbing 表达式的文件组成的列表，并将其保存到变量中
    - file(REMOVE_RECURSE [file1 ...]) ： REMOVE_RECURSE 会删除指定的文件及子目录，包括非空目录。
_
### 常用内置变量

`CMAKE_BINARY_DIR, PROJECT_BINARY_DIR ： ` 这两个变量内容一致，如果是内部编译，就指的是工程的顶级目录，如果是外部编译，指的就是工程编译发生的目录。
`CMAKE_CURRENT_SOURCE_DIR：` CMakeList.txt所在的目录
`CMAKE_CURRENT_LIST_DIR：` CMakeList.txt的完整路径
`CMAKE_CURRENT_LIST_LINE：`当前所在的行
`CMAKE_MODULE_PATH：`如果工程复杂，可能需要编写一些cmake模块，这里通过SET指定这个变量
`LIBRARY_OUTPUT_DIR, BINARY_OUTPUT_DIR：`库和可执行的最终存放目录
`PROJECT_NAME, CMAKE_PROJECT_NAME：` 前者是当前CMakeList.txt里设置的project_name，后者是整个项目配置的project_name





