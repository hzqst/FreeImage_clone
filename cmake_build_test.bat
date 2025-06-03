@echo off
setlocal enabledelayedexpansion

echo ========================================
echo FreeImage CMake 构建测试脚本
echo 使用 Visual Studio 2022 工具集
echo ========================================
echo.

:: 检查CMake是否可用
cmake --version >nul 2>&1
if %errorlevel% neq 0 (
    echo 错误: 未找到CMake! 请确保CMake已安装并添加到PATH环境变量中。
    pause
    exit /b 1
)

:: 显示CMake版本
echo 检测到的CMake版本:
cmake --version | findstr "cmake version"
echo.

:: 清理之前的构建
if exist build (
    echo 正在清理之前的构建目录...
    rmdir /s /q build
)

if exist install (
    echo 正在清理之前的安装目录...
    rmdir /s /q install
)

:: 创建构建目录
echo 正在创建构建目录...
mkdir build
if %errorlevel% neq 0 (
    echo 错误: 无法创建构建目录!
    pause
    exit /b 1
)

cd build

:: 配置项目 - 使用Visual Studio 2022
echo.
echo ========================================
echo 正在配置CMake项目...
echo 生成器: Visual Studio 17 2022
echo 平台: x64
echo ========================================
cmake .. -G "Visual Studio 17 2022" -A x64
if %errorlevel% neq 0 (
    echo.
    echo 错误: CMake配置失败!
    echo 可能的原因:
    echo 1. 未安装Visual Studio 2022
    echo 2. 缺少必要的工具链组件
    echo 3. CMakeLists.txt中存在语法错误
    pause
    cd ..
    exit /b 1
)

echo.
echo ========================================
echo CMake配置成功! 
echo ========================================

:: 构建Debug版本
echo.
echo ========================================
echo 正在构建Debug版本...
echo ========================================
cmake --build . --config Debug --parallel
set debug_result=%errorlevel%

if %debug_result% equ 0 (
    echo.
    echo ✓ Debug版本构建成功!
) else (
    echo.
    echo ✗ Debug版本构建失败! (错误代码: %debug_result%)
)

:: 构建Release版本
echo.
echo ========================================
echo 正在构建Release版本...
echo ========================================
cmake --build . --config Release --parallel
set release_result=%errorlevel%

if %release_result% equ 0 (
    echo.
    echo ✓ Release版本构建成功!
) else (
    echo.
    echo ✗ Release版本构建失败! (错误代码: %release_result%)
)

:: 如果至少有一个版本构建成功，则进行安装测试
if %debug_result% equ 0 (
    set install_config=Debug
    goto install_test
)
if %release_result% equ 0 (
    set install_config=Release
    goto install_test
)
goto summary

:install_test
echo.
echo ========================================
echo 正在测试安装 (!install_config! 版本)...
echo ========================================
cmake --install . --prefix ../install --config !install_config!
set install_result=%errorlevel%

if %install_result% equ 0 (
    echo.
    echo ✓ 安装测试成功!
) else (
    echo.
    echo ✗ 安装测试失败! (错误代码: %install_result%)
)

:summary
echo.
echo ========================================
echo 构建测试总结
echo ========================================

:: 检查生成的文件
cd ..

echo.
echo 检查生成的文件:

if exist "build\bin\Debug\FreeImaged.dll" (
    echo ✓ Debug DLL: build\bin\Debug\FreeImaged.dll
) else (
    echo ✗ Debug DLL 未找到
)

if exist "build\lib\Debug\FreeImaged.lib" (
    echo ✓ Debug LIB: build\lib\Debug\FreeImaged.lib
) else (
    echo ✗ Debug LIB 未找到
)

if exist "build\bin\Release\FreeImage.dll" (
    echo ✓ Release DLL: build\bin\Release\FreeImage.dll
) else (
    echo ✗ Release DLL 未找到
)

if exist "build\lib\Release\FreeImage.lib" (
    echo ✓ Release LIB: build\lib\Release\FreeImage.lib
) else (
    echo ✗ Release LIB 未找到
)

if exist "install\bin\FreeImage*.dll" (
    echo ✓ 已安装的DLL: install\bin\
) else (
    echo ✗ 安装的DLL 未找到
)

if exist "install\include\FreeImage.h" (
    echo ✓ 已安装的头文件: install\include\FreeImage.h
) else (
    echo ✗ 安装的头文件 未找到
)

echo.
echo ========================================
echo 构建结果:
if %debug_result% equ 0 echo ✓ Debug版本: 成功
if %debug_result% neq 0 echo ✗ Debug版本: 失败
if %release_result% equ 0 echo ✓ Release版本: 成功  
if %release_result% neq 0 echo ✗ Release版本: 失败

if exist install_result (
    if %install_result% equ 0 echo ✓ 安装测试: 成功
    if %install_result% neq 0 echo ✗ 安装测试: 失败
)

echo ========================================

:: 如果所有测试都成功，返回0，否则返回1
if %debug_result% equ 0 if %release_result% equ 0 (
    echo.
    echo 🎉 所有构建测试均成功完成!
    echo.
    echo 您现在可以:
    echo 1. 在build目录中找到生成的库文件
    echo 2. 在install目录中找到安装的文件
    echo 3. 使用Visual Studio打开build\FreeImage.sln进行开发
    echo.
    pause
    exit /b 0
) else (
    echo.
    echo ❌ 构建过程中遇到错误，请检查上述输出信息。
    echo.
    pause
    exit /b 1
) 