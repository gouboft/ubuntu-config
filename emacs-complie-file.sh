#!/bin/bash

# This script is for compile .el file to .elc.
# Usage:
#       emacs-complie-file xxx.el
if [ -f $1 ]; then
    emacs -batch -f batch-byte-compile $1 > /dev/null
else
    echo "$1 was not a file!"
    exit
fi
