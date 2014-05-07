#!/bin/bash

adb shell screencap /sdcard/screenshot.png
adb pull /sdcard/screenshot.png ~/ > /dev/null
adb shell rm /sdcard/screenshot.png

eog ~/screenshot.png

rm ~/screenshot.png
