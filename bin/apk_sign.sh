#!/bin/bash

# Usage: apk_sign.sh $1 $2
# generate the key, this will ask you to input the key for two times
if [ ! -f my.keystore ]; then
    keytool -genkey -alias my.keystore -keyalg RSA -validity 20000 -keystore my.keystore
fi

# pack the key had generated and the unsigned apk
# $1 : the unsigned apk
Signed=$1_signed.apk
jarsigner -verbose -keystore my.keystore -signedjar $Signed $1 my.keystore

echo Done
