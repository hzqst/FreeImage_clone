# LibOpenJPEG静态库
file(GLOB LIBOPENJPEG_SOURCES "*.c")
list(FILTER LIBOPENJPEG_SOURCES EXCLUDE REGEX ".*test.*\\.c$")
list(FILTER LIBOPENJPEG_SOURCES EXCLUDE REGEX ".*bench.*\\.c$")

add_library(LibOpenJPEG STATIC ${LIBOPENJPEG_SOURCES})

target_include_directories(LibOpenJPEG PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
    $<INSTALL_INTERFACE:include/openjpeg>
)

# 设置输出名称
set_target_properties(LibOpenJPEG PROPERTIES
    OUTPUT_NAME "openjpeg"
    DEBUG_POSTFIX "d"
)