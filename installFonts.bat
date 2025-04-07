@echo off
setlocal enabledelayedexpansion

:: Set your fonts source folder here
:: Thêm đường dân đến thư mục chứa font vào biến fontFolder
set "fontFolder=X:\Thư mục của bạn\..."

:: System fonts directory
set "fontsDir=%WINDIR%\Fonts"

:: Function to unzip .zip files
echo Unzipping .zip files...
for /r "%fontFolder%" %%F in (*.zip) do (
    echo Unzipping: %%F
    powershell.exe -noprofile -command "Expand-Archive -Path '%%F' -DestinationPath '%fontFolder%' -Force"
)

:: Function to install fonts
echo Installing .otf fonts...
for /r "%fontFolder%" %%F in (*.otf) do (
    set "fontFile=%%~nxF"
    echo Installing: !fontFile!
    copy "%%F" "%fontsDir%" >nul
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" /v "!fontFile!" /t REG_SZ /d "!fontFile!" /f >nul
)

echo Installing .ttf fonts...
for /r "%fontFolder%" %%F in (*.ttf) do (
    set "fontFile=%%~nxF"
    echo Installing: !fontFile!
    copy "%%F" "%fontsDir%" >nul
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" /v "!fontFile!" /t REG_SZ /d "!fontFile!" /f >nul
)

echo.
echo All fonts installed successfully!
pause
