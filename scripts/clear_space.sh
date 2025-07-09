#!/bin/bash
sudo rm -rf /etc/apt/sources.list.d/* /usr/share/dotnet /usr/local/lib/android /opt/ghc /etc/mysql /etc/php
sudo -E apt-mark hold grub-efi-amd64-signed
sudo -E apt update
sudo -E apt -y purge azure-cli* docker* ghc* zulu* llvm* firefox google* dotnet* powershell* openjdk* mysql* php* mongodb* dotnet* snap* moby* 2>&1
sudo -E apt-get -qq autoremove --purge
sudo -E apt-get -qq clean
exit 0
