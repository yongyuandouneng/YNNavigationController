//
//  ProductListViewController.m
//  YNNavigationController
//
//  Created by ZYN on 16/7/27.
//  Copyright © 2016年 Yongneng Zheng. All rights reserved.
//

#import "ProductListViewController.h"
#import "ProductDetailViewController.h"
#import "DiscoverViewController.h"
#import "TestNavigationController.h"

@implementation ProductListViewController
- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.title = @"商品列表";
    
    self.view.backgroundColor = [UIColor redColor];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:self.view.bounds];
    [btn setTitle:@"点我，快点我" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(tapOnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

- (void)tapOnClick{

    [self.navigationController pushViewController:[[ProductDetailViewController alloc]init] animated:YES];
    
    
//    DiscoverViewController * v = [[DiscoverViewController alloc]init];
//    
//    TestNavigationController *NA = [[TestNavigationController alloc]initWithRootViewController:v];
//    
//    [self presentViewController:NA animated:YES completion:nil];
    
    
    
}



@end
