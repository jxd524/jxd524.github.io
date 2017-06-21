---
layout: post
title:  "AV Fundation框架"
author: Terry
date:   2016-05-24 14:00:00 +0800
categories: AVFundation
tags: AVFundation框架 
---

* content
{:toc}

# 前言
提供播放或创建基于时间的音视频媒体.可以使用它来检查,创建,编辑或重新对媒体文件进行编码,你也可以从设备中获取输入流并在实时采集中对视频进行处理





![AV Fundation层在IOS的位置](/files/frameworksBlockDiagram_2x.png)

![AV Fundation层在 OS X的位置](/files/frameworksBlockDiagramOSX_2x.png)

一般使用高级别的抽像接口就能完成任务,如果你只是想简单的播放电影,使用 MPMoviePlayerController 或 MPMoviePlayerViewController,或者是 UIWebView最小要求的录制视频使用 UIImagePickerController框架从IOS4.0(包含)之后有效

# 简介

框架主要提供两个方面的API集合: 视频及音频旧的音频相关类提供简单的方法来处理音频,相关描述可以在 [Multimedia Programming Guide](https://developer.apple.com/library/ios/documentation/AudioVideo/Conceptual/MultimediaPG/Introduction/Introduction.html#//apple_ref/doc/uid/TP40009767) 找到.•	播放声音文件,使用 [AVAudioPlayer](https://developer.apple.com/library/ios/documentation/AVFoundation/Reference/AVAudioPlayerClassReference/index.html#//apple_ref/occ/cl/AVAudioPlayer).•	录制音频,使用 [AVAudioRecorder](https://developer.apple.com/library/ios/documentation/AVFoundation/Reference/AVAudioRecorder_ClassReference/index.html#//apple_ref/occ/cl/AVAudioRecorder).你也可以使用[AVAudioSession](https://developer.apple.com/library/ios/documentation/AVFoundation/Reference/AVAudioSession_ClassReference/index.html#//apple_ref/occ/cl/AVAudioSession)来配置你应用程序的音频行为, 相关信息在[Audio Session Programming Guide](https://developer.apple.com/library/ios/documentation/Audio/Conceptual/AudioSessionProgrammingGuide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40007875)## AVFoundation的表现和媒体使用

AV Foundation框架中用于描述媒体最主要的类是: [AVAsset](https://developer.apple.com/library/ios/documentation/AVFoundation/Reference/AVAsset_Class/index.html#//apple_ref/occ/cl/AVAsset) . 框架根据它来设计,了解它的结构,有助你了解框架是如何工作的.一个**AVAsset**实例是一个或多个媒体数据(视频和音频轨道)的集合,作为集合,它提供了如:标题,持续时间,实际大小等等.**AVAsset**没有绑定到特定的数据格式,它是其它类的超类(父类).
轨道指的是:在asset中的每一个单独的,有统一类型的段媒体数据.在一个典型的简单例子中,一个轨道描述音频数据,一个轨道描述视频数据;复杂的作品中,可能包含多个音频和视频的轨道.Asset 也可能包含有元数据(metadata).AV Foundation有一个重要的概念: 初始化一个 Asset 或一个轨道并不意味着它已经准备好可以使用.它可能需要一些时间来计算持续时间(例如MP3文件,可以不包含摘要信息).

## 播放
AV Foundation可以让你用复杂的方式来进行播放.为了支持这一点,它将 Asset 本身的描述状态分开.这样你就可以做,如:播放同一个 Asset的两个不同的片段,在同一时刻渲染到不同的分辨率上.Asset的描述状态由播放它的对象管理,Asset中每个轨道的描述状态由播放它的 track 对象管理.

## 读取,写入和对Asset重新编码
AV Foundation可以让你用几种方式来创建新的Asset.对存在的Asset进行简单编码.或者在IOS4.1及之后,你可以对已经存在的Asset的内容进行操作,再保存为一个新的Asset.你可以使用 Export Session 来对一个存在的Asset进行重新编码,只能使用预设的少数常用格式.如果在转换中,需要更多的控制.你可以使用 Asset reader 和 Asset write 对象来进行转换,如选择指定的轨道输出到文件中,指定你自己的输出格式,或者在转换过程修改Asset.要渲染一个可视的波形图,可以使用 Asset Reader 读取音频轨道. 

## 省略图
为视频演示创建一个缩略图,你要初始化一个 AVAssetImageGenerator 实例,它使用默认可用的视频轨道来生成图片

## 编辑
AV Foundation 使用 Compositions 来从一个已经存在媒体创建一个的Asset(通常是一个或多个视频或音频轨道).你可以使用可变的 Composition 来添加或删除一个轨道,并调整它们的时间顺序,你可以对音频轨道设置它的相对音量和ramping.对视频轨道设置不透明和不透明ramps.一个Composition是在保存在内存媒体件的组合,当你使用 Export session,它将封装成到文件中.你也可以用Asset Writer创建一个Asset, 如Sample缓存数据或静态的图片.## 静态和视频媒体捕获
视频录制和音频录制由 Capture Session 管理.一个Capture Session配置从输入设备到输出设置.对单个 Session,你可以配置多个输入和输出,那怕Session正在运行.你可以向Session发送消息来开始或停止数据流.

## 框架的并发处理
回调有: block, KVO和notification.多线程中,可以使用 NSThread 方法:isMainThread等来判断回调在那个线程中.

