#!/bin/bash

# Set environment
export PATH=$HOME/bin:$PATH
export JAVA_HOME=/usr/lib/jvm/jdk1.6.0_30
export JRE_HOME=/usr/lib/jvm/jdk1.6.0_30
export CLASSPATH=.:$CLASSPATH:$JAVA_HOME/lib:$JRE_HOME/lib
export PATH=$JAVA_HOME/bin:$JRE_HOME/bin:$PATH

# Set the auto make path
DATE=`date +%Y%m%d`
AUTO_MAKE_DIR=$HOME/Source/allwinner/automake
VER=user

if [ -d $AUTO_MAKE_DIR ]; then
	rm -rf $AUTO_MAKE_DIR
	mkdir $AUTO_MAKE_DIR
else
	mkdir -p $AUTO_MAKE_DIR
fi

cd $AUTO_MAKE_DIR

# Sync the code
repo init -u ssh://tulip/home/git/android/platform/manifests.git -m ics-cwhl.xml
repo sync

# Start compile
cd .repo/..  && . build/envsetup.sh && lunch 14 && make -j4
pack

if [ -f vendor/softwinner/tools/pack/sun4i_crane_jbs7.img ]; then 
	cp -f vendor/softwinner/tools/pack/sun4i_crane_jbs7.img ~/CWHL-$DATE-$VER.img
fi

#Copy to Server
scp $HOME/CWHL-$DATE-$VER.img jbs@tulip:/home/jbs/share/Release

