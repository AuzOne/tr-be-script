#!/bin/bash

export JOBS=`nproc`;

if [[ ${1} = "--auto" ]]; then
  export PARAM=-y
  export SKIP=1
else
  export PARAM=""
  export SKIP=0
fi

clear

echo
echo " > [T E A M   R A D I U M] <"
echo
echo " Build Environment Setup Script"
echo
echo " Script for automatically obtaining all required dependencies "
echo " for all kinds of Android Developing (kernel compilation/mutation,"
echo " rom compilation/mutation, reverse engineering and theming)"
echo 
echo " The argument '--auto' can be used for assuming yes on most queries" 
echo
echo " Visit us at:"
echo " - https://github.com/TeamRadium"
echo


if [ ${SKIP} = 1 ]; then
  echo "Unattended installation. skipping pause..."
else
  read -p "Press [Enter] key to continue..."
fi

clear

echo
echo "Entering SCRIPT FILE'S DOWNLOAD Directory"
echo
if [ ! -d ~/tr-be-script ]; then
  mkdir -p ~/tr-be-script
fi
cd ~/tr-be-script

if [ ${SKIP} = 1 ]; then
  echo "Unattended installation. skipping pause..."
else
  read -p "Press [Enter] key to continue..."
fi

clear

echo
echo "Installing Python!"
echo
sudo apt-get install build-essential gcc $PARAM
wget http://www.python.org/ftp/python/3.5.0/Python-3.5.0a4.tgz 
tar -xvzf Python-3.5.0a4.tgz 
cd ~/tr-be-script/Python-3.5.0
./configure --prefix=/usr/local/python3.3
make -j${JOBS}
sudo make install -j${JOBS}
sudo ln -s /usr/local/python3.3/bin/python /usr/bin/python3.5
cd ~/tr-be-script

if [ ${SKIP} = 1 ]; then
  echo "Unattended installation. skipping pause..."
else
  read -p "Press [Enter] key to continue..."
fi

clear

echo
echo "Installing CCache!"
echo
wget http://www.samba.org/ftp/ccache/ccache-3.2.tar.gz
tar -xvzf ccache-3.2.tar.gz
cd ~/tr-be-script/ccache-3.2
./configure
make -j${JOBS}
sudo make install -j${JOBS}
echo "export USE_CCACHE=1" >> ~/.bashrc
ccache -M 25G
cd ~/tr-be-script

if [ ${SKIP} = 1 ]; then
  echo "Unattended installation. skipping pause..."
else
  read -p "Press [Enter] key to continue..."
fi

clear

if [ ${SKIP} = 1 ]; then
  echo "Unattended installation. skipping pause..."
else
  read -p "Press [Enter] key to continue..."
fi

clear

echo
echo "Installing GNU Make!"
echo
cd ~/tr-be-script
wget http://ftp.gnu.org/gnu/make/make-4.1.tar.gz
tar -xvzf make-4.1.tar.gz
cd ~/tr-be-script/make-4.1
./configure
sudo make install -j${JOBS}
cd ~/

if [ ${SKIP} = 1 ]; then
  echo "Unattended installation. skipping pause..."
else
  read -p "Press [Enter] key to continue..."
fi

clear

echo
echo "Installing Required Packages!"
echo
sudo apt-get update
sudo apt-get install git gnupg flex bison gperf build-essential \
zip curl libc6-dev libncurses5-dev:i386 x11proto-core-dev \
libx11-dev:i386 libreadline6-dev:i386 libgl1-mesa-glx:i386 \
libgl1-mesa-dev g++-multilib mingw32 tofrodos \
python-markdown libxml2-utils xsltproc zlib1g-dev:i386 \
android-tools-adb android-tools-fastboot libcloog-isl-dev \
texinfo gcc-multilib schedtool libxml2-utils libxml2 $PARAM

sudo ln -s /usr/lib/i386-linux-gnu/mesa/libGL.so.1 /usr/lib/i386-linux-gnu/libGL.so

if [ ${SKIP} = 1 ]; then
  echo "Unattended installation. skipping pause..."
else
  read -p "Press [Enter] key to continue..."
fi

clear

echo
echo "Add  terminal to The mouse right button shortcut!"
echo
sudo apt-get install nautilus-open-terminal $PARAM
nautilus -q

echo
echo "Installing GIT!"
echo
sudo apt-get install git $PARAM

echo
echo "Installing Repo"
echo
if [ ! -d ~/bin ]; then
  mkdir -p ~/bin
fi
curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo

echo
echo "Installing ADB Drivers!"
echo
wget http://www.broodplank.net/51-android.rules
sudo mv -f 51-android.rules /etc/udev/rules.d/51-android.rules
sudo chmod 644 /etc/udev/rules.d/51-android.rules

if [ ${SKIP} = 1 ]; then
  echo "Unattended installation. skipping pause..."
else
  read -p "Press [Enter] key to continue..."
fi

clear

echo
echo "Downloading and Configuring Android SDK!!"
echo "Making sure unzip is installed"
echo
sudo apt-get install unzip $PARAM

if [ `getconf LONG_BIT` = "64" ]
then
        echo
        echo "Downloading SDK for 64bit Linux System"
        wget http://dl.google.com/android/android-sdk_r24.1.2-linux.tgz
        echo "Download Complete!!"
        echo "Extracting"
        mkdir ~/adt-bundle
        mv android-sdk_r24.1.2-linux.tgz~/adt-bundle/adt_x64.tgz
        cd ~/adt-bundle
        tar -xvzf adt_x64.tgz
        mv -f android-sdk_r24.1.2-linux/* .
        echo "Configuring environment"
        echo -e '\n# Android tools\nexport PATH=${PATH}:~/adt-bundle/sdk/tools\nexport PATH=${PATH}:~/adt-bundle/sdk/platform-tools\nexport PATH=${PATH}:~/bin' >> ~/.bashrc
        echo -e '\nPATH="$HOME/adt-bundle/sdk/tools:$HOME/adt-bundle/sdk/platform-tools:$PATH"' >> ~/.profile
        echo "Placing desktop shortcuts"
        ln -s ~/adt-bundle/eclipse/eclipse ~/Desktop/Eclipse
        ln -s ~/adt-bundle/sdk/tools/android ~/Desktop/SDK-Manager
        echo "Done!!"
fi

if [ ${SKIP} = 1 ]; then
  echo "Unattended installation. skipping pause..."
else
  read -p "Press [Enter] key to continue..."
fi

clear

echo
echo "Installing DSIXDA's Android Kitchen"
echo
cd ~/tr-be-script
wget https://github.com/dsixda/Android-Kitchen/archive/master.zip
unzip master.zip
mv -f Android-Kitchen-master ~/Android-Kitchen
echo -e '\n#!/bin/bash\ncd ~/Android-Kitchen\n./menu' >> ~/Android-Kitchen/kitchen
chmod 755 ~/Android-Kitchen/kitchen
ln -s ~/Android-Kitchen/kitchen ~/bin/kitchen
ln -s ~/Android-Kitchen/kitchen ~/Desktop/Android-Kitchen

if [ ${SKIP} = 1 ]; then
  echo "Unattended installation. skipping pause..."
else
  read -p "Press [Enter] key to continue..."
fi

clear

echo
echo "Done!"
echo
echo "Cheers!"
echo
echo "Thanks for using this script!"
echo "Now, Enjoy compiling roms/kernels :)"
echo
echo "Credits:"
echo 
echo "Script created by:"
echo "> [azuone] <"
echo 
read -p "Press [Enter] key to exit..."
exit
