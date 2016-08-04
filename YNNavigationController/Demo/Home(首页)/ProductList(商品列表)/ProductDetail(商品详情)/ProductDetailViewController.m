//
//  ProductDetailViewController.m
//  YNNavigationController
//
//  Created by ZYN on 16/7/27.
//  Copyright © 2016年 Yongneng Zheng. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "ProductAddressDetailViewController.h"
#import "YNNavigationController.h"

@implementation ProductDetailViewController
- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.title = @"商品详情";
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:self.view.bounds];
    [btn setTitle:@"点我，快点我" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(tapOnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

- (void)tapOnClick{
    
    [self.navigationController pushViewController:[[ProductAddressDetailViewController alloc]init] animated:YES];
    
}


@end
