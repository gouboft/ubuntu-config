#!/bin/bash


# What you want to install

echo "1.For Internet"
sudo apt-get install -y filezilla > /dev/null

echo "2.For Emacs"
sudo apt-get install -y emacs w3m mew cscope > /dev/null

echo "3.For Archive"
sudo apt-get install -y unzip zip rar unrar p7zip > /dev/null
sudo apt-get install -y convmv > /dev/null

# For Android Compile
echo "4.For android compile."
sudo apt-get install -y git-core gnupg flex bison gperf build-essential \
  zip curl zlib1g-dev libc6-dev libncurses5-dev ia32-libs-multiarch \
  x11proto-core-dev libx11-dev libreadline6-dev zlib1g-dev\
  libgl1-mesa-dev g++-multilib mingw32 tofrodos python-markdown \
  libxml2-utils > /dev/null

echo "5.For System tools"
sudo apt-get install -y tweak samba smbclient smbfs ssh > /dev/null

# Maximize gnome-terminal when it start up
sudo sed -i 's/^Exec=gnome-terminal/Exec=gnome-terminal --maximize/' /usr/share/applications/gnome-terminal.desktop

# Install PDF Printer
sudo apt-get install cups-pdf > /dev/null

