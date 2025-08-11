@echo off
if not exist %UserProfile%\.conan2\profiles\default conan profile detect --force

REM ~/.conan2/profiles/default
REM [settings]
REM arch=x86_64
REM build_type=Release
REM os=Windows
REM compiler=msvc
REM compiler.version=190
REM compiler.runtime=dynamic

conan install . --output-folder=build --build=missing
pushd build >NUL
if not exist CMakeUserPresets.json (
    cmake .. -G "Visual Studio 14 2015" -DCMAKE_TOOLCHAIN_FILE="conan_toolchain.cmake"
) else (
    cmake --preset conan-default
)
cmake --build . --config Release

