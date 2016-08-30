//
//  TestNavigationController.m
//  YNNavigationController
//
//  Created by ZYN on 16/7/28.
//  Copyright © 2016年 Yongneng Zheng. All rights reserved.
//

#import "TestNavigationController.h"

@implementation TestNavigationController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    //配置属性
    self.shotViewAnimationType = ShotViewAnimationTypeScale;
    self.scaleViewFloat = 0.9;
    
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{

    viewController.hidesBottomBarWhenPushed = YES;
    
    if (self.childViewControllers.count) {
        UIBarButtonItem *left = [self.class barButtonItemWithImage:[UIImage imageNamed:@"back-.png"] ImageH:[UIImage imageNamed:@"back-"] target:self action:@selector(popToPre) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = left;
    }
      [super pushViewController:viewController animated:animated];
}

- (void)popToPre{
    
    [self yn_popViewController]; 
    
}


+ (UIBarButtonItem*)barButtonItemWithImage:(UIImage*)imageN ImageH:(UIImage*)imageH target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:imageN forState:UIControlStateNormal];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:controlEvents];
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}


@end
