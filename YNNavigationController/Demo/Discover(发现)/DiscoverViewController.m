//
//  DiscoverViewController.m
//  YNNavigationController
//
//  Created by ZYN on 16/7/27.
//  Copyright © 2016年 Yongneng Zheng. All rights reserved.
//

#import "DiscoverViewController.h"
#import "GoodsShareViewController.h"

@interface DiscoverViewController ()

@property (weak, nonatomic) IBOutlet UILabel *topLabel;



@end

@implementation DiscoverViewController


- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.title = @"发现";
    
    self.view.backgroundColor = [UIColor greenColor];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:self.view.bounds];
    [btn setTitle:@"点我，快点我" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(tapOnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    
    
}

- (void)tapOnClick{
    
    GoodsShareViewController *v= [[GoodsShareViewController alloc]init];

    
    [self.navigationController pushViewController:v animated:YES];
    
    
    
}

@end
