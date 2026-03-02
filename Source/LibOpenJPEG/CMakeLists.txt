# LibOpenJPEG静态库 - 基于原始Visual Studio项目文件
set(LIBOPENJPEG_SOURCES
    bio.c
    cio.c
    dwt.c
    event.c
    function_list.c
    image.c
    invert.c
    j2k.c
    jp2.c
    mct.c
    mqc.c
    openjpeg.c
    opj_clock.c
    pi.c
    raw.c
    t1.c
    t2.c
    tcd.c
    tgt.c
)

add_library(LibOpenJPEG STATIC ${LIBOPENJPEG_SOURCES})

# 设置预处理器定义
target_compile_definitions(LibOpenJPEG PRIVATE
    OPJ_STATIC
    _CRT_SECURE_NO_DEPRECATE
)

if(WIN32)
    target_compile_definitions(LibOpenJPEG PRIVATE
        WIN32
        _LIB
    )
endif()

target_include_directories(LibOpenJPEG PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
    $<INSTALL_INTERFACE:include/openjpeg>
)

# 设置输出名称
set_target_properties(LibOpenJPEG PROPERTIES
    OUTPUT_NAME "openjpeg"
    DEBUG_POSTFIX "d"
) 