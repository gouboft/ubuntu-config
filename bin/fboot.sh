echo -e '\033[0;31;1m==================== Fastboot Prepare ================\033[0m'
echo ""
test $TARGET_PRODUCT
if [ $? -eq 1 ]; then
	echo -e '\033[0;31;1mYou mast setup the environment first\033[0m'
    	. build/envsetup.sh; lunch
else
	echo -e '\033[0;32;1mYou have setup the environment\033[0m'
fi

PASSWD=jkl
DIR=$(echo $TARGET_PRODUCT | sed 's/crane_/crane-/g')
BOOTIMG="out/target/product/$DIR/boot.img"
SYSTEMIMG="out/target/product/$DIR/system.img"
USERDATAIMG="out/target/product/$DIR/userdata.img"
BOOTLOADERIMG="vendor/softwinner/tools/pack/out/bootloader.fex"
echo ""
echo -e '\033[0;34;1m======================================================\033[0m'
echo boot.img=$BOOTIMG
echo system.img=$SYSTEMIMG
echo userdata.img=$USERDATAIMG
echo bootloader=$BOOTLOADERIMG
echo -e '\033[0;34;1m======================================================\033[0m'

echo -e 'Are you want to flash \033[0;31;1mboot\033[0m partition? [Y/n]'
read Inputb
echo -e 'Are you want to flash \033[0;31;1mbootloader\033[0m partition? [Y/n]'
read Inputbl
echo -e 'Are you want to flash \033[0;31;1muserdata\033[0m partition? [Y/n]'
read Inputud
echo -e 'Are you want to flash \033[0;31;1msystem\033[0m partition? [Y/n]'
read Inputs


if [ "$Inputb" == "n" -a "$Inputbl" == "n" -a "$Inputud" == "n" -a "$Inputs" == "n" ]; then 
	TODOFLASH="no"
else
	ISON=$(adb devices | grep 2008 | sed 's/20080411413fc082\tdevice/on/g')
	if [ "$ISON" == "on" ]; then
		adb reboot fastboot
	else
		echo "No device found"
	fi
fi


echo -e '\033[0;31;1m==================== Fastboot Start ==================\033[0m'

if [ "$TODOFLASH" != "no" ]; then
	# Flash boot partition
	if [ "$Inputb" != "n" ]; then
		echo $PASSWD | sudo fastboot flash boot $BOOTIMG
		sleep 2
		echo "Boot flash success"
		echo ""
    	fi

	# Flash bootloader partition
    	if [ "$Inputbl" != "n" ]; then
		echo $PASSWD | sudo fastboot flash bootloader $BOOTLOADERIMG
		sleep 2
		echo "Bootloader flash success"
		echo ""
    	fi

	# Flash userdata partition
    	if [ "$Inputud" != "n" ]; then
		echo $PASSWD | sudo fastboot flash data $USERDATAIMG
		sleep 2
		echo "Userdata flash success"
		echo ""
    	fi

	# Flash system partition
    	if [ "$Inputs" != "n" ]; then
		echo $PASSWD | sudo fastboot flash system $SYSTEMIMG
		sleep 2
		echo "System flash success"
		echo ""
    	fi
	
	# exit fastboot mode and reboot machine
	echo $PASSWD | sudo fastboot reboot
else
	echo "Nothing to be done"
fi

echo -e '\033[0;32;1m==================== Fastboot end ====================\033[0m'
