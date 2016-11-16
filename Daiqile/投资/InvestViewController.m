
//
//  InvestViewController.m
//  Daiqile
//
//  Created by daiqile on 2016/11/14.
//  Copyright © 2016年 com.daiqile.daiqile. All rights reserved.
//

#import "InvestViewController.h"

#import "InvestTableViewCell.h"

@interface InvestViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation InvestViewController

//- (UITableView *)tableView
//{
//    if (!_tableView) {
//        
//    }
//    return _tableView;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor clearColor];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    _tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"all_bg"]];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    
    self.navigationItem.title = @"投资";
    [self.view addSubview:_tableView];
    [self registCell];
    
}

- (void)registCell
{
    [_tableView registerNib:[UINib nibWithNibName:@"InvestTableViewCell" bundle:nil] forCellReuseIdentifier:@"investCell"];
}

#pragma mark tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Ratio(120);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InvestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"investCell"];
    //设置隐藏
    if (indexPath.section == 0) {
        cell.progress.hidden = YES;
        cell.littleImg.hidden = YES;
    }else{
        cell.complateImg.hidden = YES;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


@end
