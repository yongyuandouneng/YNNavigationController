//
//  YNScreenShotView.m
//  YNNavigationController
//
//  Created by ZYN on 16/8/4.
//  Copyright © 2016年 Yongneng Zheng. All rights reserved.
//

#import "YNScreenShotView.h"

@implementation YNScreenShotView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.imgView = [[UIImageView alloc]initWithFrame:self.bounds];
        self.maskView = [[UIView alloc]initWithFrame:self.bounds];
        self.maskView.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0.4];
        
        [self addSubview:self.imgView];
        [self addSubview:self.maskView];
    }
    return self;
}

+ (instancetype)shareInstance{
    static YNScreenShotView *__instance;
    static dispatch_once_t onceToken;
    if (![[UIApplication sharedApplication] delegate].window) return nil;
    dispatch_once(&onceToken, ^{
        __instance = [[YNScreenShotView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        __instance.arrayScreenShots = [NSMutableArray array];
        [[[UIApplication sharedApplication] delegate].window insertSubview:__instance atIndex:0];
        
    });
    return __instance;
    
}

@end
