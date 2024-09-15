@echo off
setlocal

:: Create a temporary file to hold the text
set "tempFile=%temp%\temp.txt"

:: Write the text to the temporary file
echo This is a sample text. > "%tempFile%"

:: Open the temporary file in Notepad
notepad "%tempFile%"

:: Clean up temporary file
del "%tempFile%"

endlocal
