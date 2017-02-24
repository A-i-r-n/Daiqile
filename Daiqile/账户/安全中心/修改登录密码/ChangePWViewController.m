//
//  ChangePWViewController.m
//  Daiqile
//
//  Created by daiqile on 2017/2/14.
//  Copyright © 2017年 com.daiqile.daiqile. All rights reserved.
//

#import "ChangePWViewController.h"

@interface ChangePWViewController ()
@property (strong, nonatomic) IBOutlet UITextField *oldPW;//老密码
@property (strong, nonatomic) IBOutlet UITextField *pwNew;//新密码
@property (strong, nonatomic) IBOutlet UITextField *pwAgain;//确认密码

@end

@implementation ChangePWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.title = @"修改登录密码";
}

//确认修改
- (IBAction)changePW:(id)sender
{
    if ([_pwNew.text isEqualToString:_pwAgain.text]) {
        
        NSDictionary *parameters=@{@"user_id":UserDefaultGetValue(@"userId"),@"oldpassword":_oldPW.text,@"newpassword":_pwNew.text};
        
        [HttpManager sendPostRequestWithDictionary:parameters withUrl:@"port/setPassword.php" Success:^(NSDictionary *responseData) {
            
            NSString *status = responseData[@"set_status"];
            
            if ([status isEqualToString:@"-1"]) {
                
                [LCProgressHUD showMessage:@"原密码不正确!"];
                
            }else if ([status isEqualToString:@"1"]){
                
                [LCProgressHUD showMessage:@"密码修改成功,请重新登录!"];
                
                //移除登录状态
                RemoveUserDefault(@"loginStatus");
                
                //移除登录密码
                RemoveUserDefault(@"logPassword");
                
                LoginViewController *login = [[LoginViewController alloc]init];
                
                PUSH(login);
               
                
            }else{
                
                 [LCProgressHUD showMessage:@"密码修改失败!"];
                
            }
            
        } Failed:^(NSError *error) {
            
            [LCProgressHUD showMessage:@"网络请求出错,请联系管理员!"];
            
        }];
        
    }else{
        
        [LCProgressHUD showMessage:@"两次密码输入不一致,请重新输入!"];

        
    }
    
}

//点击空白处隐藏键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

//点击return隐藏键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField endEditing:YES];
    
    return YES;
}


@end
