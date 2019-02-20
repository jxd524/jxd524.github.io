---
layout: post
title:  "爱阅书香之regex解析教程"
author: Terry
date:   2019-02-03 15:40:00 +0800
categories: 爱阅书香
hide: false
tags: 书源配置 爱阅书香 正则表达式 教程
---
 
* content
{:toc}


# 简介
提供对字符串进行解析的方式。正则表达式的语法比较复杂，可自行百度下哦。





## 简单例子说明

例子1
```
<p>.*?</p> @[0]=>XYZ
```
说明：

第一个<p>..</p>的信息替换为XYZ


例子2
```
<p>.*</p> @[1] <ul>.*</ul>
```
说明：

获取第二个<p>..</p>与<ul>...</ul>的所有内容


## 规则说明

基本规则
```
正则表达式1 @[条件]=>新的内容
```

复杂规则
```
基本规则1 || 基本规则2 && 基本规则3 
```

以下为规则说明:
1. 正则表达式的写法与标准相同
2. **[]**表示条件，从0开始, 1表示第2项，-1表示最后一个，-2表示最后第二位，**!**表示排除指定位置的值，**-**表示对集合进行反转。
3. 若有多个reg时，<strong> @</strong> 是不可省的(空格+@字符)，@之后可以接**[]** 或 **=>** 或 **空格**
4. 当存在 **=>** 标志时，表示所有匹配到的数据，都将替换成新字符串；否则表示将所有匹配到的数据合并成新的内容。
5. 以 <strong>||</strong> 作为“或”的方式分隔规则, 只要前面有规则能取到数据，则停止。
6. 以 **&&** 作为"并"的方式分隔规则，合并所有规则的数据。


## 收集的一些正式表达式
* 指定字符之间的内容, 并不包含指定字符
    * 取**begin**与**end** 之间的内容：**(?<=begin).+?(?=end)**
* 指定字符到结尾的内容
    * 取**begin**到行的最后或结尾的字符：**(?<=begin).+?(?=[$\n])**
* 取指定字符之间的内容
    * 取**forLeft**之前的内容: **(?<=).+?forLeft**

更多的请自行百度哦，我自己写正式时，也是边看教程边写的。