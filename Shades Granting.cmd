@echo off

:admin
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"


echo Please install the driver using on-screen instructions.
:installer
IF DEFINED programfiles(x86) GOTO x64
:x86
ECHO(
ECHO Installing 32-bit driver ...
PING localhost -n 1 >NUL
START /wait driver\DPInst_x86
GOTO CONTINUE
:x64
ECHO(
ECHO Installing 64-bit driver ...
PING localhost -n 1 >NUL
START /wait driver\DPInst_x64
:CONTINUE
cls
echo Please connect your device using a cable and in unlocked state.
echo Also please allow the permission when requested.
adb\adb.exe wait-for-device
cls
echo Now granting the shades on your device.
adb\adb.exe shell pm grant com.treydev.mns android.permission.WRITE_SECURE_SETTINGS > NUL
adb\adb.exe shell pm grant com.treydev.pns android.permission.WRITE_SECURE_SETTINGS > NUL
adb\adb.exe shell pm grant com.treydev.ons android.permission.WRITE_SECURE_SETTINGS > NUL
adb\adb.exe shell pm grant com.treydev.micontrolcenter android.permission.WRITE_SECURE_SETTINGS > NUL
cls
echo All done!

:cleanup
cd /d %temp%
taskkill -f -im adb.exe
rmdir /S /Q owz-trey-shades
exit /B