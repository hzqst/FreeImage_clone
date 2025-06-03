@echo off
echo ========================================
echo 测试FreeImage Debug/Release构建
echo ========================================

:: 清理之前的构建
if exist build rmdir /s /q build
mkdir build
cd build

echo.
echo [1/4] 配置CMake项目...
cmake .. -G "Visual Studio 17 2022" -A x64
if %errorlevel% neq 0 (
    echo 错误: CMake配置失败
    pause
    exit /b 1
)

echo.
echo [2/4] 构建Debug版本...
cmake --build . --config Debug
if %errorlevel% neq 0 (
    echo 错误: Debug构建失败
    pause
    exit /b 1
)

echo.
echo [3/4] 构建Release版本...
cmake --build . --config Release
if %errorlevel% neq 0 (
    echo 错误: Release构建失败
    pause
    exit /b 1
)

echo.
echo [4/4] 检查生成的库文件...
echo.
echo === Debug库文件 ===
if exist lib\FreeImaged.lib (
    echo ✓ 找到 lib\FreeImaged.lib
    dir lib\FreeImaged.lib
) else (
    echo ✗ 未找到 lib\FreeImaged.lib
)

if exist lib\FreeImaged.dll (
    echo ✓ 找到 lib\FreeImaged.dll
    dir lib\FreeImaged.dll
) else (
    echo ✗ 未找到 lib\FreeImaged.dll
)

if exist bin\FreeImaged.dll (
    echo ✓ 找到 bin\FreeImaged.dll
    dir bin\FreeImaged.dll
) else (
    echo ✗ 未找到 bin\FreeImaged.dll
)

echo.
echo === Release库文件 ===
if exist lib\FreeImage.lib (
    echo ✓ 找到 lib\FreeImage.lib
    dir lib\FreeImage.lib
) else (
    echo ✗ 未找到 lib\FreeImage.lib
)

if exist lib\FreeImage.dll (
    echo ✓ 找到 lib\FreeImage.dll
    dir lib\FreeImage.dll
) else (
    echo ✗ 未找到 lib\FreeImage.dll
)

if exist bin\FreeImage.dll (
    echo ✓ 找到 bin\FreeImage.dll
    dir bin\FreeImage.dll
) else (
    echo ✗ 未找到 bin\FreeImage.dll
)

echo.
echo === 所有lib目录文件 ===
dir lib\*.lib
echo.
echo === 所有bin目录文件 ===
dir bin\*.dll

echo.
echo [5/5] 测试安装...
echo.
echo === 安装Debug版本 ===
cmake --install . --config Debug --prefix install_debug
if %errorlevel% neq 0 (
    echo 警告: Debug安装失败
) else (
    echo ✓ Debug安装成功
    if exist install_debug\lib\FreeImaged.lib (
        echo ✓ 安装的Debug库文件: install_debug\lib\FreeImaged.lib
    ) else (
        echo ✗ 未找到安装的Debug库文件
    )
)

echo.
echo === 安装Release版本 ===
cmake --install . --config Release --prefix install_release
if %errorlevel% neq 0 (
    echo 警告: Release安装失败
) else (
    echo ✓ Release安装成功
    if exist install_release\lib\FreeImage.lib (
        echo ✓ 安装的Release库文件: install_release\lib\FreeImage.lib
    ) else (
        echo ✗ 未找到安装的Release库文件
    )
)

echo.
echo ========================================
echo 构建测试完成！
echo ========================================
cd ..
pause 