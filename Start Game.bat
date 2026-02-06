@echo off
cd /d "%~dp0"
set URL=http://localhost:8080/game.html

:: Free port 8080 if something is already using it
for /f "tokens=5" %%a in ('netstat -ano ^| findstr :8080 ^| findstr LISTENING') do (
  taskkill /F /PID %%a >nul 2>&1
  timeout /t 1 /nobreak >nul
)

:: Start server in a new window so it keeps running
start "Game Server" cmd /k node server.js

:: Wait for server to be ready, then open browser
timeout /t 2 /nobreak >nul
start "" "%URL%"

echo.
echo Server is running in the other window.
echo Close that window to stop the server.
echo.
pause
