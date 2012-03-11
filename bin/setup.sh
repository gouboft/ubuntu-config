#!/bin/bash

# Do some prepare 
sudo cp ~/Backup/config/configs/hosts /etc/hosts
if [ ! -f /etc/apt/sources.list.bak ]; then
    #backup the config, and do not backup it again
    sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak 
fi
sudo cp ~/Backup/config/configs/sources.list.163 /etc/apt/sources.list
sudo apt-get update > /dev/null
if [ ! -e ~/.ssh ]; then
    ln -sf ~/Backup/config/ssh ~/.ssh
else
    rm -rf ~/.ssh
    ln -sf ~/Backup/config/ssh ~/.ssh
fi


echo "1. Install JDK"
if [ ! -e /usr/lib/jvm ]; then
    echo "1.1 Install JDK 1.6"
    sudo mkdir /usr/lib/jvm
    if [ ! -e /usr/lib/jvm/jdk1.6.0.30 ]; then
	cd ~/Backup/documents
	tar -zxvf ~/Backup/documents/jdk-6u30-linux-x64.tar.gz	
	sudo mv jdk1.6.0_30 /usr/lib/jvm/
	sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk1.6.0_30/bin/java 200
	sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk1.6.0_30/bin/javac 200
    fi

    echo "1.2 Install JDK 1.7"
    if [ ! -e /usr/lib/jvm/jdk1.7.0_02 ]; then
	cd ~/Backup/documents
	tar -zxvf ~/Backup/documents/jdk-7u2-linux-x64.tar.gz
	sudo mv jdk1.7.0_02/ /usr/lib/jvm/
	sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk1.7.0_02/bin/java 100
	sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk1.7.0_02/bin/javac 100
    fi
fi


# For Android Compile
echo "2. Install android compile tools"
sudo apt-get install git git-core qgit gitk -y > /dev/null
sudo apt-get install gnupg flex bison gperf build-essential \
  zip curl zlib1g-dev libc6-dev lib32ncurses5-dev ia32-libs \
  x11proto-core-dev libx11-dev lib32readline-dev lib32z-dev \
  libgl1-mesa-dev g++-multilib mingw32 tofrodos python-markdown \
  libxml2-utils xsltproc gcc-4.5 g++-4.5 gcc-4.5-multilib g++-4.5-multilib \
  gcc-4.4 g++-4.4 gcc-4.4-multilib g++-4.4-multilib -y > /dev/null

sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.4 300
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.5 200
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.6 100
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.4 300
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.5 200
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.6 100

echo "3. Install Emacs"
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

echo "4. Install Vim"
cd ~
sudo apt-get install vim exuberant-ctags -y > /dev/null
if [ ! -e .vim/vimrc ]; then
    rm -rf .vim/ .vimrc
    git clone https://gouboft@github.com/gouboft/vim-config.git
    mv vim-config .vim
fi
ln -sf .vim/vimrc .vimrc

echo "5. Install Thunderbird"
sudo apt-get install thunderbird thunderbird-locale-zh-cn thunderbird-locale-zh-tw thunderbird-locale-ko thunderbird-locale-ja -y > /dev/null

echo "6. Install filezilla"
sudo apt-get install filezilla -y > /dev/null

echo "7. Install archive tools"
sudo apt-get install unzip zip rar unrar p7zip -y > /dev/null
sudo apt-get install convmv -y > /dev/null # convert the file name coding: convmv -f UTF-8 -t GBK --notest utf8

echo "8. Install System tools"
sudo apt-get install ckermit tweak samba smbclient smbfs ssh -y > /dev/null

# Maximize gnome-terminal when it start up
echo "9. Set terminal"
sudo sed -i 's/^Exec=gnome-terminal/Exec=gnome-terminal --maximize/' /usr/share/applications/gnome-terminal.desktop
sudo apt-get install  nautilus-open-terminal -y > /dev/null

# Install my useful tools
echo "10. Install pdf tools, browser ..."
sudo apt-get install cups-pdf -y > /dev/null #pdf printer
sudo apt-get install mupdf apvlv -y > /dev/null #pdf reader like vi control
sudo apt-get install uzbl mutt -y > /dev/null # uzbl: Browser, mutt: Mail client
# install sxiv, which is a image review tool
if [ ! -x /usr/local/bin/sxiv ]; then
    sudo apt-get install libimlib2-dev > /dev/null #the library for the sxiv 
    cd /tmp && git clone git://github.com/muennich/sxiv.git > /dev/null && cd - > /dev/null
    cd /tmp/sxiv && make && sudo make install && cd - > /dev/null
    rm -rf /tmp/sxiv
fi



echo "11. Install Fcitx Input Method"
sudo apt-get remove ibus -y > /dev/null
sudo apt-get install im-switch fcitx fcitx-config-gtk fcitx-table-all -y > /dev/null
im-switch -s fcitx -z default
if [ -d ~/.config ]; then
    cp -rf ~/Backup/config/fcitx ~/.config/
fi

echo "12. Set some misc"
sudo apt-get install tree tmux -y > /dev/null
# Set Ubuntu support Chinese Characters
RET=$(sed -n "/GBK/p" /var/lib/locales/supported.d/local)
if [ "$RET" != "zh_CN.GBK GBK" ]; then
    sudo chmod 666 /var/lib/locales/supported.d/local
    sudo echo "zh_CN.GBK GBK" >> /var/lib/locales/supported.d/local
    sudo echo "zh_CN.GB2312 GB2312" >> /var/lib/locales/supported.d/local
    sudo chmod 644 /var/lib/locales/supported.d/local
fi
sudo dpkg-reconfigure -force locales > /dev/null
sudo apt-get install gtk2-engines-pixbuf -y > /dev/null # remove warning when open GTK software in shell

echo "13. Install Beyond compare"
sudo dpkg -i ~/Backup/documents/bcompare*.deb  > /dev/null

echo "14. Copy all config file"
if [ ! -e ~/bin ]; then
    ln -sf ~/Backup/config/bin ~/bin
else
    rm -rf ~/bin
    ln -sf ~/Backup/config/bin ~/bin
fi

if [ ! -e ~/.rc ]; then
    ln -sf ~/Backup/config/rc ~/.rc
    .rc/install.sh > /dev/null
else
    rm -rf ~/.rc
    ln -sf ~/Backup/config/rc ~/.rc
fi

echo "15. Install google chrome and flash player"
cd ~/Backup/documents/
sudo apt-get install libnss3-1d -y >/dev/null
sudo dpkg -i google-chrome*.deb > /dev/null
if [ -f install_flash_player* ]; then
    tar -xzvf install_flash_player*.gz > /dev/null 
    sudo cp -r usr/ /
    sudo cp libflashplayer.so /usr/lib/mozilla/plugins/
    rm -r usr libflashplayer.so
fi
