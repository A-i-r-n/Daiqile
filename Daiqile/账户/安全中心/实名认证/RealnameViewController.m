//
//  RealnameViewController.m
//  Daiqile
//
//  Created by daiqile on 2017/2/14.
//  Copyright © 2017年 com.daiqile.daiqile. All rights reserved.
//

#import "RealnameViewController.h"

@interface RealnameViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *realname;//姓名
@property (strong, nonatomic) IBOutlet UITextField *idCard;//身份证号

@end

@implementation RealnameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.title = @"实名认证";
    
    
    
}

//实名认证
- (IBAction)goAutho:(id)sender
{
    UIButton *button = (UIButton *)sender;
    
    if ([_realname.text isEqualToString:@""] || [_idCard.text isEqualToString:@""]) {
        
        [LCProgressHUD showMessage:@"姓名或身份证号不可为空!"];
        
    }else if (_idCard.text.length != 18 ){
        
        [LCProgressHUD showMessage:@"您输入的身份证号不是18位!"];
        
    }else if (![ToolModel validateIdentityCard:_idCard.text]){
        
        [LCProgressHUD showMessage:@"请输入正确的身份证号!"];
        
    }else{
        
        NSDictionary *parameters=@{@"realname":_realname.text,@"card_id":_idCard.text,@"user_id":UserDefaultGetValue(@"userId")};
        
        [HttpManager sendPostRequestWithDictionary:parameters withUrl:@"port/checkuser.php" Success:^(NSDictionary *responseData) {
            
            NSString *status = [responseData objectForKey:@"status"];
            
            if ([status isEqualToString:@"1"]) {
                
                [LCProgressHUD showMessage:@"提交成功,请等待审核!"];
                
                button.backgroundColor = [UIColor lightGrayColor];
                
                button.enabled = NO;
                
                POPViewController;
                
            }else if ([status isEqualToString:@"2"]){
                
                [LCProgressHUD showMessage:@"正在审核,请耐心等待!"];
                
                button.backgroundColor = [UIColor lightGrayColor];
                
                button.enabled = NO;
                
                POPViewController;
                
            }else if ([status isEqualToString:@"3"]){
                
                [LCProgressHUD showMessage:@"您已经实名认证啦!"];
                
                button.backgroundColor = [UIColor lightGrayColor];
                
                button.enabled = NO;
                
                POPViewController;
                
            }else if ([status isEqualToString:@"4"]){
                
                [LCProgressHUD showMessage:@"正在审核,请不要重复提交!"];
                
                button.backgroundColor = [UIColor lightGrayColor];
                
                button.enabled = NO;
                
                POPViewController;
                
            }else if ([status isEqualToString:@"0"]){
                
                [LCProgressHUD showMessage:@"提交错误,请重新填写提交!"];
                
            }else if ([status isEqualToString:@"-2"]){
                
                [LCProgressHUD showMessage:@"身份证号码格式不正确!"];
                
            }else if ([status isEqualToString:@"-1"]){
                
                [LCProgressHUD showMessage:@"输入有误,请重新填写提交!"];
                
            }else if ([status isEqualToString:@"-3"]){
                
                [LCProgressHUD showMessage:@"该身份证号已被实名注册,请更换一个再试!"];
                
            }else{
                
                [LCProgressHUD showMessage:@"实名认证失败,请联系管理员!"];
                
            }
            
        } Failed:^(NSError *error) {
            
            [LCProgressHUD showMessage:@"网络请求出错,请联系管理员!"];
            
        }];
        
    }
    
}

//点击空白处回收键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

//点击return回收键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    textField.enabled = NO;
    
    return YES;
}

@end
