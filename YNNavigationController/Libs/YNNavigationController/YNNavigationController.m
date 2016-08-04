//
//  YNNavigationController.m
//  YNNavigationController
//
//  Created by ZYN on 16/7/27.
//  Copyright © 2016年 Yongneng Zheng. All rights reserved.
//

#import "YNNavigationController.h"
#import "AppDelegate.h"


#define YN_SHOTVIEW [YNScreenShotView shareInstance]
#define __appDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define __YNScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define __YNScreenHeight ([UIScreen mainScreen].bounds.size.height)


@interface YNNavigationController ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>


@end

@implementation YNNavigationController


- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.shotViewAnimationType = ShotViewAnimationTypeSlider;
    self.hasMaskView = YES;
    self.hasShowdow = YES;
    self.onlySideGesture = NO;
    self.distanceLeft = 80;
    self.maskViewAlpha = 0.4;
    self.animationTime = 0.3;
    self.scaleViewFloat = 0.95;
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesListener:)];
    panGesture.delegate = self;
    [self.view addGestureRecognizer:panGesture];
    
}

#pragma mark - UIPanGestureRecognizerListener

- (void)panGesListener:(UIPanGestureRecognizer *)panGes{
    
    if (self.viewControllers.count == 1) return;
    UIViewController *lastViewController = [self.viewControllers lastObject];
    UIView *topView = self.view;
    
    if (lastViewController.yn_resetGestureViewController) {
        lastViewController.yn_resetGestureViewController = NO;
        Class clazz = [lastViewController yn_resetGestureViewControllerClass];
        if (clazz) {
            [self getAccurateYN_SHOTVIEW:nil class:clazz];
        }
    }
    YNScreenShotView *shotView = YN_SHOTVIEW;
    
    if (panGes.state == UIGestureRecognizerStateBegan) {
        CGPoint pt2 = [panGes translationInView:self.view];
        if (pt2.x < 0) return;
        [topView endEditing:YES];
        if (self.hasShowdow) {
            topView.layer.shadowColor = [UIColor blackColor].CGColor;
            topView.layer.shadowOffset = CGSizeMake(-4, 0);
            topView.layer.shadowOpacity = 0.3;
            
        }
    }else if(panGes.state == UIGestureRecognizerStateChanged){
        CGPoint pt = [panGes translationInView:self.view];
        if (pt.x >= 10) {
            topView.transform = CGAffineTransformMakeTranslation(pt.x - 10, 0);
            
            shotView.maskView.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:-pt.x / __YNScreenWidth * 0.4 + self.maskViewAlpha];
            
            if (self.shotViewAnimationType == ShotViewAnimationTypeScale) {
                shotView.imgView.transform = CGAffineTransformMakeScale(self.scaleViewFloat + (pt.x / __YNScreenWidth * 0.05), 0.95 + (pt.x / __YNScreenWidth * 0.05));
            }else{
                shotView.imgView.transform = CGAffineTransformMakeTranslation(pt.x *0.5-__YNScreenWidth/2 , 0);
            }
        }
    }
    else if (panGes.state == UIGestureRecognizerStateEnded){
        CGPoint pt = [panGes translationInView:self.view];
        if (pt.x >= self.distanceLeft) {
            
            [UIView animateWithDuration:self.animationTime animations:^{
                topView.transform = CGAffineTransformMakeTranslation(__YNScreenWidth, 0);
                shotView.imgView.transform = CGAffineTransformMakeTranslation(0 , 0);
                shotView.maskView.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0];
                
            } completion:^(BOOL finished) {
                if (lastViewController.yn_resetGestureViewControllerClass) {
                    UIViewController *targetVc = nil;
                    for (UIViewController *tempVC in self.viewControllers) {
                        if ([tempVC isKindOfClass:lastViewController.yn_resetGestureViewControllerClass]) {
                            targetVc = tempVC;
                        }
                    }
                    if (targetVc) {
                        [self popToViewController:targetVc animated:NO];
                    }else{
                        [self popViewControllerAnimated:NO];
                    }
                }else{
                    [self popViewControllerAnimated:NO];
                }
                topView.transform = CGAffineTransformIdentity;
                if (self.hasShowdow) {
                    topView.layer.shadowOpacity = 0;
                }
            }];
            
        }else{
            [UIView animateWithDuration:self.animationTime animations:^{
                shotView.maskView.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:self.maskViewAlpha];
                topView.transform = CGAffineTransformIdentity;
                if (self.shotViewAnimationType == ShotViewAnimationTypeScale) {
                    shotView.imgView.transform = CGAffineTransformMakeScale(self.scaleViewFloat,self.scaleViewFloat);
                }else{
                    shotView.imgView.transform = CGAffineTransformMakeTranslation(-200, 0);
                }
                
            } completion:^(BOOL finished) {
                shotView.imgView.transform = CGAffineTransformIdentity;
                if (self.hasShowdow) {
                    topView.layer.shadowOpacity = 0;
                }
                
            }];
        }
    }
};

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if ([otherGestureRecognizer isKindOfClass:NSClassFromString(@"UIScrollViewPanGestureRecognizer")] || [otherGestureRecognizer isKindOfClass:NSClassFromString(@"UIPanGestureRecognizer")] ||
        [otherGestureRecognizer isKindOfClass:NSClassFromString(@"UITableViewWrapperView")])
    {
        return NO;
    }
    
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    if ([otherGestureRecognizer.view isKindOfClass:NSClassFromString(@"UITableViewWrapperView")] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        return YES;
    }
    return NO;
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    UIViewController *viewController = [self.viewControllers lastObject];
    if (viewController.yn_banRightSliderGesture) return NO;
    
    if (self.onlySideGesture) {
        CGPoint currentPoint = [gestureRecognizer locationInView:gestureRecognizer.view];
        if (currentPoint.x> 30) {
            return NO;
        }
    }
    
    return YES;
    
}

#pragma mark - setter

- (void)setHasMaskView:(BOOL)hasMaskView{
    
    _hasMaskView = hasMaskView;
    
    YN_SHOTVIEW.maskView.hidden = !hasMaskView;
}

#pragma mark - Publick Method

- (void)yn_popViewController
{
    [self popAnimationWithPopViewControllerType:PopViewControllerTypeLastViewController toViewController:nil completionBlock:nil animated:NO];
}

- (void)yn_popToViewController:(UIViewController *)viewController completionBlock:(AnimationCompletion)animationCompletion{
    
    [self popAnimationWithPopViewControllerType:PopViewControllerTypeToViewController toViewController:viewController completionBlock:animationCompletion animated:NO];
    
}

- (void)yn_popToRootViewControllerWithCompletionBlock:(AnimationCompletion)animationCompletion{
    
    [self popAnimationWithPopViewControllerType:PopViewControllerTypeRootViewController toViewController:nil completionBlock:animationCompletion animated:NO];
}


#pragma mark - 全屏Pop
- (void)popAnimationWithPopViewControllerType:(PopViewControllerType)type toViewController:(UIViewController *)toViewController completionBlock:(AnimationCompletion)animationCompletion animated:(BOOL)animated{
    
    if (animated) {
        if (type == PopViewControllerTypeRootViewController) {
            NSArray *array = [self popToRootViewControllerAnimated:YES];
            if (animationCompletion) {
                animationCompletion(array);
            }
        }else if (type == PopViewControllerTypeToViewController)
        {
            NSArray *array = [self popToViewController:toViewController animated:YES];
            if (animationCompletion) {
                animationCompletion(array);
            }
        }else if (type == PopViewControllerTypeLastViewController){
            [self popViewControllerAnimated:YES];
        }
        return;
    }
    
    UIView *topView = self.view;
    
    switch (type) {
        case PopViewControllerTypeToViewController:
            [self getAccurateYN_SHOTVIEW:toViewController class:nil];
            break;
        case PopViewControllerTypeRootViewController:
            [self getAccurateYN_SHOTVIEW:self.viewControllers[0] class:nil];
            break;
        default:
            break;
    }
    
    if (self.shotViewAnimationType == ShotViewAnimationTypeScale) {
        YN_SHOTVIEW.imgView.transform = CGAffineTransformMakeScale(self.scaleViewFloat, self.scaleViewFloat);
    }else{
        YN_SHOTVIEW.imgView.transform = CGAffineTransformMakeTranslation(-200, 0);
        
    }
    YN_SHOTVIEW.maskView.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:self.maskViewAlpha];
    [UIView animateWithDuration:self.animationTime animations:^{
       
        if (self.shotViewAnimationType == ShotViewAnimationTypeScale) {
            YN_SHOTVIEW.imgView.transform = CGAffineTransformMakeScale(1.0 , 1.0);
        }else{
            
            YN_SHOTVIEW.imgView.transform = CGAffineTransformIdentity;
        }
        
        topView.transform = CGAffineTransformMakeTranslation(__YNScreenWidth, 0);
        
        YN_SHOTVIEW.maskView.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0.0];
    } completion:^(BOOL finished) {

        topView.transform = CGAffineTransformMakeTranslation(0, 0);
        
        if (type == PopViewControllerTypeRootViewController) {
           NSArray *array = [self popToRootViewControllerAnimated:NO];
            if (animationCompletion) {
                animationCompletion(array);
            }
        }else if (type == PopViewControllerTypeToViewController)
        {
            NSArray *array = [self popToViewController:toViewController animated:NO];
            if (animationCompletion) {
                animationCompletion(array);
            }
        }else if (type == PopViewControllerTypeLastViewController){
             [self popViewControllerAnimated:NO];
        }
    }];
}


#pragma mark - 拦截push

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.viewControllers.count == 0) {
        [super pushViewController:viewController animated:animated];
        return;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        UIImage *cropImage = [self interaceptionImage];
        
        [YN_SHOTVIEW.arrayScreenShots addObject:cropImage];
        
        YN_SHOTVIEW.imgView.image = cropImage;
        
        [self pushAnimationWithViewController:viewController isFullPush:YES];
        
    });
}


#pragma mark - 全屏PUSH

- (void)pushAnimationWithViewController:(UIViewController *)viewController isFullPush:(BOOL)isFullPush{
    
    [super pushViewController:viewController animated:!isFullPush];
    if (isFullPush) {
        
        UIView *topView = self.view;
        YN_SHOTVIEW.imgView.transform = CGAffineTransformMakeScale(1, 1);
        YN_SHOTVIEW.maskView.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0];
        
        topView.transform = CGAffineTransformMakeTranslation(__YNScreenWidth, 0);
        
        [UIView animateWithDuration:self.animationTime animations:^{
            if (self.shotViewAnimationType == ShotViewAnimationTypeScale) {
                YN_SHOTVIEW.imgView.transform = CGAffineTransformMakeScale(self.scaleViewFloat, self.scaleViewFloat);
            }else{
                YN_SHOTVIEW.imgView.transform = CGAffineTransformMakeTranslation(-__YNScreenWidth/2 , 0);
            }
            topView.transform = CGAffineTransformMakeTranslation(0, 0);
            
            YN_SHOTVIEW.maskView.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:self.maskViewAlpha];
            
        } completion:^(BOOL finished) {
            
            YN_SHOTVIEW.imgView.transform = CGAffineTransformIdentity;
            
        }];
    }
}

#pragma mark - Private Method


- (void)getAccurateYN_SHOTVIEW:(UIViewController *)viewController class:(Class)clazz{
    
    for (NSInteger i = 0; i < self.viewControllers.count; i ++) {
        UIViewController *currentViewController = self.viewControllers[i];
        if ([currentViewController isKindOfClass:[viewController class]] || [currentViewController isKindOfClass:clazz]) {
            UIImage *image = YN_SHOTVIEW.arrayScreenShots[i];
            
                if (image) {
                    YN_SHOTVIEW.imgView.image = image;
                }
                break;
        }
    }
};


#pragma mark - CropImage

- (UIImage *)interaceptionImage{
    
    UIWindow *screenWindow = [[UIApplication sharedApplication] keyWindow];
    UIGraphicsBeginImageContextWithOptions(screenWindow.frame.size, YES, 0.0); // no retina
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    for (UIWindow *window in [[UIApplication sharedApplication] windows]) {
        
        if(window == screenWindow)
        {
            break;
        }else{
            [window.layer renderInContext:context];
        }
    }
    
    if ([screenWindow respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        [screenWindow drawViewHierarchyInRect:screenWindow.bounds afterScreenUpdates:NO];
    } else {
        [screenWindow.layer renderInContext:context];
    }
    CGContextRestoreGState(context);
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    screenWindow.layer.contents = nil;
    UIGraphicsEndImageContext();
    return viewImage;
}

#pragma mark - 拦截pop

- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
    [YN_SHOTVIEW.arrayScreenShots removeLastObject];
    UIImage *image = [YN_SHOTVIEW.arrayScreenShots lastObject];
    
    if (image) {
        YN_SHOTVIEW.imgView.image = image;
    }
    
    return [super popViewControllerAnimated:animated];

}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated{

    [YN_SHOTVIEW.arrayScreenShots removeAllObjects];
    YN_SHOTVIEW.imgView.image = nil;
    
    return [super popToRootViewControllerAnimated:animated];
    
}


- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated{

    NSArray *arr = [super popToViewController:viewController animated:animated];
    
    if (YN_SHOTVIEW.arrayScreenShots.count > arr.count)
    {
        for (int i = 0; i < arr.count; i++) {
            [YN_SHOTVIEW.arrayScreenShots removeLastObject];
        }
    }
    UIImage *image = [YN_SHOTVIEW.arrayScreenShots lastObject];
    if (image)
        YN_SHOTVIEW.imgView.image = image;
    
    return arr;
    
}

@end

