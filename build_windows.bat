@echo off
echo Starting Flutter Windows build...

REM Step 1: Clean previous build
echo Cleaning previous build...
flutter clean

REM Step 2: Get dependencies
echo Getting dependencies...
flutter pub get

REM Step 3: Generate code
echo Generating code files...
dart run build_runner build --delete-conflicting-outputs

REM Step 4: Configure CMake
echo Configuring CMake...
"D:\SoftwareData\Microsoft Visual Studio\2022\Community\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin\cmake.exe" -S windows -B build\windows\x64 -G "Visual Studio 17 2022" -A x64 -DFLUTTER_TARGET_PLATFORM=windows-x64

REM Step 5: Build using MSBuild directly (skip install target)
echo Building with MSBuild...
"D:\SoftwareData\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe" build\windows\x64\prompt_optimization.sln /p:Configuration=Debug /p:Platform=x64 /t:prompt_optimization /m /v:minimal

REM Step 6: Copy Flutter dependencies manually
echo Copying Flutter dependencies...
xcopy /Y /I "D:\ProgramData\flutter\bin\cache\artifacts\engine\windows-x64\icudtl.dat" "build\windows\x64\runner\Debug\data\"
xcopy /Y "D:\ProgramData\flutter\bin\cache\artifacts\engine\windows-x64\flutter_windows.dll" "build\windows\x64\runner\Debug\"

echo Build complete!
echo Executable location: build\windows\x64\runner\Debug\prompt_optimization.exe
pause
