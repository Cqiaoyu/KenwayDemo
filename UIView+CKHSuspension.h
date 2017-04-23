//
//  UIView+Suspension.h
//  Suspension
//
//  Created by Kenway on 2017/4/23.
//  Copyright © 2017年 Kenway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CKHSuspension)

@property (strong, nonatomic)UIWindow *suspension;
@property (assign, nonatomic)BOOL dragEnable;
@property (assign, nonatomic)CGFloat embed;
@property (weak, nonatomic,readonly)UIViewController *currentViewController;

- (void)showSuspension;
- (void)hideSuspension;
- (void)presentViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(void))completion;
- (void)dismissViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completion;
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (void)popViewControllerAnimated:(BOOL)animated;

@end
