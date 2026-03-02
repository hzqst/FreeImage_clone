# OpenEXR静态库
file(GLOB_RECURSE OPENEXR_SOURCES 
    "Half/*.cpp"
    "Iex/*.cpp"
    "IlmImf/*.cpp"
    "Imath/*.cpp"
    "IlmThread/*.cpp"
)

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