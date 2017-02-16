
//
//  SafityViewController.m
//  Daiqile
//
//  Created by daiqile on 2016/11/16.
//  Copyright © 2016年 com.daiqile.daiqile. All rights reserved.
//

#import "SafityViewController.h"
#import "SwitchTableViewCell.h"
#import "BehindLabTableViewCell.h"
#import "NomalTableViewCell.h"
#import "ChangePWViewController.h"
#import "ChangeGestureViewController.h"
#import "RealnameViewController.h"


@interface SafityViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    NSMutableArray *_imgArray;
    NSMutableArray *_titleArray;
    
}

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation SafityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"安全中心";
    
    _imgArray = [NSMutableArray arrayWithObjects:@[@"密码"/*,@"icon_safety_deal_pwd"*/,@"手势密码"],@[/*@"icon_safety_phone",*/@"实名认证"],nil];
    
    _titleArray = [NSMutableArray arrayWithObjects:@[@"修改登录密码"/*,@"修改支付密码"*/,@"设置手势密码"],@[/*@"手机认证",*/@"实名认证"],nil];
    
    
    [self createTableView];
    
    [self registCell];
}

- (void)createTableView
{
    self.view.backgroundColor = [UIColor clearColor];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    //_tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"all_bg"]];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //_tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
}

- (void)registCell
{
    [_tableView registerNib:[UINib nibWithNibName:@"SwitchTableViewCell" bundle:nil] forCellReuseIdentifier:@"switchCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"BehindLabTableViewCell" bundle:nil] forCellReuseIdentifier:@"behindCell"];
//     [_tableView registerNib:[UINib nibWithNibName:@"BehindLabTableViewCell" bundle:nil] forCellReuseIdentifier:@"normalCell"];
}

#pragma mark tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return 120;
    }
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 120)];
        
        view.backgroundColor = [UIColor clearColor];
        
        UIButton *quitBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, 40, ScreenWidth-60, 40)];
        
        quitBtn.backgroundColor = MainColor;
        
        [quitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        quitBtn.layer.cornerRadius = 3;
        
        [quitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        
        [quitBtn addTarget:self action:@selector(quitClick) forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:quitBtn];
        
        return view;
    }
    return nil;
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 15;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        SwitchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"switchCell"];
        //if (indexPath.row != 1) {
            
            cell.swithBtn.hidden = YES;
            
            //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //}
        
        cell.title.text = _titleArray[indexPath.section][indexPath.row];
        
        cell.img.image = [UIImage imageNamed:_imgArray[indexPath.section][indexPath.row]];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return cell;
    }
    BehindLabTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"behindCell"];
    
    cell.title.text = _titleArray[indexPath.section][indexPath.row];
    
    cell.img.image = [UIImage imageNamed:_imgArray[indexPath.section][indexPath.row]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            //修改登录密码
            ChangePWViewController *change = [[ChangePWViewController alloc]init];
            
            PUSH(change);
            
        }
        
        if (indexPath.row == 1) {
            
            //修改手势密码
            ChangeGestureViewController *gesture = [[ChangeGestureViewController alloc]init];
            
            PUSH(gesture);
            
        }
    }
    if (indexPath.section == 1) {
        
        //判断是否实名认证
        if ([self.autoStatus isEqualToString:@"3"]) {
            
            [LCProgressHUD showMessage:@"您已经实名认证啦!"];
            
        }else{
            
            RealnameViewController *real = [[RealnameViewController alloc]init];
            
            PUSH(real);
            
        }

    }
}

//退出登录
- (void)quitClick
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定要退出该账户吗?" message:nil preferredStyle:UIAlertControllerStyleAlert];
  
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //移除登录标识
        RemoveUserDefault(@"loginStatus");
        
        LoginViewController *login = [[LoginViewController alloc]init];
        
        PUSH(login);
        
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];

}

@end
