
//
//  AccountViewController.m
//  Daiqile
//
//  Created by daiqile on 2016/11/14.
//  Copyright © 2016年 com.daiqile.daiqile. All rights reserved.
//

#import "AccountViewController.h"

@interface AccountViewController ()
{
    UIScrollView *scrollView;
}
@property (strong, nonatomic) IBOutlet UIButton *headImgBtn;//选择头像按钮
@property (strong, nonatomic) IBOutlet UILabel *userName;//用户名
@property (strong, nonatomic) IBOutlet UIImageView *casteImg;//等级图片
@property (strong, nonatomic) IBOutlet UIButton *goAuthentication;//去认证
@property (strong, nonatomic) IBOutlet UILabel *allMoney;//账户总额
@property (strong, nonatomic) IBOutlet UILabel *usableMoney;//可用余额
@property (strong, nonatomic) IBOutlet UILabel *cannotUseMoney;//冻结金额
@property (strong, nonatomic) IBOutlet UIButton *recharge;//充值
@property (strong, nonatomic) IBOutlet UIButton *getMoney;//提现

@property (strong, nonatomic) IBOutlet UIButton *tradeRecord;//交易记录
@property (strong, nonatomic) IBOutlet UIButton *myInvest;//我的投资
@property (strong, nonatomic) IBOutlet UIButton *myRedpackets;//我的红包
@property (strong, nonatomic) IBOutlet UIButton *myCard;//绑定银行卡
@property (strong, nonatomic) IBOutlet UIButton *myrecommend;//我的推荐
@property (strong, nonatomic) IBOutlet UIButton *safity;//安全中心



@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"账户";
    
    
    

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
