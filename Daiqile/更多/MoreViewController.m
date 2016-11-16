//
//  MoreViewController.m
//  Daiqile
//
//  Created by daiqile on 2016/11/14.
//  Copyright © 2016年 com.daiqile.daiqile. All rights reserved.
//

#import "MoreViewController.h"
#import "MoreTableViewCell.h"

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
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
        view.backgroundColor = [UIColor clearColor];
        
        UIImageView *img = [[UIImageView alloc]init];
        img.image = [UIImage imageNamed:@"logo"];
        
        [view addSubview:img];
        
        UILabel *design = [[UILabel alloc]init];
        design.text = @"安全,透明,便捷,值得投资";
        design.textColor = GoldColor;
        [view addSubview:design];
        
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(10);
            make.centerX.equalTo(view.mas_centerX);
            make.width.offset(60);
            make.height.offset(60);
        }];
        
        [design mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(img.mas_bottom).offset(5);
            make.centerX.equalTo(img.mas_centerX);
        }];
        
        return view;
    }
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"moreCell"];
    if (indexPath.section > 2) {
        cell.nextImg.hidden = YES;
    }
    cell.img.image = [UIImage imageNamed:_imgArray[indexPath.section]] ;
    cell.title.text = _titleArray[indexPath.section];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
