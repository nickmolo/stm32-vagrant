#!/usr/bin/env bash

mkdir downloads
mkdir /vagrant/utils
ln -s /vagrant/utils ./utils

#### General development tools ####
apt-get update
apt-get install -y build-essential autotools-dev autoconf pkg-config cmake make git vim 
apt-get install -y libusb-1.0-0 libusb-1.0-0-dev libftdi1 libftdi-dev dfu-util
apt-get install -y cpputest python3 python-pip python-setuptools 
apt-get install -y usbutils

#### ST Link ####
cd downloads
git clone https://github.com/texane/stlink.git
cd stlink
./autogen.sh
./configure
./make
sudo make install
sudo cp 49-stlink*.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules
sudo udevadm trigger

#### Linaro arm-none-eabi-gcc ####
wget -q -P downloads https://launchpad.net/gcc-arm-embedded/4.9/4.9-2015-q3-update/+download/gcc-arm-none-eabi-4_9-2015q3-20150921-linux.tar.bz2
tar -xvf downloads/gcc-arm-none-eabi-4_9-2015q3-20150921-linux.tar.bz2
mv gcc-arm-none-eabi-4_9-2015q3/ /opt/
ln -s /opt/gcc-arm-none-eabi-4_9-2015q3/ /opt/gcc-arm-none-eabi
echo "export PATH=$PATH:/opt/gcc-arm-none-eabi/bin" >> /home/vagrant/.bashrc

echo "finished setting shit up"


