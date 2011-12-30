#!/bin/bash
# Why use this: 用unzip解压的gbk编码的文件名会出现乱码,在用unzip解压文件后再用这个命令就可以正常显示文件名.
# Usage: convmv-gbk-2-uft8.sh GBK编码的文件名
convmv -f GBK -t UTF-8 --notest $1