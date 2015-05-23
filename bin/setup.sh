#!/bin/bash
# For Ubuntu 14.04

# Do some prepare 
sudo cp ~/Backup/config/configs/51-android.rules /etc/udev/rules.d/
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
sudo apt-get install bison g++-multilib git gitk gperf libxml2-utils flex -y
# for linux menuconfig
sudo apt-get install libncurses5-dev fakeroot libswitch-perl -y

echo "3. Install Emacs"
sudo apt-get install emacs23 mew -y
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
sudo apt-get install vim vim-gui-common exuberant-ctags -y
if [ ! -e .vim/vimrc ]; then
    rm -rf .vim/ .vimrc
    git clone https://gouboft@github.com/gouboft/vim-config.git
    mv vim-config .vim
fi
ln -sf .vim/vimrc .vimrc

echo "5. Install Thunderbird"
sudo apt-get install thunderbird thunderbird-locale-zh-cn thunderbird-locale-zh-tw thunderbird-locale-ko thunderbird-locale-ja -y

echo "6. Install filezilla"
sudo apt-get install filezilla -y

echo "7. Install archive tools"
sudo apt-get install unar -y
sudo apt-get install convmv -y  # convert the file name coding: convmv -f UTF-8 -t GBK --notest utf8

echo "8. Install System tools"
sudo apt-get install ckermit tweak samba smbclient ssh -y

# Maximize gnome-terminal when it start up
echo "9. Set terminal"
sudo sed -i 's/^Exec=gnome-terminal/Exec=gnome-terminal --maximize/' /usr/share/applications/gnome-terminal.desktop
sudo apt-get install  nautilus-open-terminal -y

# Install my useful tools
echo "10. Install pdf tools, browser ..."
sudo apt-get install cups-pdf -y #pdf printer
sudo apt-get install mupdf apvlv -y #pdf reader like vi control
sudo apt-get install uzbl mutt -y # uzbl: Browser, mutt: Mail client
sudo apt-get install gparted -y # gparted: A disk manage software
sudo apt-get install ecryptfs-utils -y # ecryptfs

echo "11. Install Fcitx Input Method"
sudo apt-get install im-switch fcitx fcitx-config-gtk fcitx-table-all -y
im-switch -s fcitx -z default
# exchange the caps lock and control key
dconf write /org/gnome/desktop/input-sources/xkb-options "['ctrl:swapcaps']"

echo "12. Set some misc"
sudo apt-get install tree tmux -y
# Set Ubuntu support Chinese Characters
RET=$(sed -n "/GBK/p" /var/lib/locales/supported.d/local)
if [ "$RET" != "zh_CN.GBK GBK" ]; then
    sudo chmod 666 /var/lib/locales/supported.d/local
    sudo echo "zh_CN.GBK GBK" >> /var/lib/locales/supported.d/local
    sudo echo "zh_CN.GB2312 GB2312" >> /var/lib/locales/supported.d/local
    sudo chmod 644 /var/lib/locales/supported.d/local
fi
sudo dpkg-reconfigure -force locales > /dev/null
sudo apt-get install gtk2-engines-pixbuf -y # remove warning when open GTK software in shell
sudo apt-get install gconf-editor -y # used to set the app which use the gtk library, such as iptux
sudo apt-get install gstreamer1.0-libde265 -y # H265 Video play

#fix gedit unreadable code
gsettings set org.gnome.gedit.preferences.encodings auto-detected "['GB18030', 'GB2312', 'GBK', 'UTF-8', 'BIG5', 'CURRENT', 'UTF-16']"
gsettings set org.gnome.gedit.preferences.encodings shown-in-menu "['GB18030', 'GB2312', 'GBK', 'UTF-8', 'BIG5', 'CURRENT', 'UTF-16']"

echo "13. Install Beyond compare"
# replace ia32-libs
sudo apt-get install lib32z1 lib32ncurses5 lib32bz2-1.0 -y
# install old version ia32-libs
cd ~/Backup/documents
unar -q ia32-libs.tar.gz
cd ia32-libs; sudo dpkg -i *.deb; cd ..; rm -r ia32-libs
sudo dpkg -i ~/Backup/documents/bcompare*.deb

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
# google chrome request
sudo apt-get install libappindicator1 -y
sudo dpkg -i google-chrome*.deb > /dev/null
if [ -f install_flash_player* ]; then
    tar -xzvf install_flash_player*.gz > /dev/null 
    sudo cp -r usr/ /
    sudo cp libflashplayer.so /usr/lib/mozilla/plugins/
    rm -r usr libflashplayer.so
fi

# fix the unity control center disappear
#sudo apt-get install unity-control-center-signon unity-control-center-unity

# fix the usb canot use in vbox
sudo gpasswd -a link vboxusers #link is a suer account
