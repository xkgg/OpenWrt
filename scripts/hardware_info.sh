#!/bin/bash
echo -e "-----------------------------------------------------------------------------\n"
echo -e "温馨提示："
echo -e "GitHub Actions运行器使用CPU的型号不一定相同,运行器性能不同将会影响编译速度。\n"
echo -e "-----------------------------------------------------------------------------\n"
echo -e "运行器硬件信息\n"
echo -e "-----------------------------------CPU信息-----------------------------------\n"
echo "物理CPU数量:$(grep "physical id" /proc/cpuinfo| sort| uniq| wc -l)"
echo "CPU核心数量:$(grep "cores" /proc/cpuinfo|uniq|awk '{print $4}')"
echo "CPU线程数量:$(grep -c "processor" /proc/cpuinfo)"
echo -e "CPU型号:$( grep 'model name' /proc/cpuinfo| sort | uniq |sed 's/.*://') \n"
echo -e "-----------------------------------内存信息-----------------------------------\n"
echo "内存总量:$(grep MemTotal /proc/meminfo|sed 's/.*://')"
echo "空闲内存量:$(grep MemFree /proc/meminfo|sed 's/.*://')"
echo "内存详细信息："
free -m
echo -e ""
echo -e "-----------------------------------硬盘信息-----------------------------------\n"
df --total  -Th
echo -e ""
echo -e "注：合并磁盘后可用空间将大幅度增加\n"
echo -e "-----------------------------------------------------------------------------\n"
echo -e "运行器详细信息:\n"
sudo lshw
echo -e "-----------------------------------------------------------------------------\n"
exit 0