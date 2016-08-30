//
//  GoodsShareViewController.m
//  YNNavigationController
//
//  Created by ZYN on 16/8/30.
//  Copyright © 2016年 Yongneng Zheng. All rights reserved.
//

#import "GoodsShareViewController.h"

@interface GoodsShareViewController ()

@end

@implementation GoodsShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"商品分享";
    UIButton *btn = [[UIButton alloc]initWithFrame:self.view.bounds];
    [btn setTitle:@"点我，快点我" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(tapOnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}


- (void)tapOnClick{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
