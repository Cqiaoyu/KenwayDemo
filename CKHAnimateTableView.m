//
//  CKHAnimateTableView.m
//  FallTableViewSampleDemo
//
//  Created by cenkh on 14-7-19.
//  Copyright (c) 2014年 cenkh. All rights reserved.
//

#import "CKHAnimateTableView.h"


@implementation CKHAnimateTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        //初始化
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
-(void)beginAnimateWithType:(CKHAnimateTableViewType)animateType{
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.hidden = YES;
        [self reloadData];
    } completion:^(BOOL finished) {
        self.hidden = NO;
        [self animationWithType:animateType];
    }];
}
-(void)animationWithType:(CKHAnimateTableViewType)type{
    NSArray *indexPaths = [self indexPathsForVisibleRows];
    switch (type) {
        case CKHAnimateTableViewTypeLeft:{//-1
            for (int i = 0; i < [indexPaths count]; i++) {
                NSIndexPath *indexPath = [indexPaths objectAtIndex:i];
                UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
                cell.hidden = YES;
                NSNumber *number = [NSNumber numberWithInt:-1];
                NSArray *array = @[number,indexPath];
                [self performSelector:@selector(didAnimationHorizontalWithTarget:) withObject:array afterDelay:0.1* (i + 1)];
            }
            break;
        }
        case CKHAnimateTableViewTypeRight:{//1
            for (int i = 0; i < [indexPaths count]; i++) {
                NSIndexPath *indexPath = [indexPaths objectAtIndex:i];
                UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
                cell.hidden = YES;
                NSNumber *number = [NSNumber numberWithInt:1];
                NSArray *array = @[number,indexPath];
                [self performSelector:@selector(didAnimationHorizontalWithTarget:) withObject:array afterDelay:0.1* (i + 1)];
                
            }
            break;
        }
        case CKHAnimateTableViewTypeTop:{//-1
            for (int i = 0; i < [indexPaths count]; i++) {
                NSIndexPath *indexPath = [indexPaths objectAtIndex:i];
                UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
                cell.hidden = YES;
                NSNumber *number = [NSNumber numberWithInt:-1];
                NSArray *array = @[number,indexPath];
                [self performSelector:@selector(didAnimationVerticalWithTarget:) withObject:array afterDelay:0.1* (i + 1)];
                
            }
            break;
        }
        case CKHAnimateTableViewTypeBottom:{//1
            for (int i = 0; i < [indexPaths count]; i++) {
                NSIndexPath *indexPath = [indexPaths objectAtIndex:i];
                UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
                cell.hidden = YES;
                NSNumber *number = [NSNumber numberWithInt:1];
                NSArray *array = @[number,indexPath];
                [self performSelector:@selector(didAnimationVerticalWithTarget:) withObject:array afterDelay:0.1* (i + 1)];
                
            }
            break;
        }
        case CKHAnimateTableViewTypeRotaFromLeft:{//-1
            for (int i = 0; i < [indexPaths count]; i++) {
                NSIndexPath *indexPath = [indexPaths objectAtIndex:i];
                UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
                cell.hidden = YES;
                NSNumber *number = [NSNumber numberWithInt:-1];
                NSArray *array = @[number,indexPath];
                [self performSelector:@selector(didRotaAnimationByZWithTarget:) withObject:array afterDelay:0.1 * (i + 1)];
            }
            break;
        }
        case CKHAnimateTableViewTypeRotaFromRight:{//1
            for (int i = 0; i < [indexPaths count]; i++) {
                NSIndexPath *indexPath = [indexPaths objectAtIndex:i];
                UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
                cell.hidden = YES;
                NSNumber *number = [NSNumber numberWithInt:1];
                NSArray *array = @[number,indexPath];
                [self performSelector:@selector(didRotaAnimationByZWithTarget:) withObject:array afterDelay:0.1 * (i + 1)];
            }
            break;
        }
        case CKHAnimateTableViewTypeRotaByYFromLeft:{//-1
            for (int i = 0; i < [indexPaths count]; i++) {
                NSIndexPath *indexPath = [indexPaths objectAtIndex:i];
                UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
                cell.hidden = YES;
                NSNumber *number = [NSNumber numberWithInt:-1];
                NSArray *array = @[number,indexPath];
                [self performSelector:@selector(didRotaAnimationByYWithTarget:) withObject:array afterDelay:0.1 * (i + 1)];
            }
            break;
        }
        case CKHAnimateTableViewTypeRotaByYFromRight:{//1
            for (int i = 0; i < [indexPaths count]; i++) {
                NSIndexPath *indexPath = [indexPaths objectAtIndex:i];
                UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
                cell.hidden = YES;
                NSNumber *number = [NSNumber numberWithInt:1];
                NSArray *array = @[number,indexPath];
                [self performSelector:@selector(didRotaAnimationByYWithTarget:) withObject:array afterDelay:0.1 * (i + 1)];
            }
            break;
        }
        default:
            break;
    }
}
//水平方向的动画
-(void)didAnimationHorizontalWithTarget:(NSArray *)target{
    NSIndexPath *indexPath = [target objectAtIndex:1];
    NSInteger number = [(NSNumber *)[target objectAtIndex:0] integerValue];
    UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
    cell.hidden = NO;
    CGPoint originCenter = cell.center;
    cell.center = CGPointMake(cell.frame.size.width * number, originCenter.y);
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        cell.center = CGPointMake(originCenter.x - number * SPRING_DISTANCE, originCenter.y);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            cell.center = CGPointMake(originCenter.x + number * SPRING_DISTANCE, originCenter.y);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                cell.center = originCenter;
            } completion:nil];
        }];
    }];
}

//垂直方向的动画
-(void)didAnimationVerticalWithTarget:(NSArray *)target{
    NSIndexPath *indexPath = [target objectAtIndex:1];
    NSInteger number = [(NSNumber *)[target objectAtIndex:0] integerValue];
    UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
    cell.hidden = NO;
    CGPoint originCenter = cell.center;
    cell.center = CGPointMake(originCenter.x, self.frame.size.height * number);
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        cell.center = CGPointMake(originCenter.x, originCenter.y - number * SPRING_DISTANCE);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            cell.center = CGPointMake(originCenter.x, originCenter.y + number * SPRING_DISTANCE);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                cell.center = originCenter;
            } completion:nil];
        }];
    }];
}

//z轴旋转
-(void)didRotaAnimationByZWithTarget:(NSArray *)target{
    NSIndexPath *indexPath = [target objectAtIndex:1];
    CGFloat rotaRate = [(NSNumber *)[target objectAtIndex:0] floatValue];
    UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
    cell.hidden = NO;
    CGAffineTransform originTransform = cell.transform;
    CGAffineTransform tranform = CGAffineTransformMakeRotation(rotaRate * M_PI);
    cell.transform = tranform;
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGAffineTransform transform1 = CGAffineTransformMakeRotation(-rotaRate * SPRING_ANGLE);
        cell.transform = transform1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            CGAffineTransform transform2 = CGAffineTransformMakeRotation(rotaRate * SPRING_ANGLE);
            cell.transform = transform2;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                cell.transform = originTransform;
            } completion:nil];
        }];
    }];
}
//y轴旋转
-(void)didRotaAnimationByYWithTarget:(NSArray *)target{
    NSIndexPath *indexPath = [target objectAtIndex:1];
    NSInteger rotaRate = [(NSNumber *)[target objectAtIndex:0] integerValue];
    UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
    cell.hidden = NO;
    [cell.layer setTransform:CATransform3DMakeRotation( rotaRate * 90 * M_PI/180, 0, 1, 0)];
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [cell.layer setTransform:CATransform3DMakeRotation(-rotaRate * 20 * M_PI/180, 0, 1, 0)];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            [cell.layer setTransform:CATransform3DMakeRotation(rotaRate * 20 * M_PI/180, 0, 1, 0)];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                [cell.layer setTransform:CATransform3DMakeRotation(0, 0, 1, 0)];
            } completion:nil];
        }];
    }];
    
}

//加个加速计动画
-(void)AccAnimation{
    NSArray *indexPaths = [self indexPathsForVisibleRows];
    CMMotionManager *manager = [[CMMotionManager alloc]init];
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    if (manager.isGyroAvailable) {
        manager.gyroUpdateInterval = 1.0/10.0;
        [manager startGyroUpdatesToQueue:queue withHandler:^(CMGyroData *gyroData, NSError *error) {
            if (error) {
                [manager stopGyroUpdates];
            }
            else{
                double yValue = gyroData.rotationRate.y;
                NSLog(@"%f",yValue);
                for (int i = 0; i < [indexPaths count]; i++) {
                    NSIndexPath *indexPath = [indexPaths objectAtIndex:i];
                    UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
                    cell.layer.transform = CATransform3DMakeRotation(yValue * 90* M_PI/180, 0, 1, 0);
                }
            }
        }];
    }
}


@end
