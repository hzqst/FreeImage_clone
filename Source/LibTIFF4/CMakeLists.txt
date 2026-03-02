# LibTIFF4静态库
set(LIBTIFF_SOURCES
    tif_aux.c
    tif_close.c
    tif_codec.c
    tif_color.c
    tif_compress.c
    tif_dir.c
    tif_dirinfo.c
    tif_dirread.c
    tif_dirwrite.c
    tif_dumpmode.c
    tif_error.c
    tif_extension.c
    tif_fax3.c
    tif_fax3sm.c
    tif_flush.c
    tif_getimage.c
    tif_jbig.c
    tif_jpeg.c
    tif_luv.c
    tif_lzw.c
    tif_next.c
    tif_ojpeg.c
    tif_open.c
    tif_packbits.c
    tif_pixarlog.c
    tif_predict.c
    tif_print.c
    tif_read.c
    tif_strip.c
    tif_swab.c
    tif_thunder.c
    tif_tile.c
    tif_version.c
    tif_warning.c
    tif_write.c
    tif_zip.c
)

# 添加Windows或Unix特定的源文件
if(WIN32)
    list(APPEND LIBTIFF_SOURCES tif_win32.c)
else()
    list(APPEND LIBTIFF_SOURCES tif_unix.c)
endif()

add_library(LibTIFF4 STATIC ${LIBTIFF_SOURCES})

target_include_directories(LibTIFF4 PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
    $<INSTALL_INTERFACE:include/tiff>
)

# 链接依赖
target_link_libraries(LibTIFF4 PRIVATE ZLib LibJPEG)

# 设置输出名称
set_target_properties(LibTIFF4 PROPERTIES
    OUTPUT_NAME "tiff"
    DEBUG_POSTFIX "d"
) 