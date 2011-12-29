#!/bin/bash

adb kill-server
adb connect 192.168.11.$1:5555
adb shell
adb shell mount -o remount,rw system /system
adb shell mkdir /media/U
adb shell mount -t vfat /dev/block/mmcblk1p5 /media/U
#adb push /home/link/Source/jupiter/android/kernel_zenith/zImage /media/U/
#adb push /home/link/Source/jupiter/android/kernel_zenith/modules/rtl8192cu/8192cu.ko /system/lib/modules/
#adb push /home/link/Downloads/sohu_video.apk /system/app/sohu_video.apk
adb push /home/link/Desktop/DroidSans-Bold.ttf /system/fonts/DroidSans-Bold.ttf
adb push /home/link/Desktop/DroidSans.ttf /system/fonts/DroidSans.ttf
adb push /home/link/Desktop/DroidSansFallback.ttf /system/fonts/DroidSansFallback.ttf
#adb push /home/link/Source/jupiter/android/out/target/product/jupiter/system/framework/ext.jar /system/framework/ext.jar
#adb push /home/link/Source/jupiter/android/out/target/product/jupiter/system/framework/framework.jar /system/framework/framework.jar
#adb push /home/link/Source/jupiter/android/out/target/product/jupiter/system/bin/wpa_cli /system/bin/wpa_cli
#adb push /home/link/Source/jupiter/android/out/target/product/jupiter/system/bin/wpa_supplicant /system/bin/wpa_supplicant
#adb push /home/link/Source/jupiter/android/out/target/product/jupiter/system/lib/libwpa_client.so /system/lib/libwpa_client.so
adb shell sync
echo "Done....."
