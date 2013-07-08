#!/bin/bash

# 转换文本文件字符编码：GB18030 转到 UTF-8
#Usage: iconv 文件名.txt
iconv -f GB18030 -t UTF-8 $1 > $1_
rm $1
mv $1_ $1
