#!/bin/bash

echo "Tar system to package"

if [ -d ~/Source/amlogic/nvidia/out/target/product/b04ref/system ]; then
    cd ~/Source/amlogic/nvidia/out/target/product/b04ref/system
    tar -cvf system.zt280.tar.bz *
    mv -v system.zt280.tar.bz /media/GOUBO/zt-update
else
    echo "No system exist"
    exit
   
umount /media/GOUBO