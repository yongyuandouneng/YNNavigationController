//
//  UIViewController+YNNavigationViewController.m
//  YNNavigationController
//
//  Created by ZYN on 16/8/4.
//  Copyright © 2016年 Yongneng Zheng. All rights reserved.
//

#import "UIViewController+YNNavigationViewController.h"


@implementation UIViewController (YNNavigationViewController)


- (void)setYn_banRightSliderGesture:(BOOL)yn_banRightSliderGesture{
    
    [self yn_SetAssociativeObject:@(yn_banRightSliderGesture) forKey:@"yn_banRightSliderGesture"];
}


- (BOOL)yn_banRightSliderGesture{
    
    return [[self yn_AssociativeObjectForKey:@"yn_banRightSliderGesture"] boolValue];
}

- (void)setYn_resetGestureViewController:(BOOL)yn_resetGestureViewController{
    
    [self yn_SetAssociativeObject:@(yn_resetGestureViewController) forKey:@"yn_resetGestureViewControllerKey"];
}

- (BOOL)yn_resetGestureViewController{
    
    return [[self yn_AssociativeObjectForKey:@"yn_resetGestureViewControllerKey"] boolValue];
}


- (void)setYn_resetGestureViewControllerClass:(Class)yn_resetGestureViewControllerClass{
    
    [self yn_SetAssociativeObject:yn_resetGestureViewControllerClass forKey:@"yn_resetGestureViewControllerClass"];
    
}

- (Class)yn_resetGestureViewControllerClass{
    
    return [self yn_AssociativeObjectForKey:@"yn_resetGestureViewControllerClass"];
    
}


@end

