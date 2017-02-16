
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
                
                [HttpManager showAlertViewWithString:@"注册成功,请登录新用户"];
                
                POPViewController;
                
            }else if ([status isEqualToString:@"-2"]){
                
                [HttpManager showAlertViewWithString:@"该手机号码已被注册!"];
                
            }else{
                
                [HttpManager showAlertViewWithString:@"注册失败!"];
                
            }
                
            
        } Failed:^(NSError *error) {
            
            [HttpManager showAlertViewWithString:@"网络请求出错,请联系管理员!"];
            
        }];
    }
    
}

//去登录
- (IBAction)goLogin:(id)sender
{
    LoginViewController *login = [[LoginViewController alloc]init];
    PUSH(login);
}

//开始编辑输入框的时候，软键盘出现，执行此事件
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 40 - (self.view.frame.size.height - 216.0-30);//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    NSLog(@"----offset==%d---%f",offset,frame.origin.y + 40);
    if(offset > 0)
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
}
//当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField endEditing:YES];
    return YES;
}

//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}
//点击空白处回收键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}




@end
