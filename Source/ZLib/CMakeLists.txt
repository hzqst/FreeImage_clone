# ZLib静态库
set(ZLIB_SOURCES
    adler32.c
    compress.c
    crc32.c
    deflate.c
    gzclose.c
    gzlib.c
    gzread.c
    gzwrite.c
    infback.c
    inffast.c
    inflate.c
    inftrees.c
    trees.c
    uncompr.c
    zutil.c
)

add_library(ZLib STATIC ${ZLIB_SOURCES})

target_include_directories(ZLib PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
    $<INSTALL_INTERFACE:include/zlib>
)

# 设置输出名称
set_target_properties(ZLib PROPERTIES
    OUTPUT_NAME "zlib"
    DEBUG_POSTFIX "d"
) 