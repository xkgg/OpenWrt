# OpenWrt 自动云编译

[![GitHub Repo stars](https://img.shields.io/github/stars/xkgg/OpenWrt?style=flat-square)](https://github.com/xkgg/OpenWrt/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/xkgg/OpenWrt?style=flat-square)](https://github.com/xkgg/OpenWrt/network/members)
[![GitHub last commit](https://img.shields.io/github/last-commit/xkgg/OpenWrt?style=flat-square)](https://github.com/xkgg/OpenWrt/commits)
[![Workflow Status](https://img.shields.io/github/actions/workflow/status/xkgg/OpenWrt/build-openwrt.yml?branch=main&style=flat-square)](https://github.com/xkgg/OpenWrt/actions/workflows/build-openwrt.yml)

> 基于 GitHub Actions 的 OpenWrt 固件与软件包自动化云编译系统。全面适配 Ubuntu 24.04 构建环境，支持矩阵拆分构建、LVM 磁盘扩容及 Release 自动化发布。

---

## 固件特性

1. **官方源码全量构建**：
   - 默认管理 IP：`192.168.2.1`
   - 默认密码：`password`
   - 保留全量 Git 历史提交，确保固件准确生成版本号（如 `rXXXXX`）。
2. **构建环境全面升级**：
   - 全面升级至 **Ubuntu 24.04 LTS** 编译运行器，适配最新 Python 3.12 与现代化工具链。
   - 自动检测并集成 LVM + Btrfs 动态磁盘合并扩容机制（可用空间 50GB+），彻底规避编译空间不足。
3. **插件与组件**：
   - 自带丰富的常用 LuCI 插件与应用商店（iStore / QuickStart）。
   - 内置 SmartDNS + AdGuard Home 过滤配置（AdGuard Home 默认管理密码：`password`）。
   - 编译生成常用网卡驱动及全量 `kmod` 内核模块包（打包于 Releases 中的 `allkmod.zip`，拒绝内核不兼容）。

---

## 内置功能

### 1. LuCI 插件

- **主题与界面**：
  - [Argon](https://github.com/jerrykuku/luci-theme-argon)：LuCI 默认主题
  - [luci-app-argon-config](https://github.com/jerrykuku/luci-app-argon-config)：Argon 主题自定义设置
  - luci-app-quickstart：iStoreOS 风格快速向导界面
  - luci-app-iStore：应用商店
- **网络与加速**：
  - [luci-app-turboacc](https://github.com/chenmozhijin/turboacc)：Turbo ACC 网络加速（BBR / 全锥型 NAT）
  - [luci-app-smartdns](https://github.com/pymumu/luci-app-smartdns)：SmartDNS 本地 DNS 服务器
  - [luci-app-openclash](https://github.com/vernesong/OpenClash)：Clash 客户端
  - [luci-app-passwall](https://github.com/xiaorouji/openwrt-passwall)：PassWall 代理插件
  - tailscale：内网穿透 / 组网
  - luci-app-ddns：动态 DNS
  - luci-app-upnp：通用即插即用（UPnP）
  - luci-app-udpxy：IPTV 组播转 HTTP
  - luci-app-omcproxy：IGMP / MLD 组播代理
- **存储与工具**：
  - [luci-app-diskman](https://github.com/lisaac/luci-app-diskman)：DiskMan 磁盘管理
  - luci-app-samba4：Samba 4 文件共享
  - luci-app-fileassistant：文件助手
  - luci-app-ttyd：网页终端
  - [luci-app-socat](https://github.com/chenmozhijin/luci-app-socat)：Socat 端口转发与转发工具
  - [luci-app-pushbot](https://github.com/zzsj0928/luci-app-pushbot)：全能推送机器人
  - luci-app-firewall：防火墙规则
  - luci-app-opkg：软件包管理器
  - luci-app-onliner：在线用户状态

> 注：所有生成的软件包均同步归档在 Releases 中的 `package.zip` 内。

### 2. 常用硬件与网卡驱动

固件已集成主流万兆/千兆网卡驱动与常用虚拟化驱动：

- **Intel**：`kmod-e1000` / `kmod-e1000e` / `kmod-igb` / `kmod-igbvf` / `kmod-igc` (2.5G) / `kmod-ixgbe` (万兆) / `kmod-i40e` / `kmod-iavf`
- **Realtek**：`kmod-r8168` / `kmod-r8152` (USB 2.5G) / `kmod-8139cp` / `kmod-8139too` / `kmod-phy-realtek`
- **Mellanox**：`kmod-mlx4-core` / `kmod-mlx5-core`
- **Broadcom / Atheros / AMD**：`kmod-bnx2` / `kmod-bnx2x` / `kmod-tg3` / `kmod-alx` / `kmod-amd-xgbe`
- **虚拟化平台**：`kmod-vmxnet3` (VMware/ESXi) / `kmod-pcnet32` / `kmod-amazon-ena` (AWS)
- **网络与虚拟接口**：`kmod-macvlan` / `kmod-mii` / `kmod-libphy`

---

## 感谢

感谢以下开源项目与各位开发者的贡献：

- [沉默の金 (chenmozhijin)](https://github.com/chenmozhijin/OpenWrt-K)
- [OpenWrt 官方项目](https://github.com/openwrt/openwrt/)
- [iStoreOS](https://github.com/istoreos/istoreos)
- [Lede (coolsnowwolf)](https://github.com/coolsnowwolf/lede)
- [Lienol](https://github.com/Lienol/openwrt)
- [ImmortalWrt](https://github.com/immortalwrt/immortalwrt/)
- [GitHub Actions](https://github.com/features/actions)

