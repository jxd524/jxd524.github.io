---
layout: post
title:  "爱阅书香收集的书源仓库合集"
author: Terry
date:   2020-01-23 12:21:00 +0800
categories: 爱阅书香
hide: false
tags: 书源配置 爱阅书香 导入 自定义来源 教程
---
 
* content
{:toc}


# 介绍
爱阅书香：根据**书源**，将相应**网站**的内容**映射**到软件中！！！

**书源**：一个网站的**规则**描述文件，可能包括有多个**来源**;

**来源**：聚合网站包括多个网站的内容，**一个来源**表示其中**一个网站**。

**仓库**，存储**书源**的地方，可能有**多个书源**；









# 收集的书源仓库

（按发给我的时间为顺序）

点击导入无反应的，请使用苹果手机自带的浏览器safari打开。 

书源作者 | 地址 | 操作
**相逢应不识** | [https://gitee.com/ift123/iFreeTimeBookConfigs](https://gitee.com/ift123/iFreeTimeBookConfigs) | [点击导入](ifreetime://configs/https://gitee.com/ift123/iFreeTimeBookConfigs)
**wxdjs** | [https://github.com/wxdjs/iFreeTimebookConfigs](https://github.com/wxdjs/iFreeTimebookConfigs) | [点击导入](ifreetime://configs/https://github.com/wxdjs/iFreeTimebookConfigs)
**踏雪流云** | [https://gitee.com/q7478729/books](https://gitee.com/q7478729/books) | [点击导入](ifreetime://configs/https://gitee.com/q7478729/books)
**Superman** | [https://gitee.com/superman1024/iFreeTimeBooks](https://gitee.com/superman1024/iFreeTimeBooks) | [点击导入](ifreetime://configs/https://gitee.com/superman1024/iFreeTimeBooks)
**奪情畢自斃** | [https://gitee.com/qzlivn/BookConfig](https://gitee.com/qzlivn/BookConfig) | [点击导入](ifreetime://configs/https://gitee.com/qzlivn/BookConfig)
**abc君** | [https://gitee.com/weiniff/ibooks](https://gitee.com/weiniff/ibooks) | [点击导入](ifreetime://configs/https://gitee.com/weiniff/ibooks)
**BlackTouma** | [https://github.com/BlackTouma/iFreeTimeBookConfigs](https://github.com/BlackTouma/iFreeTimeBookConfigs) | [点击导入](ifreetime://configs/https://github.com/BlackTouma/iFreeTimeBookConfigs)
**gangxiaoji** | [https://github.com/gangxiaoji/bookConfigs](https://github.com/gangxiaoji/bookConfigs) | [点击导入](ifreetime://configs/https://github.com/gangxiaoji/bookConfigs)
**wangyingbo** | [https://github.com/wangyingbo/iFreeTimeBookConfigs](https://github.com/wangyingbo/iFreeTimeBookConfigs) | [点击导入](ifreetime://configs/https://github.com/wangyingbo/iFreeTimeBookConfigs)
**feifeiadmim** | [https://gitee.com/feifeiadmim/book_yuan](https://gitee.com/feifeiadmim/book_yuan) | [点击导入](ifreetime://configs/https://gitee.com/feifeiadmim/book_yuan)
**mm0809** | [https://github.com/mm0809/BUUK](https://github.com/mm0809/BUUK) | [点击导入](ifreetime://configs/https://github.com/mm0809/BUUK)


若你有自己的书源，并愿意共享给别人使用，请将地址发给我。谢谢。
我会在博客与公众号（iosRead）上进行发布


## 导入方式


### 一鍵导入

1. 复制上面的书源仓库地址
2. 在书架的右上角菜单，选择**书源配置**。
3. 打开右上角的**同步**，粘贴地址。
4. 点击获取书源配置，等处理完后将**弹出**一个导入界面。
5. 点击右上角的**一键导入**就可以了。

![一键导入](/files/ift_bsimport.png)

ps：<br>
此方式能保存书源地址，后续需要更新时，只需要点击**获取书源配置**就可以了，**推荐**使用。

### 书源文件导入方式
1. 将**书源**文件（json或ibs）传输到苹果手机（QQ或微信）
2. 直接**用其它应用打开**，选择**拷贝到爱阅书香**即可。

![导入书源文件](/files/ift_ibsImport.jpg)


### 复制书源内容或URL导入方式

1. 复制书源的**URL或内容**
2. 在书架的右上角菜单，选择**导入剪切板**


注意：
书源并非越多越好，满足你的需求就够了。
除了自定义书源之后，你还可以使用[自定义来源](/2018/02/23/sourceConfigs/)

## 制作好的书源如何管理

我推荐制作书源的同学自己创建一个GIT，可以选择gitee或者是github。

方便在书源失效的时候更新，爱阅书香支持直接处理这两者的项目地址。

你也可以将书源上传到网络，得到它的URL，然后自己写个网页，把相关信息记录下来。
将对应**a**的**src**属性改为：**iFreeTime://configs/**书源地址

如下例子
```
<html>
...
    <a src="iFreeTime://confgis/https://raw.githubuserconten...xx.ibs">导入</a>
...
</html>
```

此时，使用苹果自带的浏览器打开时，点击“导入”时，就可以调用爱阅书香进行处理了



