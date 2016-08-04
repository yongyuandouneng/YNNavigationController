//
//  UIViewController+YNNavigationViewController.h
//  YNNavigationController
//
//  Created by ZYN on 16/8/4.
//  Copyright © 2016年 Yongneng Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSObject+YNAssociateObject.h"

@interface UIViewController (YNNavigationViewController)

/** 是否禁止右滑手势 NO */
@property (nonatomic, assign) BOOL yn_banRightSliderGesture;

/** 是否开启重置手势 开启后才能设置下面的值 默认 NO */
@property (nonatomic, assign) BOOL yn_resetGestureViewController;

/** 重置手势滑动返回的上一个控制器 Class */
@property (nonatomic, assign) Class yn_resetGestureViewControllerClass;


@end

