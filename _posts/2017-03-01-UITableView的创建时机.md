---
layout: post
title:  "UITableView的创建时机"
author: Terry
date:   2017-03-01 11:20:00 +0800
categories: iOS
tags: UITableView 代码创建 backgroundColor 重置
---

* content
{:toc}

# 测试环境
iPad8.1, iPad10.2, iPhone10.2

# 问题描述
在ViewController中的 viewWillAppear 中创建类型为UITableViewStylePlain的UITableView, 设置其背景为 [UIColor clear]时,并加载数据.在此VC中,再打开另一个VC.将已打开的这两个VC关闭.此为一个流程,记为流程A;
在第一次执行流程A时,可正常显示.但在第二次执行A时,发现UITableView的背景色被系统设置为白色.




伪代码描述

```objc
@implementation VC1

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor grayColor];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        [SubVC2 Show];
    });
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!tableView)
    {
        1: tableView create and setting
        2: tableView.backgroundColor = [UIColor clear];

    }
    3: tableView loadData
}
@end

@implementation VC2
//nothing
@end
```

# 调试结果

```shell
(
0   iprivate                            0x00193b74 -[UITableView(xx) setBackgroundColor:] + 196
1   CoreFoundation                      0x02c53a8d __invoking___ + 29
2   CoreFoundation                      0x02d46e94 -[NSInvocation invokeUsingIMP:] + 244
3   UIKit                               0x04b422e7 __workaround10030904InvokeWithTarget_block_invoke + 83
4   UIKit                               0x04366bef +[UIView _performSystemAppearanceModifications:] + 52
5   UIKit                               0x04b42289 workaround10030904InvokeWithTarget + 886
6   UIKit                               0x04b3ba24 applyInvocationsToTarget + 1824
7   UIKit                               0x04b3aa98 +[_UIAppearance _applyInvocationsTo:window:matchingSelector:onlySystemInvocations:] + 2180
8   UIKit                               0x04b3bac6 +[_UIAppearance _applyInvocationsTo:window:matchingSelector:] + 40
9   UIKit                               0x04b3baf0 +[_UIAppearance _applyInvocationsTo:window:] + 37
10  UIKit                               0x04396872 -[UIView(Internal) _applyAppearanceInvocations] + 265
11  UIKit                               0x043972f3 __88-[UIView(Internal) _performUpdatesForPossibleChangesOfIdiom:orScreen:traverseHierarchy:]_block_invoke + 60
12  UIKit                               0x04397285 -[UIView(Internal) _performUpdatesForPossibleChangesOfIdiom:orScreen:traverseHierarchy:] + 175
13  UIKit                               0x043971cf -[UIView(Internal) _didChangeFromIdiom:onScreen:traverseHierarchy:] + 57
14  UIKit                               0x043ac491 -[UIScrollView _didChangeFromIdiom:onScreen:traverseHierarchy:] + 75
15  UIKit                               0x04438804 -[UITableView _didChangeFromIdiom:onScreen:traverseHierarchy:] + 76
16  UIKit                               0x04397186 -[UIView(Internal) _didChangeFromIdiomOnScreen:traverseHierarchy:] + 186
17  UIKit                               0x043966cd -[UIView(Internal) _didMoveFromWindow:toWindow:] + 1894
18  UIKit                               0x043b0c33 -[UIScrollView _didMoveFromWindow:toWindow:] + 80
19  UIKit                               0x043962fd -[UIView(Internal) _didMoveFromWindow:toWindow:] + 918
20  UIKit                               0x04388406 __45-[UIView(Hierarchy) _postMovedFromSuperview:]_block_invoke + 182
21  Foundation                          0x010798f2 -[NSISEngine withBehaviors:performModifications:] + 152
22  Foundation                          0x01079855 -[NSISEngine withAutomaticOptimizationDisabled:] + 31
23  UIKit                               0x043882cb -[UIView(Hierarchy) _postMovedFromSuperview:] + 880
24  UIKit                               0x043995f0 -[UIView(Internal) _addSubview:positioned:relativeTo:] + 2318
25  UIKit                               0x04386246 -[UIView(Hierarchy) addSubview:] + 980
26  UIKit                               0x042b2253 -[_UIParallaxDimmingView didMoveToWindow] + 196
27  UIKit                               0x04396738 -[UIView(Internal) _didMoveFromWindow:toWindow:] + 2001
28  UIKit                               0x043962fd -[UIView(Internal) _didMoveFromWindow:toWindow:] + 918
29  UIKit                               0x04388406 __45-[UIView(Hierarchy) _postMovedFromSuperview:]_block_invoke + 182
30  Foundation                          0x010798f2 -[NSISEngine withBehaviors:performModifications:] + 152
31  Foundation                          0x01079855 -[NSISEngine withAutomaticOptimizationDisabled:] + 31
32  UIKit                               0x043882cb -[UIView(Hierarchy) _postMovedFromSuperview:] + 880
33  UIKit                               0x043995f0 -[UIView(Internal) _addSubview:positioned:relativeTo:] + 2318
34  UIKit                               0x04386246 -[UIView(Hierarchy) addSubview:] + 980
35  UIKit                               0x042ac78b __53-[_UINavigationParallaxTransition animateTransition:]_block_invoke_2 + 2229
36  UIKit                               0x043910e9 +[UIView(Animation) performWithoutAnimation:] + 102
37  UIKit                               0x042abe77 __53-[_UINavigationParallaxTransition animateTransition:]_block_invoke + 230
38  UIKit                               0x043978ca +[UIView(Internal) _performBlockDelayingTriggeringResponderEvents:] + 227
39  UIKit                               0x042ab7bd -[_UINavigationParallaxTransition animateTransition:] + 1340
40  UIKit                               0x044cd313 -[UINavigationController _startCustomTransition:] + 4950
41  UIKit                               0x044de9fd -[UINavigationController _startDeferredTransitionIfNeeded:] + 836
42  UIKit                               0x044dfebd -[UINavigationController __viewWillLayoutSubviews] + 70
43  UIKit                               0x0470369a -[UILayoutContainerView layoutSubviews] + 232
44  UIKit                               0x0439d7e4 -[UIView(CALayerDelegate) layoutSublayersOfLayer:] + 1457
45  libobjc.A.dylib                     0x0150c1b9 -[NSObject performSelector:withObject:] + 59
46  QuartzCore                          0x0410e679 -[CALayer layoutSublayers] + 141
47  QuartzCore                          0x04101503 _ZN2CA5Layer16layout_if_neededEPNS_11TransactionE + 401
48  QuartzCore                          0x04101359 _ZN2CA5Layer28layout_and_display_if_neededEPNS_11TransactionE + 21
49  QuartzCore                          0x0408af57 _ZN2CA7Context18commit_transactionEPNS_11TransactionE + 339
50  QuartzCore                          0x040b9d4c _ZN2CA11Transaction6commitEv + 498
51  QuartzCore                          0x040bb85c _ZN2CA11Transaction17flush_transactionEv + 38
52  UIKit                               0x042c045b _UIApplicationFlushRunLoopCATransactionIfTooLate + 222
53  UIKit                               0x04b84ead __handleEventQueue + 6148
54  CoreFoundation                      0x02c72edf __CFRUNLOOP_IS_CALLING_OUT_TO_A_SOURCE0_PERFORM_FUNCTION__ + 15
55  CoreFoundation                      0x02c56fa7 __CFRunLoopDoSources0 + 519
56  CoreFoundation                      0x02c56434 __CFRunLoopRun + 1124
57  CoreFoundation                      0x02c55d5b CFRunLoopRunSpecific + 395
58  CoreFoundation                      0x02c55bbb CFRunLoopRunInMode + 123
59  GraphicsServices                    0x08858b4c GSEventRunModal + 177
60  GraphicsServices                    0x088589c7 GSEventRun + 80
61  UIKit                               0x042c7ff3 UIApplicationMain + 148
62  iprivate                            0x0011e6bc main + 140
63  libdyld.dylib                       0x065b0799 start + 1
)
```

# 解决方法

将创建的方法放到 viewDidLoad 中
