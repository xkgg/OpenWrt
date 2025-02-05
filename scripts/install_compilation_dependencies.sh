#!/bin/bash
sudo -E apt-mark hold grub-efi-amd64-signed
sudo -E apt -y full-upgrade
sudo apt install -y build-essential libncursesw5-dev libncurses5-dev clang flex bison g++ gawk \
gcc-multilib g++-multilib gettext git libncurses-dev libssl-dev \
python3-distutils python3-setuptools python3 ccache git-core rsync swig unzip zlib1g-dev file wget || sudo apt install -y build-essential libncursesw5-dev libncurses5-dev clang flex bison g++ gawk \
gcc-multilib g++-multilib gettext git libncurses-dev libssl-dev \
python3-distutils python3-setuptools python3 ccache git-core rsync swig unzip zlib1g-dev file wget
sudo -E systemctl daemon-reload 
sudo -E apt -y autoremove --purge
sudo -E apt clean
sudo timedatectl set-timezone "Asia/Shanghai"
