# LibPNG静态库
set(LIBPNG_SOURCES
    png.c
    pngerror.c
    pngget.c
    pngmem.c
    pngpread.c
    pngread.c
    pngrio.c
    pngrtran.c
    pngrutil.c
    pngset.c
    pngtrans.c
    pngwio.c
    pngwrite.c
    pngwtran.c
    pngwutil.c
)

add_library(LibPNG STATIC ${LIBPNG_SOURCES})

target_include_directories(LibPNG PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
    $<INSTALL_INTERFACE:include/png>
)

# 链接ZLib
target_link_libraries(LibPNG PRIVATE ZLib)

# 设置输出名称
set_target_properties(LibPNG PROPERTIES
    OUTPUT_NAME "png"
    DEBUG_POSTFIX "d"
)