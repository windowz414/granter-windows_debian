echo "Pre-script: Getting dependencies... Make sure you have Internet connection."
sudo apt-get update > /dev/null
sudo apt-get install wget unzip -y > /dev/null
echo "Getting latest platform-tools and extracting..."
cd /tmp
wget https://dl.google.com/android/repository/platform-tools-latest-linux.zip > /dev/null
unzip platform-tools-latest-linux.zip > /dev/null
cd platform-tools-latest-linux
chmod 777 adb
clear
echo "Please connect your phone. Make sure USB debugging is turned on in Developer settings."
./adb wait-for-device
clear
echo "Checking device permissions..."
./adb devices
echo "If you see 'no permissions', please make sure you enabled USB debugging in your device developer settings, set the usb mode to 'File Transfer', and allow the debugging in a prompt on your device, then run the script again. If you don't see such line, press enter."
read
echo "Proceeding..."
echo "Checking Device..."
oppocheck=$(./adb shell getprop ro.product.manufacturer)
if echo $oppocheck | grep -q -i "OPPO"; then
    echo "OPPO device found, please make sure you have disabled  permission monitor in developer settings, then press enter. If you don't disable it, Granter will fail."
    read
fi
echo "Granting the shades..."
./adb shell pm grant com.treydev.mns android.permission.WRITE_SECURE_SETTINGS > /dev/null
./adb shell pm grant com.treydev.pns android.permission.WRITE_SECURE_SETTINGS > /dev/null
./adb shell pm grant com.treydev.ons android.permission.WRITE_SECURE_SETTINGS > /dev/null
./adb shell pm grant com.treydev.micontrolcenter android.permission.WRITE_SECURE_SETTINGS > /dev/null
clear
echo "All done! You can disconnect your device now. Press enter to exit."
read
clear
echo "Cleaning up..."
cd ..
rm -rf platform-tools-latest-linux*