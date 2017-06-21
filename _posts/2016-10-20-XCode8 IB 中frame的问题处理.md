---
layout: post
title:  "XCode8 IB 中frame的问题处理"
author: Terry
date:   2016-09-20 14:55:00 +0800
categories: iOS
tags: Dash, XCode8, IB 默认frame值
---

* content
{:toc}

# 问题描述

升级XCode8,iOS10之后,小问题不断.这次是以前用IB设计的一些界面,现在用XCode打开后,某些XIB文件或Story中的View, 直接去获取 frame 时, 返回都是 (0, 0, 1000, 1000).





# 解决方式

有以下方式可以解决
1. 可以在调用 mYouView.frame 之前调用 [mYouView layoutIfNeed];
2. 修改XIB或Storyboard文件![](/files/14769564821607.jpg)



