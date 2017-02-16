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
#import "AboutUsViewController.h"

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
    
    _imgArray = @[@"icon",/*@"icon_more_help",@"icon_more_state",*/@"icon_more_contact",@"icon_more_wechat"];
    
    _titleArray = @[@"平台简介",/*@"帮助中心",@"平台动态",*/@"客服热线     0571-58081198",@"邮箱地址     kefubu@juzujinfu.com"];
    
    //创建表
    [self createTableView];
    
    //注册cell
    [self registCell];

}


- (void)registCell
{
    [_tableView registerNib:[UINib nibWithNibName:@"MoreTableViewCell" bundle:nil] forCellReuseIdentifier:@"moreCell"];
}

#pragma mark tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
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
        return 100;
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
    return Ratio(60);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"moreCell"];
    
    cell.img.image = [UIImage imageNamed:_imgArray[indexPath.section]] ;
    
    cell.title.text = _titleArray[indexPath.section];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        AboutUsViewController *about = [[AboutUsViewController alloc]init];
        
        PUSH(about);
    }
    
    if (indexPath.section == 1) {
        
        //点击打电话
        [self callPhone];
    }
    
    if (indexPath.section == 2) {
        
        //拷贝邮箱
        [self copyText];
        
    }
    
}

//拷贝邮箱
- (void)copyText
{
    NSString *copyStr = @" kefubu@juzujinfu.com";
    
    UIPasteboard *copy = [UIPasteboard generalPasteboard];
    
    [copy setString:copyStr];
    
    if (copy != nil || [copyStr isEqualToString:@""] == NO){
        
        [LCProgressHUD showMessage:@"拷贝成功!"];
    
    }else{
        
        [LCProgressHUD showMessage:@"拷贝失败!"];
        
    }

}

//打电话
- (void)callPhone
{
    UIAlertController *alertControler = [UIAlertController alertControllerWithTitle:@"拨号" message:@"0571-58081198" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        
        return ;
        
    }];
    
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:0571-58081198"] options:@{} completionHandler:nil];
    }];
    
    [alertControler addAction:noAction];
    
    [alertControler addAction:yesAction];
    
    [self presentViewController:alertControler animated:YES completion:nil];

}

- (void)createTableView
{
    self.view.backgroundColor = [UIColor clearColor];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    
    //_tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"all_bg"]];
    _tableView.delegate = self;
    
    _tableView.dataSource = self;
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //_tableView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_tableView];
}


@end
