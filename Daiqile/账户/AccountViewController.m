
//
//  AccountViewController.m
//  Daiqile
//
//  Created by daiqile on 2016/11/14.
//  Copyright © 2016年 com.daiqile.daiqile. All rights reserved.
//

#import "AccountViewController.h"
#import "UIButton+AirButton.h"
#import "BtnView.h"

@interface AccountViewController ()
{
    UIScrollView *scrollView;
    NSArray *_btnTitleArray;
    NSArray *_btnImgArray;
    
    
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


@property (strong, nonatomic) IBOutlet UIView *btnBgView;//按钮的背景view

//@property (strong, nonatomic) UIButton *tradeRecord;//交易记录
//@property (strong, nonatomic) UIButton *myInvest;//我的投资
//@property (strong, nonatomic) UIButton *myRedpackets;//我的红包
//@property (strong, nonatomic) UIButton *myCard;//绑定银行卡
//@property (strong, nonatomic) UIButton *myrecommend;//我的推荐
//@property (strong, nonatomic) UIButton *safity;//安全中心



@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"账户";
    
    _btnTitleArray = @[@"交易记录",@"我的投资",@"我的红包",@"绑定银行卡",@"我的推荐",@"安全中心"];
    _btnImgArray = @[@"icon_user_record",@"icon_user_invest",@"icon_user_redpackets",@"icon_user_card",@"icon_user_recommend",@"icon_user_safety"];
    
    
    [self createUserBtn];
    

}



- (void)createUserBtn
{
    BtnView *btnview = [[BtnView alloc]initWithBgViewFrame:CGRectMake(0, 15, _btnBgView.frame.size.width, _btnBgView.frame.size.height) withNubOfBtnInLine:3 withNubLine:2 withTopSpace:15.0f withleftSpace:20.0f withSpace:15.0f withTitleArray:_btnTitleArray withImageArray:_btnImgArray];
    [_btnBgView addSubview:btnview];

}

- (void)btnClick:(UIButton *)button
{
    switch (button.tag) {
        case 10:
        {
            //交易记录
        }
            break;
        case 11:
        {
            //我的投资
        }
            break;
        case 12:
        {
            //我的红包
        }
            break;
        case 13:
        {
            //绑定银行卡
        }
            break;
        case 14:
        {
            //我的推荐
        }
            break;
        
        default:
        {
            //安全中心
        }
            break;
    }
}


@end
