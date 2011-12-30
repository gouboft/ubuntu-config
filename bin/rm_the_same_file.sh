#!/bin/bash

# 递归删除同名文件或文件夹，使用时要小心
# $1 is the "name" of the file you want to delete
# $2 is the "type" of the file you want to delete

find . -name "$1" -type $2 -exec rm -rf '{}' \;
