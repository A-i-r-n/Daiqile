//
//  SetPayPWViewController.m
//  Daiqile
//
//  Created by daiqile on 2017/2/22.
//  Copyright © 2017年 com.daiqile.daiqile. All rights reserved.
//

#import "SetPayPWViewController.h"

@interface SetPayPWViewController ()
@property (weak, nonatomic) IBOutlet UITextField *oldPayPw;//原密码

@property (weak, nonatomic) IBOutlet UITextField *payPwNew;//新密码

@property (weak, nonatomic) IBOutlet UITextField *verifyPw;//确认密码

@end

@implementation SetPayPWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"设置交易密码";
    
    
}

//设置交易密码
- (IBAction)setPayPW:(id)sender
{
    if ([_payPwNew.text isEqualToString:@""] || [_oldPayPw.text isEqualToString:@""] ||[_verifyPw.text isEqualToString:@""]) {
        
        [LCProgressHUD showMessage:@"密码不可为空!"];
        
    }else if (![_payPwNew.text isEqualToString:_verifyPw.text]){
        
        [LCProgressHUD showMessage:@"两次输入的新密码不一致!"];
        
    }else{
        
        NSDictionary *params = @{@"user_id":UserDefaultGetValue(@"userId"),@"oldpassword":_oldPayPw.text,@"newpassword":_payPwNew.text,@"dcode":@""};
        
        [HttpManager sendPostRequestWithDictionary:params withUrl:@"prot/setPayPassword.php" Success:^(NSDictionary *responseData) {
            
            NSString *status = responseData[@"set_status"];
            
            if ([status isEqualToString:@"1"]) {
                
                [LCProgressHUD showMessage:@"修改成功!"];
                
            }else if ([status isEqualToString:@"-1"]){
                
                [LCProgressHUD showMessage:@"原密码错误!"];
                
            }else{
                
                [LCProgressHUD showMessage:@"修改失败!"];
                
            }
            
        } Failed:^(NSError *error) {
            
            NSLog(@"error");
            
        }];

        
    }
    
    }


@end
