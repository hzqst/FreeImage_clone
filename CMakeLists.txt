cmake_minimum_required(VERSION 3.16)

project(FreeImage VERSION 3.18.0 LANGUAGES C CXX)

# 设置C++标准
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# 设置输出目录
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)

# 设置调试后缀
set(CMAKE_DEBUG_POSTFIX "d")

option(USE_VCLTL "USE VCLTL" OFF)

if(USE_VCLTL)
include("VC-LTL helper for cmake.cmake")
endif()

# 编译选项
if(WIN32)
    add_definitions(-DWIN32 -D_WINDOWS -D_USRDLL -DFREEIMAGE_EXPORTS -D_CRT_SECURE_NO_DEPRECATE)
    add_definitions(-DOPJ_STATIC -DLIBRAW_NODLL)
    
    # 设置运行时库
    if(CMAKE_BUILD_TYPE STREQUAL "Debug")
        set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /MTd")
        set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} /MTd")
    else()
        set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} /MT /O2 /Ob2 /DNDEBUG")
        set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} /MT /O2 /Ob2 /DNDEBUG")
    endif()
    
    # 设置结构体对齐
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /Zp16")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} /Zp16")
endif()

# 添加子目录构建依赖库
add_subdirectory(Source/ZLib)
add_subdirectory(Source/LibJPEG)
add_subdirectory(Source/LibPNG)
add_subdirectory(Source/LibTIFF4)
add_subdirectory(Source/LibWebP)
add_subdirectory(Source/LibJXR)
add_subdirectory(Source/LibOpenJPEG)
add_subdirectory(Source/LibRawLite)
add_subdirectory(Source/OpenEXR)

# 收集FreeImage源文件
file(GLOB FREEIMAGE_SOURCES
    "Source/FreeImage/*.cpp"
    "Source/FreeImage/*.c"
)

file(GLOB FREEIMAGE_TOOLKIT_SOURCES
    "Source/FreeImageToolkit/*.cpp"
)

file(GLOB METADATA_SOURCES
    "Source/Metadata/*.cpp"
)

# 收集头文件
file(GLOB FREEIMAGE_HEADERS
    "Source/*.h"
    "Source/FreeImage/*.h"
    "Source/FreeImageToolkit/*.h"
    "Source/Metadata/*.h"
)

# 创建FreeImage动态库
add_library(FreeImage SHARED
    ${FREEIMAGE_SOURCES}
    ${FREEIMAGE_TOOLKIT_SOURCES}
    ${METADATA_SOURCES}
    FreeImage.rc
)

# 设置目标属性
set_target_properties(FreeImage PROPERTIES
    OUTPUT_NAME "FreeImage"
    DEBUG_POSTFIX "d"
    VERSION ${PROJECT_VERSION}
    SOVERSION ${PROJECT_VERSION_MAJOR}
)

# 设置包含目录
target_include_directories(FreeImage PRIVATE
    Source
    Source/ZLib
    Source/DeprecationManager
    Source/OpenEXR
    Source/OpenEXR/Half
    Source/OpenEXR/Iex
    Source/OpenEXR/IlmImf
    Source/OpenEXR/Imath
    Source/OpenEXR/IlmThread
    Source/LibJXR/jxrgluelib
    Source/LibJXR/image/sys
)

target_include_directories(FreeImage PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/Source>
    $<INSTALL_INTERFACE:include>
)

# 链接依赖库
target_link_libraries(FreeImage PRIVATE
    ZLib
    LibJPEG
    LibPNG
    LibTIFF4
    LibWebP
    LibJXR
    LibOpenJPEG
    LibRawLite
    OpenEXR
)

# Windows特定设置
if(WIN32)
    target_link_libraries(FreeImage PRIVATE
        kernel32
        user32
        gdi32
        winspool
        comdlg32
        advapi32
        shell32
        ole32
        oleaut32
        uuid
        odbc32
        odbccp32
    )
endif()

# 设置安装规则
install(TARGETS FreeImage
    EXPORT FreeImageTargets
    RUNTIME DESTINATION bin
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
    INCLUDES DESTINATION include
)

# 安装头文件
install(FILES Source/FreeImage.h
    DESTINATION include
)

# 安装其他重要头文件
install(FILES Source/FreeImageIO.h
    DESTINATION include
)

# 创建并安装包配置文件
include(CMakePackageConfigHelpers)

write_basic_package_version_file(
    "${CMAKE_CURRENT_BINARY_DIR}/FreeImageConfigVersion.cmake"
    VERSION ${PROJECT_VERSION}
    COMPATIBILITY AnyNewerVersion
)

export(EXPORT FreeImageTargets
    FILE "${CMAKE_CURRENT_BINARY_DIR}/FreeImageTargets.cmake"
    NAMESPACE FreeImage::
)

configure_file(cmake/FreeImageConfig.cmake
    "${CMAKE_CURRENT_BINARY_DIR}/FreeImageConfig.cmake"
    COPYONLY
)

install(EXPORT FreeImageTargets
    FILE FreeImageTargets.cmake
    NAMESPACE FreeImage::
    DESTINATION lib/cmake/FreeImage
)

install(FILES
    "${CMAKE_CURRENT_BINARY_DIR}/FreeImageConfig.cmake"
    "${CMAKE_CURRENT_BINARY_DIR}/FreeImageConfigVersion.cmake"
    DESTINATION lib/cmake/FreeImage
)

# 创建pkg-config文件
configure_file(cmake/freeimage.pc.in
    "${CMAKE_CURRENT_BINARY_DIR}/freeimage.pc"
    @ONLY
)

install(FILES "${CMAKE_CURRENT_BINARY_DIR}/freeimage.pc"
    DESTINATION lib/pkgconfig
)

# 显示构建信息
message(STATUS "FreeImage ${PROJECT_VERSION}")
message(STATUS "Build type: ${CMAKE_BUILD_TYPE}")
message(STATUS "Install prefix: ${CMAKE_INSTALL_PREFIX}") 