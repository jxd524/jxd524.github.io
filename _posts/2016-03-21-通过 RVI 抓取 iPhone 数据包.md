---
layout: post
title:  "通过 RVI 抓取 iPhone 数据包"
author: Terry
date:   2016-03-21 16:00:00 +0800
categories: iOS
tag: RVI 抓包
---

* content
{:toc}

# RVI 简介

苹果在 iOS 5 中新引入了“ **远程虚拟接口**（Remote Virtual Interface, **RVI** ）”的特性，可以在 Mac 中建立一个虚拟网络接口来作为 iOS 设备的网络栈，这样所有经过 iOS 设备的流量都会经过此虚拟接口。此虚拟接口只是监听 iOS 设备本身的协议栈（但并没有将网络流量中转到 Mac 本身的网络连接上），所有网络连接都是 iOS 设备本身的，与 Mac 电脑本身联不联网或者联网类型无关。iOS设备本身可以为任意网络类型（WiFi/xG），这样在 Mac 电脑上使用任意抓包工具（tcpdump、Wireshark、CPA）抓取 RVI 接口上的数据包就实现了对 iPhone 的抓包。
Mac OS X 对 RVI 的支持是通过终端命令 rvictl 提供的，在终端（Terminal）中输入“ rvictl  ? ”命令可查看帮助：





```shell
rvictl Options:
           -l, -L                     List currently active devices
           -s, -S                     Start a device or set of devices
           -x, -X                     Stop a device or set of devices
```

# 使用

1. 使用**rvictl  -s <UDID>**命令创建虚拟接口
2. 使用**rvictl  -l**列出所有挂接的虚拟接口。
3. 使用**rvictl  -x <UDID>**命令删除虚拟接口

# 抓包工具

在MAC下,使用 **Wireshark** 有关具体使用,直接百度.不做重复


