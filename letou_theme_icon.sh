#!/bin/bash

mv defthm.zip defthm0.zip
MAX=4
for ((i = 0; i<MAX; i++))
do
    echo "deal with defthm{$i}"
    mkdir defthm
    cp -v defthm${i}.zip ./defthm/
    cd defthm/
    unzip -q defthm${i}.zip

    mv -v ./icons/com.scholar.png ./icons/com.eee168.wowreader.png
#    rm ./icons/com.scholar.png
    rm ./defthm${i}.zip
    zip -r -q defthm${i}.zip ./

    cp defthm${i}.zip ../
    cd ../
    rm -r ./defthm
done
mv defthm0.zip defthm.zip
echo "All Done"