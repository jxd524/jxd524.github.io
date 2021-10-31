---
layout: post
title:  "爱阅书香之书源导入与管理教程"
author: Terry
date:   2019-03-21 20:57:00 +0800
categories: 爱阅书香
hide: false
tags: 书源配置 爱阅书香 导入 自定义来源 教程
---
 
* content
{:toc}


# 当前收集的书源配置
有很多热心的小伙伴，提供了各式各样的书源配置。我将其整理了下。欢迎使用









（按发给我的时间为顺序）

点击导入无反应的，请使用苹果手机自带的浏览器safari打开。 

书源作者 | 地址 | 操作
**相逢应不识** | [https://gitee.com/ift123/iFreeTimeBookConfigs](https://gitee.com/ift123/iFreeTimeBookConfigs) | [点击导入](ifreetime://configs/https://gitee.com/ift123/iFreeTimeBookConfigs)
**abc君** | [https://gitee.com/weiniff/ibooks](https://gitee.com/weiniff/ibooks) | [点击导入](ifreetime://configs/https://gitee.com/weiniff/ibooks)
**BlackTouma** | [https://gitee.com/BlackTouma/iFreeTimeBookConfigs](https://gitee.com/BlackTouma/iFreeTimeBookConfigs) | [点击导入](ifreetime://configs/https://gitee.com/BlackTouma/iFreeTimeBookConfigs)
**纲吉** | [https://gitee.com/gangxiaoji/bookConfigs](https://gitee.com/gangxiaoji/bookConfigs) | [点击导入](ifreetime://configs/https://gitee.com/gangxiaoji/bookConfigs)
**feifeiadmim** | [https://gitee.com/feifeiadmim/book_yuan](https://gitee.com/feifeiadmim/book_yuan) | [点击导入](ifreetime://configs/https://gitee.com/feifeiadmim/book_yuan)
**曙光** | [https://gitee.com/shuguanga/aiyue](https://gitee.com/shuguanga/aiyue) | [点击导入](ifreetime://configs/https://gitee.com/shuguanga/aiyue)
**zxhzxhz** | [https://gitee.com/zxhzxhz/booksource](https://gitee.com/zxhzxhz/booksource) | [点击导入](ifreetime://configs/https://gitee.com/zxhzxhz/booksource)
**Liquor030** | [https://gitee.com/Liquor030/iFreeTimeBookConfigs](https://gitee.com/Liquor030/iFreeTimeBookConfigs) | [点击导入](ifreetime://configs/https://gitee.com/Liquor030/iFreeTimeBookConfigs)
**Mxy** | [https://gitee.com/mxyseo/iosread](https://gitee.com/mxyseo/iosread) | [点击导入](ifreetime://configs/https://gitee.com/mxyseo/iosread)
**灰太狼** | [https://gitee.com/Goodyaoshi/iFreeTimeBookConfigs](https://gitee.com/Goodyaoshi/iFreeTimeBookConfigs) | [点击导入](ifreetime://configs/https://gitee.com/Goodyaoshi/iFreeTimeBookConfigs)
**wjc是竟成** | [https://gitee.com/weijingcheng4/aiyueshuxiang](https://gitee.com/weijingcheng4/aiyueshuxiang) | [点击导入](ifreetime://configs/https://gitee.com/weijingcheng4/aiyueshuxiang)
**在这** | [https://gitee.com/adolphz/iFreeTimebookConfigs](https://gitee.com/adolphz/iFreeTimebookConfigs) | [点击导入](ifreetime://configs/https://gitee.com/adolphz/iFreeTimebookConfigs)
**bug退散** | [https://gitee.com/songshu079/i-free-timebook-configs](https://gitee.com/songshu079/i-free-timebook-configs) | [点击导入](ifreetime://configs/https://gitee.com/songshu079/i-free-timebook-configs)


若你有自己的书源，并愿意共享给别人使用，请将地址发给我。谢谢。
我会在博客与公众号（iosRead）上进行发布




## 导入书源的方式

有非常多的方式导入书源，以下列举几种：
### 一鍵导入方式（6.2.0版本之后提供的新功能）
1. 在书架的右上角菜单，选择**书源配置**。
2. 打开右上角的**同步**，输入书源合集地址（如https://gitee.com/ift123/iFreeTimeBookConfigs），可输入多个地址。
3. 点击获取书源配置，等处理完后将**弹出**一个导入界面。
4. 点击右上角的**一键导入**就可以了。

ps：<br>
此方式能保存书源地址，后续需要更新时，只需要点击**获取书源配置**就可以了，**推荐**使用。

### JSON书源文件导入方式
1. QQ群文件中下载**JSON书源**或字体。
2. 直接**用其它应用打开**，
3. 选择**拷贝到爱阅书香**即可。

### 复制书源内容或URL
1. 复制书源的**URL或内容**
2. 在书架的右上角菜单，选择**书源配置**。
3. 在书源配置界面上的右上角菜单，选择**导入剪切板中的信息**


注意：
书源并非越多越好，满足你的需求就够了。
除了自定义书源之后，你还可以使用[自定义来源](/2018/02/23/sourceConfigs/)

## 制作好的书源如何管理

我推荐制作书源的同学自己创建一个GIT，可以选择gitee或者是github。

方便在书源失效的时候更新，爱阅书香支持直接处理这两者的项目地址。

你也可以将书源上传到网络，得到它的URL，然后自己写个网页，把相关信息记录下来。
将对应**a**的**src**属性改为：iFreeTime://configs/http....

如下例子
```
<html>
...
    <a src="iFreeTime://confgis/https://raw.githubuserconten...xx.json">导入</a>
...
</html>
```

此时，使用苹果自带的浏览器打开时，点击“导入”时，就可以调用爱阅书香进行处理了



