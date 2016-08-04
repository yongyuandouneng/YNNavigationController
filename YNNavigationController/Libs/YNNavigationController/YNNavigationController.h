//
//  YNNavigationController.h
//  YNNavigationController
//
//  Created by ZYN on 16/7/27.
//  Copyright © 2016年 Yongneng Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+YNNavigationViewController.h"
#import "YNScreenShotView.h"


typedef void(^AnimationCompletion)(NSArray *array);

typedef NS_ENUM(NSInteger , ShotViewAnimationType) {
    ShotViewAnimationTypeScale  = 0,//伸缩
    ShotViewAnimationTypeSlider = 1,//平滑 默认
};

typedef NS_ENUM(NSInteger , PopViewControllerType){
    
    PopViewControllerTypeLastViewController = 0,
    PopViewControllerTypeToViewController   = 1,
    PopViewControllerTypeRootViewController = 2,
    
};

@interface YNNavigationController : UINavigationController

/** 动画类型 平滑*/
@property (nonatomic, assign) ShotViewAnimationType shotViewAnimationType;

/** 是否需要遮罩 NO */
@property (nonatomic, assign) BOOL hasMaskView;

/** 是否需要阴影 YES */
@property (nonatomic, assign) BOOL hasShowdow;

/** 是否开启仅仅侧边滑动 NO */
@property (nonatomic, assign) BOOL onlySideGesture;

/** 距离左边多少就Push  80 */
@property (nonatomic, assign) CGFloat distanceLeft;

/** 蒙版的透明度 0.4 */
@property (nonatomic, assign) CGFloat maskViewAlpha;

/** 缩放程度 0.95 建议在0.9 ~ 1.0*/
@property (nonatomic, assign) CGFloat scaleViewFloat;

/** 动画Push Pop时间 0.3 */
@property (nonatomic, assign) CGFloat animationTime;

/** popViewController */
- (void)yn_popViewController;

/** popToViewController*/
- (void)yn_popToViewController:(UIViewController *)viewController completionBlock:(AnimationCompletion)animationCompletion;

/** popToRootViewControllerWithCompletion 带动画回到跟控制器，但系统会默认有tabbar动画 */
- (void)yn_popToRootViewControllerWithCompletionBlock:(AnimationCompletion)animationCompletion;

/** pop根方法*/
- (void)popAnimationWithPopViewControllerType:(PopViewControllerType)type toViewController:(UIViewController *)toViewController completionBlock:(AnimationCompletion)animationCompletion animated:(BOOL)animated;

@end










