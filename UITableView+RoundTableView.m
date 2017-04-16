//
//  UITableView+RoundTableView.m
//  RoundTable
//
//  Created by Kenway on 2017/4/17.
//  Copyright © 2017年 Kenway. All rights reserved.
//

#import "UITableView+RoundTableView.h"

@implementation UITableView (RoundTableView)
- (void)visiableRoundCell{
    NSArray *indexPaths = [self indexPathsForVisibleRows];
    for (int i = 0; i < [indexPaths count]; i++) {
        NSIndexPath *indexPath = [indexPaths objectAtIndex:i];
        NSInteger sumRow = [self numberOfRowsInSection:indexPath.section];
        UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
        cell.hidden = YES;
        CGPoint orgCenter = cell.center;
        CGFloat orgWidth = cell.frame.size.width;
        CGFloat orgHeight = cell.frame.size.height;
        CGRect resetFrame = CGRectMake(0, 0, orgWidth - 30, orgHeight);
        cell.frame = resetFrame;
        cell.center = orgCenter;
        if (indexPath.row == 0 || indexPath.row == sumRow - 1) {
            cell.layer.cornerRadius = 5;
        }else{
            cell.layer.cornerRadius = 0;
        }
        cell.hidden = NO;
    }
}
- (void)willDisplayRoundCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    NSInteger sumRow = [self numberOfRowsInSection:indexPath.section];
    cell.hidden = YES;
    CGPoint orgCenter = cell.center;
    CGFloat orgWidth = cell.frame.size.width;
    CGFloat orgHeight = cell.frame.size.height;
    CGRect resetFrame = CGRectMake(0, 0, orgWidth - 30, orgHeight);
    cell.frame = resetFrame;
    cell.center = orgCenter;
    if (indexPath.row == 0 || indexPath.row == sumRow - 1) {
        cell.layer.cornerRadius = 5;
    }else{
        cell.layer.cornerRadius = 0;
    }
    
    cell.hidden = NO;
}

@end
