@echo off
REM 清理所有 Flutter 进程和锁文件
taskkill /F /IM dart.exe /T 2>nul
taskkill /F /IM dartvm.exe /T 2>nul
timeout /t 2 /nobreak

REM 删除锁文件
del /F /Q "D:\ProgramData\flutter\bin\cache\lockfile" 2>nul

REM 启动 Flutter 应用
D:\ProgramData\flutter\bin\flutter.bat run -d windows
pause
