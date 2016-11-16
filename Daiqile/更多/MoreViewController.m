//
//  MoreViewController.m
//  Daiqile
//
//  Created by daiqile on 2016/11/14.
//  Copyright © 2016年 com.daiqile.daiqile. All rights reserved.
//

#import "MoreViewController.h"
#import "MoreTableViewCell.h"
#import "LogoView.h"
#import "PlatformStateViewController.h"

@interface MoreViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    NSArray *_imgArray;
    NSArray *_titleArray;
}

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"更多";
    
    _imgArray = @[@"logo",@"icon_more_help",@"icon_more_state",@"icon_more_contact",@"icon_more_wechat"];
    _titleArray = @[@"平台简介",@"帮助中心",@"平台动态",@"客服热线  400-2000-000",@"关注微信  nbdaiqile"];
    
    [self createTableView];
    [self registCell];

}

- (void)createTableView
{
    self.view.backgroundColor = [UIColor clearColor];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    _tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"all_bg"]];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
}

- (void)registCell
{
    [_tableView registerNib:[UINib nibWithNibName:@"MoreTableViewCell" bundle:nil] forCellReuseIdentifier:@"moreCell"];
}

#pragma mark tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 120;
    }
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        LogoView *view = [[LogoView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
        return view;
    }
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Ratio(70);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"moreCell"];
    if (indexPath.section > 2) {
        cell.nextImg.hidden = YES;
    }
    cell.img.image = [UIImage imageNamed:_imgArray[indexPath.section]] ;
    cell.title.text = _titleArray[indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        PlatformStateViewController *state = [[PlatformStateViewController alloc]init];
        PUSH(state);
    }
}

@end
