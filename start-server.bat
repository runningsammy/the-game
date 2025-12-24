@echo off
cd /d "%~dp0"
echo Starting server on http://localhost:8080
python -m http.server 8080


