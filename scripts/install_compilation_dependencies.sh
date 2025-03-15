#!/bin/bash
sudo -E apt-mark hold grub-efi-amd64-signed
sudo -E apt -y full-upgrade
sudo apt - get update 
sudo apt - get install b43 - fwcutter
sudo apt install -y ack antlr3 aria2 asciidoc autoconf automake autopoint binutils bison btrfs-progs build-essential bzip2 ca-certificates ccache cmake coreutils cpio curl device-tree-compiler fastjar flex g++-multilib gawk gcc-multilib gettext git git-core gperf gzip haveged help2man intltool jq libc6-dev-i386 libelf-dev libfuse-dev libglib2.0-dev libgmp3-dev libltdl-dev libmpc-dev libmpfr-dev libncurses5-dev libncursesw5-dev libpython3-dev libreadline-dev libssl-dev libtool libz-dev lrzsz mkisofs msmtp nano ninja-build p7zip p7zip-full patch pigz pkgconf python2.7 python3 python3-pip python3-pyelftools python3-setuptools qemu-utils rsync scons squashfs-tools swig tar texinfo uglifyjs unzip upx upx-ucl vim wget xmlto xsltproc xxd xz-utils yasm zip zlib1g-dev zstd
sudo -E systemctl daemon-reload 
sudo -E apt -y autoremove --purge
sudo -E apt clean
sudo timedatectl set-timezone "Asia/Shanghai"
