#/bin/bash

sudo cp ~/Backup/config/configs/hosts /etc/hosts
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak #backup the config
sudo cp ~/Backup/config/configs/sources.list /etc/apt/sources.list

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
sudo apt-get install git gitg -y > /dev/null
sudo apt-get install git-core gnupg flex bison gperf build-essential \
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
sudo apt-get install convmv -y > /dev/null

echo "8. Install System tools"
sudo apt-get install ckermit tweak samba smbclient smbfs ssh -y > /dev/null

# Maximize gnome-terminal when it start up
echo "9. Set terminal"
sudo sed -i 's/^Exec=gnome-terminal/Exec=gnome-terminal --maximize/' /usr/share/applications/gnome-terminal.desktop
sudo apt-get install  nautilus-open-terminal -y > /dev/null

# Install PDF Printer
echo "10. Install pdf printer"
sudo apt-get install cups-pdf -y > /dev/null


echo "11. Install Fcitx Input Method"
sudo apt-get remove ibus -y > /dev/null
sudo apt-get install im-switch fcitx fcitx-config-gtk fcitx-table-all -y > /dev/null
im-switch -s fcitx -z default

echo "12. Set some misc"
sudo apt-get install tree tmux -y > /dev/null
# Set Ubuntu support Chinese Characters
sudo chmod 666 /var/lib/locales/supported.d/local
sudo echo "zh_CN.GBK GBK" >> /var/lib/locales/supported.d/local
sudo echo "zh_CN.GB2312 GB2312" >> /var/lib/locales/supported.d/local
sudo chmod 644 /var/lib/locales/supported.d/local
sudo dpkg-reconfigure --force locales > /dev/null

echo "13. Install Beyond compare"
sudo dpkg -i ~/Backup/documents/bcompare-*.deb  > /dev/null

echo "14. Copy all config file"
if [ ! -e ~/bin ]; then
    cp -rf ~/Backup/config/bin ~
fi
if [ ! -e ~/.rc ]; then
    mkdir ~/.rc
    cp -rf ~/Backup/config/rc/* ~/.rc
    .rc/install.sh > /dev/null
fi
if [ ! -e ~/.ssh ]; then
    mkdir ~/.ssh
    cp -rf ~/Backup/config/ssh/* ~/.ssh
fi
if [ -e ~/.config/fcitx ]; then
    cp -rf ~/Backup/config/fcitx/ ~/.config/
fi  

echo "15. Install google chrome and flash player"
cd ~/Backup/documents/
sudo apt-get install libnss3-1d -y >/dev/null
sudo dpkg -i google-chrome-stable_current_amd64.deb > /dev/null
tar -xzvf install_flash_player*.gz > /dev/null 
sudo cp -r usr/ /
sudo cp libflashplayer.so /usr/lib/mozilla/plugins/
rm -r usr libflashplayer.so
