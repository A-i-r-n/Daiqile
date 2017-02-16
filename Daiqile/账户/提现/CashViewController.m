//
//  CashViewController.m
//  Daiqile
//
//  Created by daiqile on 2017/2/10.
//  Copyright © 2017年 com.daiqile.daiqile. All rights reserved.
//

#import "CashViewController.h"

@interface CashViewController ()<UITextFieldDelegate>

{
    NSString *_select_id;
}

@property (strong, nonatomic) IBOutlet UITextField *money;//提现金额
@property (strong, nonatomic) IBOutlet UITextField *password;//提现密码
@property (strong, nonatomic) IBOutlet UILabel *explain;//说明

@end

@implementation CashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.title = @"提现";
    
    _explain.text = @"温馨提醒:\n    为保证手机用户同卡进出,以往在电脑端绑定的银行卡不算在手机上提现时到帐的银行卡;\n    所以未在手机上充值成功的用户请先充值,系统将自动为您绑定银行卡。";
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //获取绑定的银行卡
    [self sendHttpRequest];
    
}

- (void)sendHttpRequest
{

    [HttpManager sendPostGetArrayWithDictionary:@{@"user_id":UserDefaultGetValue(@"userId")} withUrl:@"port/getUserBanks.php" Success:^(NSArray *responseData) {
        
        if (responseData.count != 0) {
            
            //只允许用户绑定一张银行卡,故银行卡的数组为1;
            //_select_id 记录绑定银行卡的id
            _select_id = [[responseData firstObject] objectForKey:@"id"];
            
        }else{
            
            [LCProgressHUD showMessage:@"为保证同卡进出,请先充值,系统将自动为您绑定银行卡!"];
            
        }
        
    } Failed:^(NSError *error) {
        
        [LCProgressHUD showMessage:@"网络请求出错,请联系管理员!"];
        
    }];
}

//确认提现
- (IBAction)getMoney:(id)sender
{
    NSDictionary *parameters=@{@"money":_money.text,@"user_id": UserDefaultGetValue(@"userId"),@"dcode":@"7d5372bbcd6cc79f1bd71211f092622e",@"paypassword":_password.text,@"select_id":_select_id};
    
    [HttpManager sendPostRequestWithDictionary:parameters withUrl:@"port/cashNew1.php" Success:^(NSDictionary *responseData) {
        
        NSString *cashStatus = [responseData objectForKey:@"cash_status"];
        
        if ([cashStatus isEqualToString:@"1"]) {
            
            [LCProgressHUD showMessage:@"提现成功,请等待审核!"];
            
            POPViewController;
            
        }else if ([cashStatus isEqualToString:@"0"]){
            
            [LCProgressHUD showMessage:@"您的可用余额不足!"];
            
        }else if ([cashStatus isEqualToString:@"-1"]){
            
            [LCProgressHUD showMessage:@"为保证同卡进出,请先充值,系统将自动为您绑定银行卡!"];
            
        }else if ([cashStatus isEqualToString:@"-2"]){
            
            [LCProgressHUD showMessage:@"金额有误!"];
            
        }else if ([cashStatus isEqualToString:@"-3"]){
            
            [LCProgressHUD showMessage:@"提现密码错误,请重新输入!"];
            
        }else{
            
            [LCProgressHUD showMessage:@"未知错误,请联系客服!"];
            
        }
        
    } Failed:^(NSError *error) {
        
        [LCProgressHUD showMessage:@"网络请求出错,请联系管理员!"];
        
    }];
    
}

//点击空白处结束编辑状态
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

//点击回车,结束编辑状态
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField endEditing:YES];
    
    return YES;
}


@end
