---
layout: post
title:  "2018-05-30-iOS模拟器的一些记录"
author: Terry
date:   2018-05-30 10:40:00 +0800
categories: 开发环境
tags: 模拟器
---
 
* content
{:toc}

# iOS模拟器使用技巧记录

针对xCode9自带的模拟器






### 屏幕录制
最简单的方式是只打开一个模拟器,使用以下命令

```objc
xcrun simctl io booted recordVideo filename.mov
```

停止

### 截屏
菜单项 -> Debug -> Optimize Rendering Window Size
这是决定你截屏后图片大小的关键，选中时，图片会自行缩放到原窗口大小。若想把截图上传到AppStore，不要选中它


