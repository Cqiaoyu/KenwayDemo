//
//  ViewController.m
//  RoundTable
//
//  Created by Kenway on 2017/4/17.
//  Copyright © 2017年 Kenway. All rights reserved.
//

#import "ViewController.h"
#import "RoundTableView.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutViewInit];
}

- (void)layoutViewInit{
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    RoundTableView *roundTable = [[RoundTableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    roundTable.delegate = self;
    roundTable.dataSource = self;
    [roundTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    roundTable.backgroundColor = [UIColor clearColor];
    [self.view addSubview:roundTable];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = [UIColor clearColor];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [@(indexPath.row) stringValue];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView willDisplayRoundCell:cell atIndexPath:indexPath];
}


@end
