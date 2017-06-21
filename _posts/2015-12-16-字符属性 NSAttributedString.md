---
layout: post
title:  "字符属性 NSAttributedString"
author: Terry
date:   2015-12-16 10:00
categories: iOS
tags: NSAttributedString, iOS字符属性
---

* content
{:toc}

# 基本说明

带有属性的NSString, 指定字符串用什么字体,颜色,段落等方式来显示,常用的初始化代码如下:





```objc
NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:strText attributes:attrProperty];
```

其中attrProperty是一个NSDictionary.支持的键值如下

属性键 | 类的类型 | 默认值 | 备注
----- | ------- | ----- | ----
NSFontAttributeName |  UIFont | 12-point Helvetica(Neue) | 字体名称
NSParagraphStyleAttributeName | NSParagraphStyle | [NSParagraphStyle defaultParagraphStyle] | 段落方式
NSForegroundColorAttributeName | UIColor | 黑色 | 字体颜色
NSBackgroundColorAttributeName | UIColor | 黑色 | 背景颜色
NSLigatureAttributeName | NSNumber(整数) | 1 | 连字符,指某些连在一起的字符.一般不用
NSKernAttributeName | NSNumber(float) | 0 | 字间距
NSStrikethroughStyleAttributeName | NSNumber(整数) | NSUnderlineStyleNone | 删除线
NSUnderlineStyleAttributeName | NSNumber(整数) | NSUnderlineStyleNone | 下划线
NSStrokeColorAttributeName | UIColor | NSForegroundColorAttributeName的值 | 边线颜色,如果该属性不指定（默认），则等同于 NSForegroundColorAttributeName。否则,指定为删除线或下划线颜色
NSStrokeWidthAttributeName | NSNumber(float) | 0 | 边线宽度.默认为 0，即不改变.正数只改变描边宽度;负数同时改变文字的描边和填充宽度 
NSShadowAttributeName |  NSShadow | nil | 阴影
NSTextEffectAttributeName | NSString | nil | 字体效果,到9.2SDK,只提供NSTextEffectLetterpressStyle
NSAttachmentAttributeName |  NSTextAttachment | nil | 文本附件, 常用于文字图片混排
NSLinkAttributeName | NSURL或NSString | nil | 超连接,点击时可跳转
NSBaselineOffsetAttributeName | NSNumber(float) | 0 | 基线偏移值, 正值上偏,负值下偏
NSUnderlineColorAttributeName | UIColor | nil | 下划线颜色,默认使用 NSForegroundColorAttributeName
NSStrikethroughColorAttributeName | UIColor | nil | 删除线颜色,默认使用 NSForegroundColorAttributeName
NSObliquenessAttributeName | NSNumber(float) | 0 | 基线偏移值, 正值上偏,负值下偏
NSExpansionAttributeName | NSNumber(float) | 0 | 文本横向拉伸,正值横向拉伸文本,负值横向压缩文本
NSWritingDirectionAttributeName | NSArray(NSNumber) | nil | 文字书写方向
NSVerticalGlyphFormAttributeName | NSNumber(integer) | 0 | 文字排版方向, 0: 横排; 1: 竖排,iOS中无需设置

# 常用属性

1. NSFontAttributeName
2. NSForegroundColorAttributeName
3. NSParagraphStyleAttributeName

其它用得比较少 

# 例子

```ojbc
NSDictionary *attrProperty = @{NSLigatureAttributeName: @1, NSKernAttributeName: @10};
```

