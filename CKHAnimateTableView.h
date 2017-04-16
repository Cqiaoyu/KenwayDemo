//
//  CKHAnimateTableView.h
//  FallTableViewSampleDemo
//
//  Created by cenkh on 14-7-19.
//  Copyright (c) 2014年 cenkh. All rights reserved.
//
/**
 *  带动画加载的TableView
 *  @note
 *      动画类型有6种可用，3D的不可用
 *
 *  @author ckh
 *  @date 2014/07/19
 */


#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

#define SPRING_DISTANCE 2
#define SPRING_ANGLE    30*M_PI/180
typedef NS_ENUM(NSInteger, CKHAnimateTableViewType) {
    //线性
    CKHAnimateTableViewTypeLeft = 0,
    CKHAnimateTableViewTypeRight,
    CKHAnimateTableViewTypeTop,
    CKHAnimateTableViewTypeBottom,
    //z旋转2D
    CKHAnimateTableViewTypeRotaFromLeft,
    CKHAnimateTableViewTypeRotaFromRight,
    //坐标轴旋转3D<不起作用>
    CKHAnimateTableViewTypeRotaByYFromLeft,
    CKHAnimateTableViewTypeRotaByYFromRight
};

@interface CKHAnimateTableView : UITableView
/**
 *  在指定动画类型下开始加载cell的动画
 *
 *  @param animateType 动画类型
 */
-(void)beginAnimateWithType:(CKHAnimateTableViewType)animateType;
/**
 *  重力感应动画<待更新>
 */
-(void)AccAnimation;
@end
