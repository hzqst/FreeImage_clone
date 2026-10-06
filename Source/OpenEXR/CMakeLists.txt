# OpenEXR静态库
file(GLOB_RECURSE OPENEXR_SOURCES 
    "Half/*.cpp"
    "Iex/*.cpp"
    "IlmImf/*.cpp"
    "Imath/*.cpp"
    "IlmThread/*.cpp"
)

# 生成器程序：各自带 main()，只负责向 stdout 打印查找表头文件，
# 产物 eLut.h / toFloat.h / b44ExpLogTable.h / dwaLookups.h 已随源码提供并被 include，
# 保留会向库中引入多余的 _main 符号（LNK4006）。
list(FILTER OPENEXR_SOURCES EXCLUDE REGEX "/(eLut|toFloat|b44ExpLogTable|dwaLookups)\\.cpp$")

# 单线程 dummy 实现与平台实现互斥：dummy 版的 #if 守卫在源码中被注释掉了，
# 与 Ilm*Win32.cpp 重复定义同一批符号；Posix 版已由 IlmBaseConfig.h 的
# HAVE_PTHREAD / HAVE_POSIX_SEMAPHORES 排除。
if(WIN32)
    list(FILTER OPENEXR_SOURCES EXCLUDE REGEX "/IlmThread\\.cpp$")
    list(FILTER OPENEXR_SOURCES EXCLUDE REGEX "/IlmThreadMutex\\.cpp$")
    list(FILTER OPENEXR_SOURCES EXCLUDE REGEX "/IlmThreadSemaphore\\.cpp$")
endif()

add_library(OpenEXR STATIC ${OPENEXR_SOURCES})

target_include_directories(OpenEXR PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/Half>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/Iex>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/IlmImf>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/Imath>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/IlmThread>
    $<INSTALL_INTERFACE:include/openexr>
)

# 链接ZLib
target_link_libraries(OpenEXR PRIVATE ZLib)

# 设置输出名称
set_target_properties(OpenEXR PROPERTIES
    OUTPUT_NAME "openexr"
    DEBUG_POSTFIX "d"
) 