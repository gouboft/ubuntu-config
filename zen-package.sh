#!/bin/bash

echo "1. Tar system image"
if [ -d ~/Source/amlogic/android_letou/out/target/product/b04ref/system ]; then
    cd ~/Source/amlogic/android_letou/out/target/product/b04ref/system
    tar -cf system.zt280.tar.bz *
else
    exit
fi

echo "2. Copy System image to SD card"
if [ -d /media/GOUBO ]; then
    mv -v system.zt280.tar.bz /media/GOUBO/zt-update
elif [ -d /media/xu ]; then
    mv -v system.zt280.tar.bz /media/xu/zt-update
elif [ -d /media/84DB-2E5B ]; then
    mv -v system.zt280.tar.bz /media/84DB-2E5B/zt-update

else
    echo "No SD card insert!"
    exit
fi

echo "3. Copy Kernel image to SD card"
if [ -d ~/Source/amlogic/android_letou/kernel/out/G0 ]; then
    cp -v ~/Source/amlogic/android_letou/kernel/out/G0/2n/ZT280.kernel /media/GOUBO/zt-update/
elif [ -d ~/Source/amlogic/android_letou/kernel/out/H1 ]; then
    cp -v ~/Source/amlogic/android_letou/kernel/out/H1/1n/ZT280.kernel /media/GOUBO/zt-update/
else
    echo "No Kernel image exist"
    exit
fi

umount /media/GOUBO