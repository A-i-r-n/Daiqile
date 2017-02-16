//
//  BindCardViewController.m
//  Daiqile
//
//  Created by daiqile on 2016/11/16.
//  Copyright © 2016年 com.daiqile.daiqile. All rights reserved.
//

#import "BindCardViewController.h"
#import "BankListViewController.h"

@interface BindCardViewController ()

@property (strong, nonatomic) IBOutlet UIButton *bankName;
@property (strong, nonatomic) IBOutlet UITextField *subBankName;//支行名
@property (strong, nonatomic) IBOutlet UITextField *cardNum;//卡号
@property (strong, nonatomic) IBOutlet UIButton *submmitBtn;//提交按钮

@property(nonatomic,copy)NSString *bankId;//银行ID

@end

@implementation BindCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"绑定银行卡";
    
    //判断是否已经绑定银行卡
    [self isBindCard];
}


- (void)isBindCard
{
    [HttpManager sendPostRequestWithDictionary:@{@"user_id":UserDefaultGetValue(@"userId")} withUrl:@"port/getMobileCard3.php" Success:^(NSDictionary *responseData) {
        
        NSString *status = [responseData objectForKey:@"status"];
        
        NSDictionary *remark = [responseData objectForKey:@"remark"];
        
        //已绑卡(设置值,并设置不可点击)
        if ([status isEqualToString:@"1"]) {
            
            [_bankName setTitle:[remark objectForKey:@"bank"] forState:UIControlStateNormal];
            _bankName.enabled = NO;
            
            _subBankName.text = [remark objectForKey:@"branch"];
            _subBankName.enabled = NO;
            
            _cardNum.text = [remark objectForKey:@"account"];
            _cardNum.enabled = NO;
            
            _submmitBtn.backgroundColor = [UIColor lightGrayColor];
            _submmitBtn.enabled = NO;
            
        }
        
    } Failed:^(NSError *error) {
        
        
        [LCProgressHUD showMessage:@"网路请求错误,请联系管理员!"];
        
    }];
}


//提交(确认绑定)
- (IBAction)submit:(id)sender
{
    
    NSDictionary *parameters=@{@"user_id":UserDefaultGetValue(@"userId"),@"pay_code":self.bankName.titleLabel.text,@"acc_no":self.cardNum.text,@"branch":self.subBankName.text};
    
    [HttpManager sendPostRequestWithDictionary:parameters withUrl:@"port/webapp/Action.php" Success:^(NSDictionary *responseData) {
        
        NSString *status = [responseData objectForKey:@"status"];
        
        NSString *remark = [responseData objectForKey:@"remark"];
        
        if ([status isEqualToString:@"1"]) {
            
            [LCProgressHUD showMessage:remark];
            
        }else{
            
            [LCProgressHUD showMessage:remark];
            
        }
        
    } Failed:^(NSError *error) {
        
        [LCProgressHUD showMessage:@"网路请求出错,请联系管理员!"];
        
    }];
    
    
}

//跳转至银行卡列表
- (IBAction)goToBankList:(id)sender
{
    [self requestBankListWithStyle:1];
}


- (void)requestBankListWithStyle:(int)style
{
    BankListViewController *listVC = [BankListViewController new];
    
    listVC.selectStyle = style;
    
    listVC.bankId = self.bankId;
    
    listVC.dataBlock = ^(NSString *bankName){
        
        [_bankName setTitle:bankName forState:UIControlStateNormal];
        
    };
    [self.navigationController pushViewController:listVC animated:YES];
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
