#!/bin/bash

i=1

while true; do
	ISON=$(adb devices | grep 2008 | sed 's/20080411413fc082\tdevice/on/g')
	if [ "$ISON" != "on" ]; then
		ISON=$(adb devices | grep 2008 | sed 's/20080411413fc082\tdevice/on/g')
		sleep 1
	fi
	
	if [ "$ISON" == "on" ]; then
		adb reboot
		echo "`date +%Y-%m-%d_%H:%M:%S`    $i"
		i=$[$i+1]
		sleep 50
		adb shell dmesg >> ~/log/kernel_log
	fi

done
