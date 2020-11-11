oppocheck=$(adb shell getprop ro.product.manufacturer)
package=platform-tools
if ! [ $(id -u) = 0 ]; then
   echo "Please run this script as root (sudo)"
   exit 1
fi
echo "Installing/updating platform-tools..."
apt install -y $package
clear
echo "Please connect your phone. Make sure USB debugging is turned on in Developer settings."
adb wait-for-device
clear
echo "Checking deive permissions..."
adb devices
echo "If you see 'no permissions', please make sure you enabled USB debugging in your device developer settings, set the usb mode to 'File Transfer', and allow the debugging in a prompt on your device, then run the script again. If you don't see such line, press enter."
read
echo "Proceeding..."
echo "Checking Device..."
if echo $oppocheck | grep -q -i "OPPO"; then
    echo "OPPO device found, please make sure you have disabled  permission monitor in developer settings, then press enter. If you don't disable it, Granter will fail."
fi
echo "Granting the shades..."
adb shell pm grant com.treydev.mns android.permission.WRITE_SECURE_SETTINGS
adb shell pm grant com.treydev.pns android.permission.WRITE_SECURE_SETTINGS
adb shell pm grant com.treydev.ons android.permission.WRITE_SECURE_SETTINGS
adb shell pm grant com.treydev.micontrolcenter android.permission.WRITE_SECURE_SETTINGS
clear
echo "All done! You can disconnect your device now."
