---
layout: post
title:  "论UIViewControl模态显示的方法"
author: Terry
date:   2017-03-08 11:20:00 +0800
categories: iOS
tags: 转场 presentViewController modalTransitionStyle modalPresentationStyle
---

* content
{:toc}

# 前言

　　在开发iOS时,普遍都是使用UIViewController做为控制器进行MVC开发.比如UINavigationController, UITabBarController,都是从UIViewController继承出来的,不管你在那种VC中,要渲染(打开)另一个VC时,总有各种各样的方式,比如系统提供的showViewController, showDetailViewController, presentViewController.若是UINavigationController还可以使用pushViewController, viewControllers等.除了这些系统提供的,你当然还可以自己实现,就是要多写一些代码.玩转UIKit,只需要你有想法,多尝试.

　　本文只记录由系统提供的**模态**方式来打开VC(UIViewController),即使用presentViewController方式来渲染另一个VC





# 模态使用场景

　　一个模态的VC,一般要处理的事件应该相对简单.处理完就可以关闭,释放内存了.如提供一些帮助说明,与用户的一次交互等.
　　若在你打开的VC中,又需要打开另一个VC,建议你使用UIViewController的子类去做,比如UINavigationController.可以减少不少代码量.

# presentViewController的风姿

　　使用**presentViewController: animated: completion:** 来打开一个VC时,需要清楚两个东西: 有一个叫presentingViewController, 另一个叫presentedViewController. 简单记ing, ed. 其中ed就是你准备显示的界面,那ing就是渲染ed的VC了。

　　一般来说，使用[A presentViewController:B]时, A的ingVC为nil, edVC则为B; 对于B的ingVC则可能是A, edVC则为nil. 为什么对于B的ingVC来说,可能是A呢?若A是UINavigationController下的一个VC,则B的ingVC是A.navigationController.这是由UIKit来决定的.默认是A的"rootViewController"。

　　默认的动画方式就是从下向上打开VC,如果想修改动画方式,可以使用 modalTransitionStyle, 它有几个已经定义好的风格,替换的去试试就知道了,在iPhone跟iPad上有一些小小的区别,测试时,用iPad可以看到所有的效果。

UIModalTransitionStyle定义

```objc
typedef NS_ENUM(NSInteger, UIModalTransitionStyle) {
    UIModalTransitionStyleCoverVertical = 0,
    UIModalTransitionStyleFlipHorizontal __TVOS_PROHIBITED,
    UIModalTransitionStyleCrossDissolve,
    UIModalTransitionStylePartialCurl NS_ENUM_AVAILABLE_IOS(3_2) __TVOS_PROHIBITED,
};
```

**UIModalTransitionStylePartialCurl**: 如果设置为此值，必须设置modalPresentationStyle为UIModalPresentationFullScreen，否则会报错的，这是系统强制要求。

　　如果这些默认实现的动画不满足需求,还可以自己定义转场动画,关于转场动画的实现, 简单的概括下,具体实现与细节,后续再介绍.

## 自定义VC转场动画的概括
1. 定义一个类,实现接口UIViewControllerAnimatedTransitioning
2. 设置要显示的VC的transitioningDelegate的实现对象(T)
3. 对象T实现接口UIViewControllerTransitioningDelegate

## 渲染方式modalPresentationStyle
　　除了设置不同的动画，还可以设置不同的渲染模式

UIModalPresentationStyle的定义：

```objc
typedef NS_ENUM(NSInteger, UIModalPresentationStyle) {
        UIModalPresentationFullScreen = 0,
        UIModalPresentationPageSheet NS_ENUM_AVAILABLE_IOS(3_2) __TVOS_PROHIBITED,
        UIModalPresentationFormSheet NS_ENUM_AVAILABLE_IOS(3_2) __TVOS_PROHIBITED,
        UIModalPresentationCurrentContext NS_ENUM_AVAILABLE_IOS(3_2),
        UIModalPresentationCustom NS_ENUM_AVAILABLE_IOS(7_0),
        UIModalPresentationOverFullScreen NS_ENUM_AVAILABLE_IOS(8_0),
        UIModalPresentationOverCurrentContext NS_ENUM_AVAILABLE_IOS(8_0),
        UIModalPresentationPopover NS_ENUM_AVAILABLE_IOS(8_0) __TVOS_PROHIBITED,
        UIModalPresentationNone NS_ENUM_AVAILABLE_IOS(7_0) = -1,
};
```

　　对这些渲染模式，具体效果，请自行测试来加深理解。提供几个"模态"方式以供参考：

1. 用于显示一个 UIModalPresentationPopover, 在 iPad 下有效

```objc
- (void)showByPopover:(UIButton *)sender
{
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([SubVC1 class])];
    vc.view.backgroundColor = [UIColor clearColor];
    //vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;　//此渲染模式，此属性已无意义
    vc.modalPresentationStyle = UIModalPresentationPopover;
    vc.popoverPresentationController.sourceView = sender;
    vc.popoverPresentationController.sourceRect = sender.bounds;
    vc.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionDown;
    vc.popoverPresentationController.backgroundColor = RGBAlphaValue(0xFF0000, 0.5);
    [self presentViewController:vc animated:YES completion:nil];
}
```

2. 用于显示一个半透明的VC

```objc
- (void)showByCustom
{
    UIViewController *vc = [[UIViewController allow] init];
    vc.view.backgroundColor = RGBAlphaValue(0xFF0000, 0.5);
    vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    vc.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:vc animated:YES completion:nil];
}
```

　　结束！
