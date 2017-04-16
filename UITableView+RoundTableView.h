//
//  UITableView+RoundTableView.h
//  RoundTable
//
//  Created by Kenway on 2017/4/17.
//  Copyright © 2017年 Kenway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (RoundTableView)
- (void)visiableRoundCell;
- (void)willDisplayRoundCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end
