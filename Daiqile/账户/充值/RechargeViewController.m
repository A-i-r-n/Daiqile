
//
//  RechargeViewController.m
//  Daiqile
//
//  Created by daiqile on 2017/2/10.
//  Copyright © 2017年 com.daiqile.daiqile. All rights reserved.
//

#import "RechargeViewController.h"
#import "fuyouRechargeViewController.h"

@interface RechargeViewController ()

@property (strong, nonatomic) IBOutlet UITextField *moneyFild;

@end

@implementation RechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"充值";
    
}

//确认充值
- (IBAction)rechageClick:(id)sender
{
    //检查是否绑定银行卡
    [HttpManager sendPostRequestWithDictionary:@{@"user_id":UserDefaultGetValue(@"userId")} withUrl:@"port/getMobileCard3.php" Success:^(NSDictionary *responseData) {
        
        NSString *status = responseData[@"status"];
        
        if ([status isEqualToString:@"1"]) {
            
            //如果绑定就跳转到充值界面
            NSString *urlString = [ToolModel linkUrl:[NSString stringWithFormat:@"port/fuyoumobilepay.php?money=%@&type=1&payment1=80&user_id=%@",_moneyFild.text,UserDefaultGetValue(@"userId")]];
            NSLog(@"userid == %@",UserDefaultGetValue(@"userId"));
            
            fuyouRechargeViewController *fuyou = [[fuyouRechargeViewController alloc]init];
            
            fuyou.money = urlString;
            
            PUSH(fuyou);
            
        }else{
            
            [LCProgressHUD showMessage:@"您还未绑定银行卡!"];
            
        }
        
    } Failed:^(NSError *error) {
        
        [LCProgressHUD showMessage:@"网络请求出错,请联系管理员!"];
        
    }];
    
    
    
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
