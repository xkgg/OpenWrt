#!/bin/bash
set -e

sudo timedatectl set-timezone "Asia/Shanghai" 2>/dev/null || true
sudo -E apt-get -y update

UBUNTU_VER=$(lsb_release -rs 2>/dev/null || echo "24.04")
echo "当前操作系统版本: Ubuntu $UBUNTU_VER"

# Ubuntu 24.04 编译 OpenWrt 核心依赖包列表 (本地保障备选)
DEPENDS_2404="asciidoc bash bc bin86 binutils build-essential bison bzip2 clang-15 llvm-15 clang llvm file flex g++ g++-multilib gawk gcc gcc-multilib gettext git gzip help2man intltool libboost-dev libssl-dev libelf-dev libncurses-dev libthread-queue-any-perl libusb-dev libxml-parser-perl make patch perl-modules python3 python3-dev python3-pip python3-pyelftools python3-setuptools rsync sharutils swig tar time unzip util-linux wget xsltproc xz-utils zlib1g-dev zip zstd"

# 工作流与固件制作附加关键工具（LVM合并磁盘、Btrfs文件系统、ISO/虚拟机镜像生成工具、无线驱动固件裁剪工具）
EXTRA_DEPS="genisoimage qemu-utils btrfs-progs lvm2 dosfstools b43-fwcutter"

if [[ "$UBUNTU_VER" =~ ^24\. ]]; then
    DEP_URL="https://raw.githubusercontent.com/0118Add/Openwrt-CI/refs/heads/main/depends-ubuntu-2404"
else
    DEP_URL="https://raw.githubusercontent.com/0118Add/Openwrt-CI/refs/heads/main/depends-ubuntu-2204"
fi

REMOTE_DEPS=$(curl -fsSL --retry 3 "$DEP_URL" 2>/dev/null || true)

if [ -n "$REMOTE_DEPS" ]; then
    # 过滤掉 Ubuntu 24.04 已移除的旧包（如 libncurses5-dev）
    REMOTE_DEPS=$(echo "$REMOTE_DEPS" | sed -E 's/\blibncurses5-dev\b//g')
    echo "使用远程依赖列表: $DEP_URL"
    sudo -E apt-get -y install $REMOTE_DEPS $EXTRA_DEPS || sudo -E apt-get -y install $DEPENDS_2404 $EXTRA_DEPS
else
    echo "使用内置依赖列表"
    sudo -E apt-get -y install $DEPENDS_2404 $EXTRA_DEPS
fi

sudo -E systemctl daemon-reload 2>/dev/null || true
sudo -E apt-get -y autoremove --purge
sudo -E apt-get clean
