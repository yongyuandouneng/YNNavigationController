//
//  YNScreenShotView.h
//  YNNavigationController
//
//  Created by ZYN on 16/8/4.
//  Copyright © 2016年 Yongneng Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNScreenShotView : UIView

/** 图片数组*/
@property (nonatomic, strong) NSMutableArray *arrayScreenShots;
/** 容器view*/
@property (nonatomic, strong) UIImageView *imgView;
/** 蒙版*/
@property (nonatomic, strong) UIView *maskView;

+ (instancetype)shareInstance;

@end
