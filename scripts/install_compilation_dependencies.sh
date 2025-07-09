#!/bin/bash
sudo -E apt-get -y update
sudo -E apt-get -y install $(curl -fsSL is.gd/depends_ubuntu_2204)
sudo -E systemctl daemon-reload
sudo -E apt-get -y autoremove --purge
sudo -E apt clean
sudo timedatectl set-timezone "Asia/Shanghai"
