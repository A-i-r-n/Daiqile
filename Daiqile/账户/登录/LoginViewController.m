//
//  LoginViewController.m
//  Daiqile
//
//  Created by daiqile on 2016/11/16.
//  Copyright © 2016年 com.daiqile.daiqile. All rights reserved.
//

#import "LoginViewController.h"
#import "LogoView.h"
#import "RegistViewController.h"

@interface LoginViewController ()
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UIView *bgView;
- (IBAction)LoginClick:(id)sender;
- (IBAction)goRegist:(id)sender;
- (IBAction)forgetPassWord:(id)sender;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"登录";
    
    [self createLogoView];
  
    
}

//创建logo头
- (void)createLogoView
{
    LogoView *logoView = [[LogoView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    [_bgView addSubview:logoView];
}

//确认登录
- (IBAction)LoginClick:(id)sender
{
    
}

//去注册
- (IBAction)goRegist:(id)sender
{
    RegistViewController *regist = [[RegistViewController alloc]init];
    PUSH(regist);
}

//忘记密码
- (IBAction)forgetPassWord:(id)sender
{
    
}
@end
