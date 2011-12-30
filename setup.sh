#!/bin/bash


if [ ! -e /usr/lib/jvm ]; then
    echo "1. Install JDK 1.6"
    sudo mkdir /usr/lib/jvm
    if [ ! -e /usr/lib/jvm/jdk1.6.0.30 ]; then
	cd ~/Backup
	tar -zxvf ~/Backup/jdk-6u30-linux-x64.tar.gz	
	sudo mkdir /usr/lib/jvm
	sudo mv jdk1.6.0_30 /usr/lib/jvm/
	sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk1.6.0_30/bin/java 200
	sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk1.6.0_30/bin/javac 200
    fi


    echo "2. Install JDK 1.7"
    if [ ! -e /usr/lib/jvm/jdk1.7.0_02 ]; then
	cd ~/Backup
	tar -zxvf ~/Backup/jdk-7u2-linux-x64.tar.gz
	sudo mkdir /usr/lib/jvm
	sudo mv jdk1.7.0_02/ /usr/lib/jvm/
	sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk1.7.0_02/bin/java 100
	sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk1.7.0_02/bin/javac 100
    fi
fi


# For Android Compile
echo "3. Install android compile tools"
sudo apt-get install gitk git-core gnupg flex bison gperf build-essential \
  zip curl zlib1g-dev libc6-dev lib32ncurses5-dev ia32-libs \
  x11proto-core-dev libx11-dev lib32readline5-dev lib32z-dev \
  libgl1-mesa-dev g++-multilib mingw32 tofrodos python-markdown \
  libxml2-utils xsltproc -y > /dev/null

echo "4. Install Emacs"
sudo apt-get install emacs mew -y > /dev/null
if [ ! -e ~/.emacs.d ]; then
    mkdir ~/.emacs.d
fi
if [ ! -e ~/.emacs.d/emacs-config ]; then
    cd ~/.emacs.d
    git clone https://gouboft@github.com/gouboft/emacs-config.git
    cd emacs-config
    ./install.sh
fi

echo "5. Install Vim"
cd ~
sudo apt-get install vim exuberant-ctags -y > /dev/null
if [ ! -e .vim/vimrc ]; then
   # rm -rf .vim/ .vimrc
    git clone https://gouboft@github.com/gouboft/vim-config.git
    mv vim-config .vim
fi
ln -s .vim/vimrc .vimrc

echo "6. Install Thunderbird"
sudo apt-get install thunderbird thunderbird-locale-zh-cn thunderbird-locale-zh-tw thunderbird-locale-ko thunderbird-locale-ja -y > /dev/null

echo "7. Install filezilla"
sudo apt-get install filezilla -y > /dev/null

echo "8. Instal archive tools"
sudo apt-get install unzip zip rar unrar p7zip -y > /dev/null
sudo apt-get install convmv -y > /dev/null

echo "9. Install System tools"
sudo apt-get install tweak samba smbclient smbfs ssh -y > /dev/null

# Maximize gnome-terminal when it start up
echo "10. Set terminal"
sudo sed -i 's/^Exec=gnome-terminal/Exec=gnome-terminal --maximize/' /usr/share/applications/gnome-terminal.desktop
sudo apt-get install  nautilus-open-terminal -y > /dev/null

# Install PDF Printer
echo "11. Install pdf printer"
sudo apt-get install cups-pdf -y > /dev/null


echo "12. Install Fcitx Input Method"
sudo apt-get remove ibus -y > /dev/null
sudo apt-get install im-switch fcitx fcitx-config-gtk fcitx-table-all -y > /dev/null
im-switch -s fcitx -z default

echo "13. Set some misc"
sudo apt-get install tree -y > /dev/null
# Set Ubuntu support Chinese Characters
sudo echo "
zh_CN.GBK GBK
zh_CN.GB2312 GB2312
" >> /var/lib/locales/supported.d/local
sudo dpkg-reconfigure –force locales

echo "14. Install Beyond compare"
sudo dpkg -i ~/Backup/bcompare-3.3.3.14128_amd64.deb -y > /dev/null

echo "15. Copy all tools to ~/bin "
mkdir ~/bin
cp -rf bin/* ~/bin