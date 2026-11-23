#!/bin/bash
# =================================================================
# OpenWrt 编译环境瘦身脚本 (适用于 GitHub Actions Ubuntu 24.04 / 22.04)
# 作用：清理预装的大型软件、SDK、数据库及缓存，释放 30GB+ 磁盘空间
# =================================================================

set -e

echo "=== 开始清理编译 OpenWrt 不需要的大型预装软件及缓存 ==="
echo "清理前磁盘空间状态："
df -hT / /mnt 2>/dev/null || df -h

# 1. 禁用并清理 Swap 空间
echo "--> 释放 Swap 空间..."
sudo swapoff -a 2>/dev/null || true
sudo rm -f /mnt/swapfile /swapfile 2>/dev/null || true

# 2. 清理 Docker 容器与镜像
echo "--> 清理 Docker 运行时与镜像..."
if command -v docker >/dev/null 2>&1; then
    sudo docker stop $(sudo docker ps -a -q) 2>/dev/null || true
    sudo docker system prune -a --volumes -f 2>/dev/null || true
fi
sudo systemctl stop docker.socket docker.service containerd.service 2>/dev/null || true
sudo rm -rf /var/lib/docker /var/lib/containerd

# 3. 删除非必须的大型预装 SDK 与开发环境目录（重点：Android/DotNet/Haskell/Boost/Swift/CodeQL）
echo "--> 删除不需要的大型预装 SDK 及缓存目录..."
sudo rm -rf \
    /usr/local/lib/android \
    /usr/share/dotnet \
    /opt/ghc \
    /usr/local/.ghcup \
    /root/.ghcup \
    /home/runner/.ghcup \
    /usr/local/share/boost \
    /usr/share/swift \
    /opt/hostedtoolcache/CodeQL \
    /opt/hostedtoolcache/Ruby \
    /opt/hostedtoolcache/Java_* \
    /var/lib/mysql \
    /etc/mysql \
    /var/lib/postgresql \
    /etc/postgresql \
    /var/lib/mongodb \
    /etc/php* \
    /usr/share/sbt \
    /usr/share/gradle*

# 4. 安全清理第三方 apt 软件源（注意：保留 Ubuntu 24.04 的 ubuntu.sources，防止官方源被破坏）
echo "--> 清理多余第三方 apt 源..."
if [ -d /etc/apt/sources.list.d ]; then
    for f in /etc/apt/sources.list.d/*; do
        if [ -f "$f" ] && [ "$(basename "$f")" != "ubuntu.sources" ]; then
            sudo rm -f "$f"
        fi
    done
fi

# 5. 卸载编译完全用不到的大型软件包（保留 llvm/clang/python3/gcc 等编译依赖）
echo "--> 卸载冗余大型预装包..."
sudo -E apt-mark hold grub-efi-amd64-signed 2>/dev/null || true
UNNEEDED_PKGS=(
    "azure-cli*"
    "google-chrome-stable"
    "firefox"
    "powershell*"
    "openjdk*"
    "dotnet-*"
    "aspnetcore-*"
    "mysql*"
    "php*"
    "mongodb*"
    "postgresql*"
    "ghc*"
    "zulu*"
    "moby-*"
    "snapd"
)
sudo -E apt-get -y purge "${UNNEEDED_PKGS[@]}" >/dev/null 2>&1 || true

# 6. 清理包管理器缓存与系统临时文件
echo "--> 清理 apt 缓存与临时文件..."
sudo -E apt-get -y autoremove --purge >/dev/null 2>&1 || true
sudo -E apt-get clean >/dev/null 2>&1 || true
sudo journalctl --vacuum-time=1s 2>/dev/null || true
sudo rm -rf /tmp/* /var/tmp/* 2>/dev/null || true

echo "=== 清理完成！清理后磁盘空间状态： ==="
df -hT / /mnt 2>/dev/null || df -h
exit 0
