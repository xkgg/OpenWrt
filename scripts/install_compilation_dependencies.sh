#!/bin/bash
sudo -E apt-mark hold grub-efi-amd64-signed
sudo -E apt -y full-upgrade
sudo apt - get update 
sudo apt - get install b43 - fwcutter
sudo apt install -y build-essential git wget zlib1g-dev \
libncurses5-dev libssl-dev xz-utils liblzma-dev \
python3-pip python3-setuptools ccache git-lfs lrzsz \
upx-ucl squashfs-tools device-tree-compiler \
genisoimage e2fsprogs msmtp haveged \ 
libc6-dev libc6=2.38-0ubuntu1 mkisofs qemu-utils

sudo apt-get upgrade libc6
sudo -E systemctl daemon-reload 
sudo -E apt -y autoremove --purge
sudo -E apt clean
sudo timedatectl set-timezone "Asia/Shanghai"
