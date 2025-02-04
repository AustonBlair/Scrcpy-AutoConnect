@echo off
REM Hardcode the host IP to 192.168.1.244
:Start
adb kill-server
adb start-server
set ip=192.168.1.244

ECHO Scanning for ADB port (30000-51000) on %ip%...
set "port="

REM Fast nmap scan using PowerShell with error handling
FOR /f "delims=" %%p IN ('powershell -Command "nmap -T4 -Pn -n --min-rate 5000 -p 30000-51000 %ip% | Select-String 'tcp open' | ForEach-Object { $_.Line.Split('/')[0] }" 2^>^&1') DO (
  if not defined port set "port=%%p"
)

if "%port%"=="" (
  ECHO ERROR: No open ADB port found on %ip%! 
  rem ECHO 1. Device is on and connected to Wi-Fi.
  rem ECHO 2. ADB debugging is enabled.
  rem ECHO 3. Port is in 30000-51000 range.
  Echo Rety?
  pause
  
 rem exit /b 1
)

ECHO Found port: %port%
adb connect %ip%:%port%
if %ERRORLEVEL% == 0 (
  echo Connected to %ip%:%port% successful - Saving 1port.txt - Calling scrcpy-console.bat
  echo %port% > "%UserProfile%\Desktop\scrcpy-win64-v2.4\1port.txt"
  call scrcpy-console.bat
) else (
  echo ERROR: Connection to %ip%:%port% failed!
  echo Check if ADB is running on the device.
  Echo Rety?
  pause
  
rem  exit /b 1
)