@echo off
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