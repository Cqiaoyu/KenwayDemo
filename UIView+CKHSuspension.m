//
//  UIView+Suspension.m
//  Suspension
//
//  Created by Kenway on 2017/4/23.
//  Copyright © 2017年 Kenway. All rights reserved.
//

#import "UIView+CKHSuspension.h"
#import <objc/runtime.h>

#define kYMargin 15.0
#define kEmbedMargin (self.embed/self.frame.size.width)

static void * suspensionKey = @"suspension";
static void * dragEnableKey = @"dragEnable";
static void * panGestureKey = @"panGesture";
static void * embedMarginKey = @"embedMargin";

@implementation UIView (CKHSuspension)

- (void)showSuspension{
    UIWindow *currentKeyWindow = [UIApplication sharedApplication].keyWindow;
    self.suspension = [[UIWindow alloc] initWithFrame:self.frame];
    self.suspension.windowLevel = 10000;
    self.suspension .rootViewController = [[UIViewController alloc] init];
    [self.suspension  makeKeyAndVisible];
    self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self.suspension  addSubview:self];
    [currentKeyWindow makeKeyWindow];
}
- (void)hideSuspension{
    [self setPanGesture:nil];
    self.suspension.hidden = YES;
    self.suspension.rootViewController = nil;
    self.suspension = nil;
}

- (void)drag:(UIPanGestureRecognizer *)pan{
    UIWindow *currentKeyWindow = [UIApplication sharedApplication].delegate.window;
    CGPoint currentPoint = [pan locationInView:currentKeyWindow];
    if(pan.state == UIGestureRecognizerStateBegan) {
        self.alpha = 0.5;
    }else if(pan.state == UIGestureRecognizerStateChanged) {
        self.suspension.center = CGPointMake(currentPoint.x, currentPoint.y);
    }else if(pan.state == UIGestureRecognizerStateEnded
             || pan.state == UIGestureRecognizerStateCancelled) {
        self.alpha = 1.0;
        //移动到边缘的位置计算
        CGFloat suspensionWidth = self.frame.size.width;
        CGFloat suspensionHeight = self.frame.size.height;
        CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
        CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
        
        CGFloat left = fabs(currentPoint.x);
        CGFloat right = fabs(screenWidth - left);
        CGFloat top = fabs(currentPoint.y);
        CGFloat bottom = fabs(screenHeight - top);
        
        CGFloat minSpace = MIN(MIN(MIN(top, left), bottom), right);
        CGPoint landingCenter = CGPointZero;
        CGFloat landingY = 0;
        
        if (currentPoint.y < kYMargin + suspensionHeight / 2.0) {
            landingY = kYMargin + suspensionHeight / 2.0;
        }else if (currentPoint.y > (screenHeight - suspensionHeight / 2.0 - kYMargin)) {
            landingY = screenHeight - suspensionHeight / 2.0 - kYMargin;
        }else{
            landingY = currentPoint.y;
        }
        CGFloat centerXEmbedded = (0.5 - kEmbedMargin) * suspensionWidth;
        CGFloat centerYEmbedded = (0.5 - kEmbedMargin) * suspensionHeight;
        
        if (minSpace == left) {
            landingCenter = CGPointMake(centerXEmbedded, landingY);
        }else if (minSpace == right) {
            landingCenter = CGPointMake(screenWidth - centerXEmbedded, landingY);
        }else if (minSpace == top) {
            landingCenter = CGPointMake(currentPoint.x, centerYEmbedded);
        }else {
            landingCenter = CGPointMake(currentPoint.x, screenHeight - centerYEmbedded);
        }
        [UIView animateWithDuration:0.2 animations:^{
            self.suspension.center = landingCenter;
        }];
    }else{
        
    }
}

- (void)presentViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(void))completion{
    [[self topViewController] presentViewController:viewController animated:animated completion:completion];
}
- (void)dismissViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completion{
    [[self topViewController] dismissViewControllerAnimated:animated completion:completion];
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [[self topViewController].navigationController pushViewController:viewController animated:animated];
}
- (void)popViewControllerAnimated:(BOOL)animated{
    [[self topViewController].navigationController popViewControllerAnimated:animated];
}
- (UIViewController *)topViewController {
    UIViewController *topVC;
    topVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (topVC.presentedViewController){
        topVC = [self _topViewController:topVC.presentedViewController];
    }
    return topVC;
}

- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    }else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    }else{
        return vc;
    }
    return nil;
}

#pragma mark - setter/getter -
- (void)setSuspension:(UIWindow *)suspension{
    objc_setAssociatedObject(self, suspensionKey, suspension, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIWindow *)suspension{
    UIWindow *sus = objc_getAssociatedObject(self, suspensionKey);
    return sus;
}

- (void)setDragEnable:(BOOL)dragEnable{
    NSNumber *enable = @(dragEnable);
    objc_setAssociatedObject(self, dragEnableKey, enable, OBJC_ASSOCIATION_ASSIGN);
    if (dragEnable) {
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(drag:)];
        [self setPanGesture:panGesture];
        [self addGestureRecognizer:panGesture];
    }else{
        UIPanGestureRecognizer *pan = [self panGesture];
        [self removeGestureRecognizer:pan];
        pan = nil;
        [self setPanGesture:pan];
    }
}
- (BOOL)dragEnable{
    NSNumber *enable = objc_getAssociatedObject(self, dragEnableKey);
    return [enable boolValue];
}

- (void)setPanGesture:(UIPanGestureRecognizer *)panGesture{
    panGesture.delaysTouchesBegan = YES;
    objc_setAssociatedObject(self, panGestureKey, panGesture, OBJC_ASSOCIATION_RETAIN);
}
- (UIPanGestureRecognizer *)panGesture{
    UIPanGestureRecognizer *pan = objc_getAssociatedObject(self, panGestureKey);
    return pan;
}

- (void)setEmbed:(CGFloat)embed{
    NSNumber *embedMargin = @(embed);
    objc_setAssociatedObject(self, embedMarginKey, embedMargin, OBJC_ASSOCIATION_ASSIGN);
}
- (CGFloat)embed{
    NSNumber *embedMargin = objc_getAssociatedObject(self, embedMarginKey);
    return [embedMargin floatValue];
}

- (UIViewController *)currentViewController{
    return [self topViewController];
}



@end
