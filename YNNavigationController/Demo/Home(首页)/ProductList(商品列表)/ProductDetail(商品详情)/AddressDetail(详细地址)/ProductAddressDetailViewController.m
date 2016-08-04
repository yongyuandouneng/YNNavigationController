//
//  ProductAddressDetailViewController.m
//  YNNavigationController
//
//  Created by ZYN on 16/7/29.
//  Copyright © 2016年 Yongneng Zheng. All rights reserved.
//

#import "ProductAddressDetailViewController.h"
#import "ProductListViewController.h"
#import "YNNavigationController.h"
#import "HomeViewController.h"

@implementation ProductAddressDetailViewController
- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.title = @"详细地址(已开启重置手势)";
    
    self.view.backgroundColor = [UIColor greenColor];
    
    
    UIBarButtonItem *left = [self.class barButtonItemWithImage:[UIImage imageNamed:@"back-.png"] ImageH:[UIImage imageNamed:@"back-"] target:self action:@selector(popToPre) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = left;
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/ 2)];
    btn.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [btn setTitle:@"点我，快点我 回到商品列表" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(tapOnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
//
    
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height / 2, self.view.frame.size.width, self.view.frame.size.height/2)];
    
    btn.backgroundColor = [UIColor redColor];
    [btn2 setTitle:@"点我，快点我 回到首页" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(tapOnClick2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    //开启手势
    self.yn_resetGestureViewController = YES;
    
    //重置手势滑动ViewController
    self.yn_resetGestureViewControllerClass = [ProductListViewController class];
    
}

- (void)tapOnClick{
    UIViewController *VC= nil;
    for (UIViewController *viewController in self.navigationController.viewControllers) {
        if ([viewController isKindOfClass:[ProductListViewController class]]) {
            VC = viewController;
        }
    }
    if (VC) {
        [(YNNavigationController *)self.navigationController yn_popToViewController:VC completionBlock:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)tapOnClick2{
    
    [(YNNavigationController *)self.navigationController yn_popToRootViewControllerWithCompletionBlock:nil];
//    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)popToPre{
    
    [self tapOnClick];
    
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
