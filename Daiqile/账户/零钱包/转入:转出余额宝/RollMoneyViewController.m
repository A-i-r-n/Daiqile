//
//  RollMoneyViewController.m
//  Daiqile
//
//  Created by daiqile on 2017/2/15.
//  Copyright © 2017年 com.daiqile.daiqile. All rights reserved.
//

#import "RollMoneyViewController.h"

@interface RollMoneyViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *rollMoney;//转金额
@property (strong, nonatomic) IBOutlet UITextField *password;//交易密码
@property (strong, nonatomic) IBOutlet UITextField *imgCode;//图形验证码
@property (strong, nonatomic) IBOutlet UIButton *submit;//提交
@property (strong, nonatomic) IBOutlet UIButton *imgBtn;//图形码按钮

@end

@implementation RollMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"转入余额宝";
    
    [self getImgCode];
    
    [_imgBtn addTarget:self action:@selector(getImgCode) forControlEvents:UIControlEventTouchUpInside];
    
}

//获取图形验证码
- (void)getImgCode
{
     NSString *string = [ToolModel linkUrl:@"plugins/index.php?q=imgcode"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:string parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
            [_imgBtn setBackgroundImage:[UIImage imageWithData:responseObject] forState:UIControlStateNormal];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

//提交
- (IBAction)submmitClick:(id)sender
{
    if ([_imgCode.text isEqualToString:@""] || [_rollMoney.text isEqualToString:@""] || [_password.text isEqualToString:@""]) {
        
        [LCProgressHUD showMessage:@"金额,密码,图形验证码不可为空!"];
        
    }else{
        
        NSDictionary *parameters  = @{@"dcode":@"7d5372bbcd6cc79f1bd71211f092622e",@"valicode":self.imgCode.text,@"fund":self.rollMoney.text,@"paypassword":self.password.text,@"style":@"1"};
        
        [HttpManager sendPostRequestWithDictionary:parameters withUrl:[NSString stringWithFormat:@"port/fund.php?user_id=%@",UserDefaultGetValue(@"userId")] Success:^(NSDictionary *responseData) {
            
            NSString *status = responseData[@"status"];
            
            self.request(status);
            
            if ([status isEqualToString:@"1"]) {
                
                [LCProgressHUD showMessage:@"转入成功!"];
                
                POPViewController;
                
            }else if ([status isEqualToString:@"-1"]){
                
                [LCProgressHUD showMessage:@"验证码错误!"];
                
            }else if ([status isEqualToString:@"-3"]){
                
                [LCProgressHUD showMessage:@"交易密码错误!"];
                
            }else{
                
                [LCProgressHUD showMessage:@"账户可用余额不足!"];
                
            }
            
        } Failed:^(NSError *error) {
            
            [LCProgressHUD showMessage:@"网络请求出错,请联系管理员!"];
            
        }];

        
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
