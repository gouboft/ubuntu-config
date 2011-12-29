#!/bin/bash

# When you use this shell, you must install this program:
#sudo apt-get install python-mutagen

# Convert all of the mp3's id3 in this folder: GBK to Unicode
find . -iname "*.mp3" -execdir mid3iconv -e gbk {} \;

# Convert one by one:
# mid3iconv -e gbk *.mp3