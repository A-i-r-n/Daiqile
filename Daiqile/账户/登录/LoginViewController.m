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
#import "AirTextField.h"
#import "MainViewController.h"
@interface LoginViewController ()
{
    NSDictionary *_params;
}
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UIButton *saveBtn;//保存密码按钮
@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (nonatomic,assign) BOOL          isRemenber;//是否记住密码
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
    
    [self readUserInfo];
    
}

//读取用户名密码
- (void)readUserInfo
{
    //读取用户名密码
    NSUserDefaults *userDefaultsInfo = [NSUserDefaults standardUserDefaults];
    
    NSString *state = [userDefaultsInfo stringForKey:@"rememberstate"];
    if ([state isEqualToString:@"1"]) {
        _userName.text = [userDefaultsInfo stringForKey:@"userName"];
        _password.text = [userDefaultsInfo stringForKey:@"logPassword"];
        
        _isRemenber = YES;
         [_saveBtn setImage:[UIImage imageNamed:@"btn_check_box_on.png"] forState:UIControlStateNormal];
        
//        _loginBtn.enabled = YES;
//        _loginBtn.backgroundColor = TABCOLOR;
        
    }else{
        _userName.text = @"";
        _password.text = @"";
        _isRemenber = NO;
        
        [_saveBtn setImage:[UIImage imageNamed:@"btn_check_box_off.png"] forState:UIControlStateNormal];
    }
    

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
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
   //判断是否记住密码
    if (_isRemenber == NO) {
        
        [userDefault setObject:@"0" forKey:@"rememberstate"];
        
        [userDefault synchronize];
        
    }else{
        
        [userDefault setObject:@"1" forKey:@"rememberstate"];
        
        [userDefault setObject:_userName.text forKey:@"userName"];
        
        [userDefault setObject:_password.text forKey:@"logPassword"];
        
        [userDefault synchronize];
    }
    
    _params = @{@"username":_userName.text,@"password": _password.text};
    [HttpManager sendPostRequestWithDictionary:_params withUrl:@"port/login.php" Success:^(NSDictionary *responseData) {
        
        NSString *status = [responseData objectForKey:@"status"];
        
        //记录登录状态
        [userDefault setObject:status forKey:@"loginStatus"];
        
        //用户字典
        NSDictionary *userDict = [responseData objectForKey:@"user"];
        
        //保存用户信息
        [userDefault setObject:[userDict objectForKey:@"id"] forKey:@"userId"];
        
         [userDefault setObject:[userDict objectForKey:@"username"] forKey:@"userName"];
        
        [userDefault setObject:[userDict objectForKey:@"t_status"] forKey:@"t_status"];
        
        [userDefault synchronize];
        
        
        
        if ([status isEqualToString:@"1"]) {
            
            [LCProgressHUD showMessage:@"登录成功"];
            
            POPViewController;
            
        }else if ([status isEqualToString:@"-2"]){
            
            [LCProgressHUD showMessage:@"用户名或密码错误!"];

        }else{
            
            [LCProgressHUD showMessage:@"登录错误!"];
            
        }
        
    } Failed:^(NSError *error) {
        
       [LCProgressHUD showMessage:@"网络请求出错,请联系管理员!"];
        
    }];
    
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

//记住密码
- (IBAction)rememberBtn:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //是否记住密码
    if (!_isRemenber) {
        
        [btn setImage:[UIImage imageNamed:@"btn_check_box_on.png"] forState:UIControlStateNormal];
        _isRemenber = YES;
        
        NSString *state = @"1";
        [userDefaults setObject:state forKey:@"rememberstate"];
        [userDefaults synchronize];
    }else{
        
        [btn setImage:[UIImage imageNamed:@"btn_check_box_off.png"] forState:UIControlStateNormal];
        
        _isRemenber = NO;
        NSString *state = @"0";
        [userDefaults setObject:state forKey:@"rememberstate"];
        [userDefaults synchronize];
    }

}

//点击空白处回收键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}





@end
