# FreeImage CMake 构建指南

本项目已转换为使用CMake构建系统。CMake提供了跨平台的构建能力，可以生成Visual Studio项目文件、Makefiles或其他构建系统。

## 系统要求

- CMake 3.16 或更高版本
- 支持C++11的编译器
- Windows: Visual Studio 2017 或更新版本
- Linux: GCC 或 Clang
- macOS: Xcode 或 Clang

## 快速开始

### Windows (Visual Studio)

```bash
# 创建构建目录
mkdir build
cd build

# 生成Visual Studio项目文件
cmake .. -G "Visual Studio 16 2019" -A x64

# 构建项目
cmake --build . --config Release

# 安装到指定目录
cmake --install . --prefix install
```

### Linux/macOS

```bash
# 创建构建目录
mkdir build
cd build

# 配置项目
cmake .. -DCMAKE_BUILD_TYPE=Release

# 构建项目
cmake --build . -j$(nproc)

# 安装到指定目录
cmake --install . --prefix install
```

## 构建选项

### 构建类型

- `Release`: 发布版本（优化）
- `Debug`: 调试版本
- `RelWithDebInfo`: 带调试信息的发布版本
- `MinSizeRel`: 最小尺寸发布版本

### 安装选项

默认安装目录结构：
```
install/
├── bin/           # 动态库 (Windows DLL)
├── lib/           # 静态库和导入库
├── include/       # 头文件
│   ├── FreeImage.h
│   └── FreeImageIO.h
└── lib/cmake/FreeImage/  # CMake包配置文件
```

### 使用已安装的FreeImage

在您的CMake项目中，可以这样使用FreeImage：

#### 现代方式（推荐）

```cmake
find_package(FreeImage REQUIRED)
target_link_libraries(your_target FreeImage::FreeImage)
```

#### 传统方式（向后兼容）

```cmake
find_package(FreeImage REQUIRED)
target_include_directories(your_target PRIVATE ${FREEIMAGE_INCLUDE_DIRS})
target_link_directories(your_target PRIVATE ${FREEIMAGE_LIBRARY_DIRS})
target_link_libraries(your_target ${FREEIMAGE_LIBRARIES})

# 或者简化写法
target_link_libraries(your_target ${FREEIMAGE_LIBRARIES})
target_include_directories(your_target PRIVATE ${FREEIMAGE_INCLUDE_DIRS})
```

#### 可用的传统变量

- `FREEIMAGE_FOUND` - 是否找到FreeImage
- `FREEIMAGE_INCLUDE_DIRS` - 头文件目录
- `FREEIMAGE_LIBRARY_DIRS` - 库文件目录
- `FREEIMAGE_LIBRARIES` - 库文件路径
- `FREEIMAGE_VERSION` - FreeImage版本

#### 使用pkg-config

```cmake
find_package(PkgConfig REQUIRED)
pkg_check_modules(FreeImage REQUIRED freeimage)
target_link_libraries(your_target ${FreeImage_LIBRARIES})
target_include_directories(your_target PRIVATE ${FreeImage_INCLUDE_DIRS})
```

## 项目结构

```
FreeImage/
├── CMakeLists.txt           # 主CMake文件
├── cmake/                   # CMake配置文件
│   ├── FreeImageConfig.cmake
│   └── freeimage.pc.in
├── Source/                  # 源代码
│   ├── FreeImage/          # 核心源文件
│   ├── FreeImageToolkit/   # 工具包源文件
│   ├── Metadata/           # 元数据源文件
│   ├── ZLib/               # ZLib依赖库
│   ├── LibJPEG/            # JPEG依赖库
│   ├── LibPNG/             # PNG依赖库
│   ├── LibTIFF4/           # TIFF依赖库
│   ├── LibWebP/            # WebP依赖库
│   ├── LibJXR/             # JXR依赖库
│   ├── LibOpenJPEG/        # OpenJPEG依赖库
│   ├── LibRawLite/         # RAW依赖库
│   └── OpenEXR/            # OpenEXR依赖库
└── build/                   # 构建目录（用户创建）
```

## 支持的图像格式

FreeImage支持以下图像格式：

- BMP, CUT, DDS, EXR, G3, GIF, HDR, ICO, IFF, J2K, JNG, JP2, JPEG, JXR
- KOALA, MNG, PCD, PCX, PFM, PICT, PNG, PNM, PSD, RAS, RAW, SGI
- TARGA, TIFF, WBMP, WebP, XBM, XPM

## 故障排除

### 常见问题

1. **CMake版本过低**：确保使用CMake 3.16或更高版本
2. **编译器不支持C++11**：请升级您的编译器
3. **依赖库编译失败**：某些依赖库可能需要特定的配置或额外的依赖

### 调试构建问题

如果遇到构建问题，可以启用详细输出：

```bash
cmake --build . --verbose
```

或者查看详细的CMake配置：

```bash
cmake .. -DCMAKE_VERBOSE_MAKEFILE=ON
```

## 许可证

FreeImage使用多种许可证，请查看原项目的许可证文件了解详细信息。

## 贡献

如果您发现CMake构建系统的问题或有改进建议，请提交Issue或Pull Request。 