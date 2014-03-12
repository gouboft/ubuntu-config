check_environment()
{
    echo -e '\033[0;31;1m==================== Fastboot Prepare ================\033[0m'
    echo ""
    test $TARGET_PRODUCT
    if [ $? -eq 1 ]; then
	echo -e '\033[0;31;1mYou mast setup the environment first\033[0m'
	. build/envsetup.sh; lunch
    else
	echo -e '\033[0;32;1mYou have setup the environment\033[0m'
	echo ""
    fi
}

check_cpu_type()
{
    BOOTLOADER_PART_NAME="bootloader"
    FASTBOOT_NAME="fastboot"
    CPUTYPE=$(echo $TARGET_PRODUCT | awk -F "_" '{print $1}')
    
# A10
    if [ "$CPUTYPE" == "crane" ]; then
	DIR=$(echo $TARGET_PRODUCT | sed 's/crane_/crane-/g')
	echo "Your CPU is A10"
# A20
    elif [ "$CPUTYPE" == "wing" ]; then
	DIR=$(echo $TARGET_PRODUCT | sed 's/wing_/wing-/g')
	echo "Your CPU is A20"
# A23
    elif [ "$CPUTYPE" == "polaris" ]; then
	DIR=$(echo $TARGET_PRODUCT | sed 's/polaris_/polaris-/g')
	BOOTLOADER_PART_NAME="boot-resource"
	FASTBOOT_NAME="bootloader"
	echo "Your CPU is A23"
    fi
}

check_environment
check_cpu_type

#sudo password
PASSWD=jkl
BOOTIMG="out/target/product/$DIR/boot.img"
SYSTEMIMG="out/target/product/$DIR/system.img"
RECOVERYIMG="out/target/product/$DIR/recovery.img"
BOOTLOADERIMG="vendor/softwinner/tools/pack/out/bootloader.fex"
echo ""
echo -e '\033[0;34;1m======================================================\033[0m'
echo boot.img=$BOOTIMG
echo system.img=$SYSTEMIMG
echo recovery.img=$RECOVERYIMG
echo bootloader=$BOOTLOADERIMG
echo -e '\033[0;34;1m======================================================\033[0m'

echo -e 'Are you want to flash \033[0;31;1mboot\033[0m partition? [Y/n]'
read Inputb
echo -e 'Are you want to flash \033[0;31;1mbootloader\033[0m partition? [Y/n]'
read Inputbl
echo -e 'Are you want to flash \033[0;31;1mrecovery\033[0m partition? [Y/n]'
read Inputud
echo -e 'Are you want to flash \033[0;31;1msystem\033[0m partition? [Y/n]'
read Inputs


if [ "$Inputb" == "n" -a "$Inputbl" == "n" -a "$Inputud" == "n" -a "$Inputs" == "n" ]; then 
	TODOFLASH="no"
else
	ISON=$(adb devices | grep 0 | sed 's/\b\w*\b\tdevice/on/g')
	if [ "$ISON" == "on" ]; then
		adb shell reboot $FASTBOOT_NAME
	else
		echo "No device found"
	fi
fi


echo -e '\033[0;31;1m==================== Fastboot Start ==================\033[0m'

if [ "$TODOFLASH" != "no" ]; then
	# Flash boot partition
	if [ "$Inputb" != "n" ]; then
		echo $PASSWD | sudo -S fastboot flash boot $BOOTIMG
		sleep 2
		echo "Boot flash success"
		echo ""
    	fi

	# Flash bootloader partition
    	if [ "$Inputbl" != "n" ]; then
		echo $PASSWD | sudo -S fastboot flash $BOOTLOADER_PART_NAME $BOOTLOADERIMG
		sleep 2
		echo "Bootloader flash success"
		echo ""
    	fi

	# Flash recovery partition
    	if [ "$Inputud" != "n" ]; then
		echo $PASSWD | sudo -S fastboot flash recovery $RECOVERYIMG
		sleep 2
		echo "Recovery flash success"
		echo ""
    	fi

	# Flash system partition
    	if [ "$Inputs" != "n" ]; then
		echo $PASSWD | sudo -S fastboot flash system $SYSTEMIMG
		sleep 2
		echo "System flash success"
		echo ""
    	fi
	
	# exit fastboot mode and reboot machine
	echo $PASSWD | sudo -S fastboot reboot
else
	echo "Nothing to be done"
fi

echo -e '\033[0;32;1m==================== Fastboot end ====================\033[0m'
