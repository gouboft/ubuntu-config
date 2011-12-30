#!/bin/bash

adb kill-server
adb connect 192.168.11.$1:5555
adb shell
adb shell mount -o remount,rw system /system
adb shell sync
echo "Done....."
