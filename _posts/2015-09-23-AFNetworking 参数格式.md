---
layout: post
title:  "AFNetworking 请求与响应格式说明"
author: Terry
date:   2015-09-23 10:00:00 +0800
categories: iOS
tags: AFNetworking 请求与响应格式说明
---

# 请求格式

类名 | 说明 | 生成GET数据 | 生成POST数据
--- | ---- | ---
AFHTTPRequestSerializer | 常规的参数组装 | key1=value1&key2=value2 | key1=value1&key2=value2
AFJSONRequestSerializer | JSON数据 | key1=value1&key2=value2 | {"key1":"value1","key2":"value2"}
AFPropertyListRequestSerializer | PLIST格式数据 | key1=value1&key2=value2 | [查看](#plist)






# 响应格式

类名 | 说明
---- | ---- 
AFHTTPResponseSerializer | 直接返回接收到的数据
AFJSONResponseSerializer | 将接收到的JSON数据解释成 NSDictionary
AFXMLParserResponseSerializer | XML,只能返回XMLParser,还需要自己通过代理方法解析
AFXMLDocumentResponseSerializer | (Mac OS X)
AFPropertyListResponseSerializer | PList 
AFImageResponseSerializer | Image 
AFCompoundResponseSerializer | 组合 

响应的处理流程是: 接收到数据后,根据指定的类名,如 AFJSONResponseSerializer, 将数据进行解释,转成符合标准的类名.
所以那怕你直接使用 AFHTTPResponseSerializer 也没问题.当接收到数据后,你再把Data进行你想要的转换就可以了

<span id="plist" />
AFPropertyListRequestSerializer 生成的POST数据

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
.<key>key1</key>
.<string>value1</string>
.<key>key2</key>
.<string>......2</string>
</dict>
</plist>
```

例子说明:

```objc
- (void)test
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    [manager POST:strURL parameters:obj success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    /*
    生成的HTTP协议为:
      POST // HTTP//1.1
      Host: www.baidu.com
      ...
      
      key1=value1&key2=%E4%B8%AD%E5%9B%BD2
    */
    
    [manager GET:strURL parameters:obj success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    /**
    生成HTTP协议包:
      GET //?key1=value1&key2=%E4%B8%AD%E5%9B%BD2 HTTP//1.1
      Host: www.baidu.com
      ...
    **/
}
```



