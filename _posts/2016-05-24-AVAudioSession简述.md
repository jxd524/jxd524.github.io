---
layout: post
title:  "Audio Session简述"
author: Terry
date:   2016-05-24 14:40:00 +0800
categories: AVFundation
tags: AVAudioSession 音频种类
---

* content
{:toc}

# 简述

[AVAudioSession](https://developer.apple.com/library/ios/documentation/AVFoundation/Reference/AVAudioSession_ClassReference/) 是一个单例,一个应用App内共享一个实例.它与音视频有很大关系,虽然它本身不参与控制音频的播放.主要提供以下几个功能:





1. 激活或关闭音频Session
2. 设置种类category和模式mode,以确定音频使用的方式
3. 配置音频设置,如采样率,I/O缓存持续时间,声道等
4. 处理音频线程的切换
5. 响应音频事件处理

## 种类Category

系统定义的几个KEY,用于表示不同的音频行为,如下表

种类名称 | 说明
----- | -------
AVAudioSessionCategoryAmbient | 只用于音频播放。<br>特点是允许其他应用程序播放音频，当 Audio Session 的 Active 设为 NO 时（即不激活 Session），你应该会听到两个 APP 同时播放声音。<br>注意，使用该 Category 的 APP 的音频会随着屏幕关闭、进入后台和开启静音键而中断。
AVAudioSessionCategorySoloAmbient | Audio Session 默认的 Category，只用于音频播放。<br>当 Category 设置为它时，不管 Session 是否被激活，其他 APP 的音频都会被中断（不允许音频共存）。<br>注意，使用该 Category 的 APP 的音频会随着屏幕关闭、进入后台和开启静音键而中断。
AVAudioSessionCategoryPlayback | 只用于音频播放。<br>不允许音频共存。<br>允许后台播放，且忽略静音键作用。<br>注意，为了支持后台播放，你需要在应用程序的 info.plist 文件中正确设置 Required background modes。
AVAudioSessionCategoryRecord | 只用于音频录制。<br>设置该 Category 后，除了来电铃声，闹钟或日历提醒之外的其它系统声音都不会被播放。该 Category 只提供单纯录音功能。
AVAudioSessionCategoryPlayAndRecord | 用于音频播放和录制。<br>用于既需要播放声音又需要录音的应用，语音聊天应用（如微信）应该使用这个Category。如果你的应用需要用到 iPhone 上的听筒，该 Category是你唯一的选择，在该 Category 下声音的默认出口为听筒（在没有外接设备的情况下）。
AVAudioSessionCategoryAudioProcessing | 只用于离线音频处理，即使用硬件编解码器处理音频，如离线音频格式转换。<br>该音频会话使用期间，不能播放和录制音频。<br>不过实测中并没有什么卵用，音频还是正常播
AVAudioSessionCategoryMultiRoute | 用于音频播放和录制。<br>它允许多个音频输入/输出，比如音频数据同时从耳机和 USB 接口中出来。好像也不怎么常用。


