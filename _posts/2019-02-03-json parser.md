---
layout: post
title:  "爱阅书香之JSON解析教程"
author: Terry
date:   2019-02-03 15:40:00 +0800
categories: 爱阅书香
hide: false
tags: 书源配置 爱阅书香 JSON 教程
---
 
* content
{:toc}


# 简介
针对JSON数据提供的解析方式。





## 简单例子说明

例子1
```
books[!0].name
```
说明：

获取books下，除了第一项之后的所有项，取这些项中所有键名为name的值


例子2
```
books || others
```
说明：

获取所有的books，若取不到，则取所有的others


## 规则说明

基本规则
```
attr1.attr2[-1].attr3[1, 3, -].obj
```

复杂规则
```
基本规则1 || 基本规则2 && 基本规则3 
```

以下为规则说明:
1. 以 **.** 为分隔符，第一段的结果为下一段要分析的内容。
2. **[]**表示条件，从0开始, 1表示第2项，-1表示最后一个，-2表示最后第二位，**!**表示排除指定位置的值，**-**表示对集合进行反转。
3. 以 <strong>||</strong> 作为“或”的方式分隔规则, 只要前面有规则能取到数据，则停止。
4. 以 **&&** 作为"并"的方式分隔规则，合并所有规则的数据。