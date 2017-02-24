
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
#import "UserDelegateViewController.h"

@interface RegistViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *passwordAgain;
@property (strong, nonatomic) IBOutlet UITextField *phone;

- (IBAction)regist:(id)sender;
- (IBAction)goLogin:(id)sender;

@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"注册";
    
    
    [self createLogoView];
}

//创建logo头
- (void)createLogoView
{
    LogoView *logoView = [[LogoView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    [_bgView addSubview:logoView];
}


//确认注册
- (IBAction)regist:(id)sender
{
    if (![_password.text isEqualToString:_passwordAgain.text]) {
        
        [HttpManager showAlertViewWithString:@"两次密码输入不一致,请重新输入!"];
        
    }else{
        
        NSDictionary *parameters=@{@"username":_userName.text,@"password":_password.text,@"phone":_phone.text};
        
        [HttpManager sendPostRequestWithDictionary:parameters withUrl:@"port/reg.php" Success:^(NSDictionary *responseData) {
        
            NSString *status = [responseData objectForKey:@"status"];
            if ([status isEqualToString:@"1"]) {
                
                
                [LCProgressHUD showMessage:@"注册成功,请登录新用户"];
                
                POPViewController;
                
            }else if ([status isEqualToString:@"-2"]){
                
                
                [LCProgressHUD showMessage:@"该手机号码已被注册!"];
                
            }else{
                
                [LCProgressHUD showMessage:@"注册失败!"];
                
            }
                
            
        } Failed:^(NSError *error) {
            
            [LCProgressHUD showMessage:@"网络请求出错,请联系管理员!"];
            
        }];
    }
    
}

//用户注册协议
- (IBAction)registDelegate:(id)sender
{
    
    UserDelegateViewController *dele = [[UserDelegateViewController alloc]init];
    
    PUSH(dele);
    
}

//去登录
- (IBAction)goLogin:(id)sender
{
    LoginViewController *login = [[LoginViewController alloc]init];
    PUSH(login);
}


//当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField endEditing:YES];
    return YES;
}


//点击空白处回收键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}




@end
