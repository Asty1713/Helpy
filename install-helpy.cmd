@echo off
echo Downloading Helpy installer...

powershell -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/Asty1713/Helpy/main/install-helpy.ps1' -OutFile '%TEMP%\install-helpy.ps1'"

echo Running installer...
powershell -ExecutionPolicy Bypass -File "%TEMP%\install-helpy.ps1"

pause