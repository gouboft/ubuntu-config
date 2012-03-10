echo -e '\033[0;31;1m==================== Fastboot Prepare ================\033[0m'
echo ""
test $TARGET_PRODUCT
if [ $? -eq 1 ]; then
	echo -e '\033[0;31;1mYou mast setup the environment first\033[0m'
    	. build/envsetup.sh; lunch
else
	echo -e '\033[0;32;1mYou have setup the environment\033[0m'
fi

DIR=$(echo $TARGET_PRODUCT | sed 's/crane_/crane-/g')
BOOTIMG="out/target/product/$DIR/boot.img"
SYSTEMIMG="out/target/product/$DIR/boot.img"
BOOTLOADERIMG="vendor/softwinner/tools/pack/out/bootloader.fex"
echo ""
echo -e '\033[0;34;1m======================================================\033[0m'
echo boot.img=$BOOTIMG
echo system.img=$SYSTEMIMG
echo bootloader=$BOOTLOADERIMG
echo -e '\033[0;34;1m======================================================\033[0m'

echo -e 'Are you want to flash \033[0;31;1mboot\033[0m partition? [Y/n]'
read Inputb
echo -e 'Are you want to flash \033[0;31;1mbootloader\033[0m partition? [Y/n]'
read Inputbl
echo -e 'Are you want to flash \033[0;31;1msystem\033[0m partition? [Y/n]'
read Inputs


#Are you better idea to rewite this?
if [ "$Inputb" == "n" ]; then 
	if [ "$Inputbl" == "n" ]; then 
		if [ "$Inputs" == "n" ]; then 
			TODOFLASH="no"
		else
			ISON=$(adb devices | grep 2008 | sed 's/20080411\tdevice/on/g')
			if [ "$ISON" == "on" ]; then
				adb reboot fastboot
			fi
		fi
	else
		ISON=$(adb devices | grep 2008 | sed 's/20080411\tdevice/on/g')
		if [ "$ISON" == "on" ]; then
			adb reboot fastboot
		fi
	fi
else
		ISON=$(adb devices | grep 2008 | sed 's/20080411\tdevice/on/g')
		if [ "$ISON" == "on" ]; then
			adb reboot fastboot
		fi
fi

echo -e '\033[0;31;1m==================== Fastboot Start ==================\033[0m'

if [ "$TODOFLASH" != "no" ]; then
	# Flash boot partition
	if [ "$Inputb" != "n" ]; then
		sudo fastboot erase boot > /dev/null
		sudo fastboot flash boot $BOOTIMG
		sleep 2
		echo "Boot flash success"
		echo ""
    	fi

	# Flash bootloader partition
    	if [ "$Inputbl" != "n" ]; then
		sudo fastboot erase bootloader > /dev/null
		sudo fastboot flash bootloader $BOOTLOADERIMG
		sleep 2
		echo "Bootloader flash success"
		echo ""
    	fi

	# Flash system partition
    	if [ "$Inputs" != "n" ]; then
		sudo fastboot erase system > /dev/null
		sudo fastboot flash system $SYSTEMIMG
		sleep 2
		echo "System flash success"
		echo ""
    	fi
	
	# exit fastboot mode and reboot machine
	sudo fastboot reboot
else
	echo "Nothing to be done"
fi

echo -e '\033[0;32;1m==================== Fastboot end ====================\033[0m'
