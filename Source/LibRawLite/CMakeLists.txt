# LibRawLite静态库 - 基于原始Visual Studio项目文件
set(LIBRAWLITE_SOURCES
    internal/dcraw_common.cpp
    internal/dcraw_fileio.cpp
    internal/demosaic_packs.cpp
    src/libraw_c_api.cpp
    src/libraw_cxx.cpp
    src/libraw_datastream.cpp
)

add_library(LibRawLite STATIC ${LIBRAWLITE_SOURCES})

# 设置预处理器定义
target_compile_definitions(LibRawLite PRIVATE
    LIBRAW_NODLL
    _CRT_SECURE_NO_WARNINGS
    _LIB
)

if(WIN32)
    target_compile_definitions(LibRawLite PRIVATE
        WIN32
    )
endif()

target_include_directories(LibRawLite PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/libraw>
    $<INSTALL_INTERFACE:include/libraw>
)

target_include_directories(LibRawLite PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}
    ../ZLib
)

# 链接ZLib
target_link_libraries(LibRawLite PRIVATE ZLib)

# 设置输出名称
set_target_properties(LibRawLite PROPERTIES
    OUTPUT_NAME "rawlite"
    DEBUG_POSTFIX "d"
) 