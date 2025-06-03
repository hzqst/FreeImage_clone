# LibJXR静态库
file(GLOB_RECURSE LIBJXR_SOURCES 
    "jxrgluelib/*.c"
    "image/sys/*.c"
    "image/decode/*.c"
    "image/encode/*.c"
)

add_library(LibJXR STATIC ${LIBJXR_SOURCES})

target_include_directories(LibJXR PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/jxrgluelib>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/image/sys>
    $<INSTALL_INTERFACE:include/jxr>
)

# 设置输出名称
set_target_properties(LibJXR PROPERTIES
    OUTPUT_NAME "jxr"
    DEBUG_POSTFIX "d"
) 