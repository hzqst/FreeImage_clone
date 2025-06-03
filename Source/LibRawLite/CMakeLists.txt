# LibRawLite静态库
file(GLOB LIBRAWLITE_SOURCES 
    "src/*.cpp"
    "internal/*.cpp"
)

add_library(LibRawLite STATIC ${LIBRAWLITE_SOURCES})

target_include_directories(LibRawLite PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/src>
    $<INSTALL_INTERFACE:include/libraw>
)

# 设置输出名称
set_target_properties(LibRawLite PROPERTIES
    OUTPUT_NAME "rawlite"
    DEBUG_POSTFIX "d"
) 