#!/bin/bash
sudo -E apt-get -y update
sudo -E apt-get -y install $(curl -fsSL https://raw.githubusercontent.com/0118Add/Openwrt-CI/refs/heads/main/depends-ubuntu-2204)
sudo -E systemctl daemon-reload
sudo -E apt-get -y autoremove --purge
sudo -E apt clean
sudo timedatectl set-timezone "Asia/Shanghai"
