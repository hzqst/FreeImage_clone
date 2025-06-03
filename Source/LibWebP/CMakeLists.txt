# LibWebP静态库
file(GLOB_RECURSE LIBWEBP_SOURCES 
    "src/dec/*.c"
    "src/enc/*.c"
    "src/dsp/*.c"
    "src/utils/*.c"
    "src/webp/*.c"
)

add_library(LibWebP STATIC ${LIBWEBP_SOURCES})

target_include_directories(LibWebP PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/src>
    $<INSTALL_INTERFACE:include/webp>
)

# 设置输出名称
set_target_properties(LibWebP PROPERTIES
    OUTPUT_NAME "webp"
    DEBUG_POSTFIX "d"
) 