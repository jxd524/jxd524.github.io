---
layout: post
title:  "爱阅书香之自定义书源帮助文档"
author: Terry
date:   2018-11-14 17:17:00 +0800
categories: 爱阅书香
hide: false
tags: 书源配置 爱阅书香 自定义来源
---
 
* content
{:toc}

# 自定义书源说明

书源配置功能，是指从给定的网站来，将其数据按一定的规则，映射到软件中。爱阅书香提供了一系统的规则，以便您使用。

爱阅书香的所有数据接口，都是可配置的。支持非常丰富的自定义数据，包含以下
1. **书籍搜索**
2. **列表详情**：这是一个根据给定的地址，主要为了解析出书籍的**章节标题**和**章节地址**。默认处理方式为[动态解析](/2018/02/23/sourceConfigs/)。
3. **章节详情**：解析出指定章节的内容。默认处理方式为[动态解析](/2018/02/23/sourceConfigs/)。
4. **书海配置**：根据给定的规则，最终生成一组书籍信息。类似榜单，分类，书单都可以在这里完成
5. **书籍详情**：解析出书籍的详细信息，包含简介，封面，字数等，具体可参考配置界面的**添加**
6. **多来源搜索**：解析出多个来源，一般不需要用到。只有聚合类网站才会需要到。
7. **关键词联想**：当你在搜索界面，输入时进行的联想的配置，解析出一系列的联想词。


想自行配置书源，您需要学会简单的数据分析，解析方式支持XPath，JSON，正则表达式。



## 一个简单的例子

请参考默认提供的书源配置中，被禁用掉的“U小说”与“E小说”。这两个配置只写了**书籍搜索**的规则。章节列表与详情方面的内容，则是使用默认的[动态解析](/2018/02/23/sourceConfigs/)来处理。大部情况，你自行添加的源，都只需要书写这一规则。

下面是E小说的配置，若你没有此配置，可以**复制以下代码**，然后在配置中选择菜单**导入剪切板中的书源信息**
```shell
{
    "enable":1,
    "weight":9,
    "priorityEncoding":4,
    "responseType":0,
    "name":"E小说",
    "bookWorld":{},
    "lastModifyTime":"2018-11-14 23:21:35",
    "homeUrl":"https://www.zwda.com/",
    "authorId":"6d2370e2088b9556423c257fd3f8c5dd",
    "httpConfigs":{
        "useCookies":1,
        "headers":{}
    },
    "searchBook":{
        "forGetMethod":1,
        "nextPageForGetMedthod":1,
        "maxPageCount":"3",
        "nextPageParams":{},
        "params":{},
        "url":"https://www.zwda.com/search.php?keyword=%@",
        "nextPageUrl":"//div[@class=\"search-result-page-main\"]/a[@title='下一页']/@href",
        "parser":{
            "bookName":".//h3//span/text()",
            "_1":{
                "dirURL":".//h3/a/@href"
            },
            "desc":".//p[@class=\"result-game-item-desc\"]",
            "_list":"//div[@class=\"result-item result-game-item\"]",
            "coverUrl":".//div[@class=\"result-game-item-pic\"]//img/@src",
            "lastUpdateDate":".//p[@class=\"result-game-item-info-tag\"][3]/span[2]/text()",
            "typeText":".//p[@class=\"result-game-item-info-tag\"][2]/span[2]/text()",
            "author":".//p[@class=\"result-game-item-info-tag\"][1]/span[2]//text()"
        }
    }
}
```

### 规则之访问地址生成

不管我们在搜索信息，或者是访问内容，都需要一个地址（URL）。

**搜索书籍**配置中，使用的URL如下：

```
"url":"https://www.zwda.com/search.php?keyword=%@"
```

其中**%@**是一个可用于替换关键词的标志。更复杂的生成URL方式，在后续再进行说明

### 规则之内容解析

我们使用生成后的URL去访问，返回一般是一个HTML的内容。这时就需要使用xPath来进行解析了。


。。。未完，写文档还是难过写代码啊。






