//
//  HomeViewController.m
//  YNNavigationController
//
//  Created by ZYN on 16/7/27.
//  Copyright © 2016年 Yongneng Zheng. All rights reserved.
//

#import "HomeViewController.h"
#import "ProductListViewController.h"

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (nonatomic, assign) NSInteger time;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation HomeViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.title = @"首页";
    
    [self.navigationController.navigationBar setTranslucent:NO];
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(test2) userInfo:nil repeats:YES];
    self.timer = timer;
    
    
    BOOL isHasTableView = NO;
    for (UIView *view in self.view.subviews) {
        if([view isKindOfClass:[UITableView class]]) {
            isHasTableView = YES;
        }
    }
    if (!isHasTableView) {
        UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        tableview.delegate = self;
        tableview.dataSource = self;
        [self.view addSubview:tableview];
        
    }
    
}

- (void)test2{
    self.time++ ;
    self.timerLabel.text = [NSString stringWithFormat:@"%zd",self.time];
}

#pragma mark - UITableViewDelegate  UITableViewDataSource

//header-height
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return 10;
    
}
//header-secion
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [UIView new];
}

//footer-hegiht
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}

//footer-section
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [UIView new];
}


//sections-tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 10;
}
//rows-section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}
//cell-height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}

//cell-tableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"identifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = @"测试";
    return cell;
    
}
//select-tableview
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self.navigationController pushViewController:[[ProductListViewController alloc]init] animated:YES];
    
}

@end
