//
//  ChangeMoneyViewController.m
//  Daiqile
//
//  Created by daiqile on 2017/2/15.
//  Copyright © 2017年 com.daiqile.daiqile. All rights reserved.
//

#import "ChangeMoneyViewController.h"
#import "RollMoneyViewController.h"
#import "RollOutViewController.h"
@interface ChangeMoneyViewController ()
{
    NSString *_status;
}
@property (strong, nonatomic) IBOutlet UILabel *shouYi;//零钱包收益
@property (strong, nonatomic) IBOutlet UILabel *totalMoney;//总资产
@property (strong, nonatomic) IBOutlet UILabel *dueIn;//待收总额
@property (strong, nonatomic) IBOutlet UILabel *noUse;//冻结金额
@property (strong, nonatomic) IBOutlet UILabel *allEarn;//总收益
@property (strong, nonatomic) IBOutlet UILabel *changeMoney;//零钱包
@property (strong, nonatomic) IBOutlet UILabel *tenderMoney;//投资总额
@property (strong, nonatomic) IBOutlet UILabel *getMoney;//提现
@property (strong, nonatomic) IBOutlet UILabel *rechargeMoney;//充值



@end

@implementation ChangeMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.title = @"零钱包";
    
    //添加数据
    [self sendHttpRequest];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    //如果转入/转出余额宝成功,就发送请求刷新界面
    if ([_status isEqualToString:@"1"]) {
        
        [self sendHttpRequest];
        
    }
}

- (void)sendHttpRequest
{
    if (LOGINSTATUS) {
        
        //获取用户信息
        [HttpManager sendGetRequestWithDictionary:nil withUrl:[NSString stringWithFormat:@"port/getUserLog.php?user_id=%@",UserDefaultGetValue(@"userId")] Success:^(NSDictionary *responseData) {
            
            self.model = [AccountModel new];
            
            [self.model setValuesForKeysWithDictionary:responseData];
            
            //设置数据
            [self setData];
            
        } Failed:^(NSError *error) {
            
        }];
    }
    
}

//转入余额宝
- (IBAction)rollIn:(id)sender
{
    RollMoneyViewController *roll = [[RollMoneyViewController alloc]init];
    
    roll.request = ^(NSString *status){
        
        _status = status;
        
    };
    
    PUSH(roll);
}

//转出余额宝
- (IBAction)rollOut:(id)sender
{
    RollOutViewController *roll = [[RollOutViewController alloc]init];
    
    roll.request = ^(NSString *status){
        
        _status = status;
        
    };
    
    PUSH(roll);
}

- (void)setData
{
    if (self.model != nil) {
        //总资产
        if (self.model.total != nil) {
            
            _totalMoney.text = self.model.total;
            
        }
        
        
        //待收总额
        if (self.model.collection != nil) {
            
            _dueIn.text = self.model.collection;

            
        }
        
        //冻结金额
        if (self.model.no_use_money) {
            
             _noUse.text = self.model.no_use_money;
            
        }
       
        
        //总收益
        if (self.model.award_add != nil) {
            
            _allEarn.text = self.model.award_add;
            
        }
        
        
        //零钱包
        if (self.model.fund != nil) {
            
            _changeMoney.text = self.model.fund;
            
        }
        
        
        
        //投资总额
        if (self.model.success_account != nil) {
            
            _tenderMoney.text = self.model.success_account;
            
        }
        
        
        //提现
        if (self.model.cash_success != nil) {
            
            _getMoney.text = self.model.cash_success[@"credited"];
            
        }
        
        
        //充值
        if (self.model.rechargesum != nil) {
            
            _rechargeMoney.text = self.model.rechargesum;
            
            
        }
        
    }
   
}

@end
