
//
//  RegistViewController.m
//  Daiqile
//
//  Created by daiqile on 2016/11/16.
//  Copyright © 2016年 com.daiqile.daiqile. All rights reserved.
//

#import "RegistViewController.h"
#import "AirTextField.h"
#import "LogoView.h"
#import "LoginViewController.h"

@interface RegistViewController ()
@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet AirTextField *userName;
@property (strong, nonatomic) IBOutlet AirTextField *password;
@property (strong, nonatomic) IBOutlet AirTextField *code;
- (IBAction)getCode:(id)sender;
- (IBAction)regist:(id)sender;
- (IBAction)goLogin:(id)sender;

@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"注册";
    [self createLogoView];
}

//创建logo头
- (void)createLogoView
{
    LogoView *logoView = [[LogoView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    [_bgView addSubview:logoView];
}

//获取验证码
- (IBAction)getCode:(id)sender
{
    
}

//确认注册
- (IBAction)regist:(id)sender
{
    
}

//去登录
- (IBAction)goLogin:(id)sender
{
    LoginViewController *login = [[LoginViewController alloc]init];
    PUSH(login);
}
@end
