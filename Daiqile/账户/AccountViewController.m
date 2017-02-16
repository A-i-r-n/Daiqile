
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
#import "LoginViewController.h"

#import "ChargeRecordViewController.h"
#import "MyInvestViewController.h"
#import "SafityViewController.h"
#import "BindCardViewController.h"
#import "RecommendToFriendsViewController.h"
//#import "RedPacketsViewController.h"
#import "AccountModel.h"
#import "LoginViewController.h"
#import "RechargeViewController.h"
#import "GetMoneyViewController.h"
#import "CashViewController.h"
#import "BindCardViewController.h"
#import "RealnameViewController.h"
#import "ChangeMoneyViewController.h"
@interface AccountViewController ()
{
    UIScrollView *scrollView;
    NSArray *_btnTitleArray;
    NSArray *_btnImgArray;
    NSString *_status;
    NSString *_cardId;
    AccountModel *model;
    
}
@property (strong, nonatomic) IBOutlet UIButton *headImgBtn;//选择头像按钮
@property (strong, nonatomic) IBOutlet UILabel *userName;//用户名
@property (strong, nonatomic) IBOutlet UIImageView *casteImg;//等级图片
@property (strong, nonatomic) IBOutlet UIButton *goAuthentication;//去认证
@property (strong, nonatomic) IBOutlet UILabel *allMoney;//账户总额
@property (strong, nonatomic) IBOutlet UILabel *usableMoney;//可用余额
@property (strong, nonatomic) IBOutlet UILabel *cannotUseMoney;//冻结金额



@property (strong, nonatomic) IBOutlet UIView *btnBgView;//按钮的背景view


@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"账户";
    
    _btnTitleArray = @[@"待收记录",@"我的投资",@"零钱包",@"绑定银行卡",@"推荐好友",@"安全中心"];
    _btnImgArray = @[@"icon_user_record",@"icon_user_invest",@"icon_user_redpackets",@"icon_user_card",@"icon_user_recommend",@"icon_user_safety"];
    
    //创建下部(交易记录,我的投资)等按钮
    [self createUserBtn];
    
    //该页面所有点击事件
    [self allClickAction];
    
    //检查用户是否已经实名认证
    [self checkUser];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    //发送网络请求,获取用户信息
    [self sendHttpRequest];
}

- (void)allClickAction
{
    [_headImgBtn addTarget:self action:@selector(headBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_goAuthentication addTarget:self action:@selector(authenticationClick) forControlEvents:UIControlEventTouchUpInside];
}

//去认证
- (void)authenticationClick
{
    if (LOGINSTATUS) {
        
        if ([_status isEqualToString:@"3"]) {
            
            [LCProgressHUD showMessage:@"您已经实名认证啦!"];
            
        }else{
            
            RealnameViewController *realname = [[RealnameViewController alloc]init];
            
            PUSH(realname);

            
        }
        
    }else{
        
        LoginViewController *login = [[LoginViewController alloc]init];
        
        PUSH(login);
        
    }
}

//充值
- (IBAction)rechargeClick:(id)sender
{
    if (LOGINSTATUS) {
        
        //判断是否实名认证
        if ([_status isEqualToString:@"3"]) {
            
            //判断是否绑定银行卡
            if (_cardId.length > 0) {
                
                RechargeViewController *recharge = [[RechargeViewController alloc]init];
                
                PUSH(recharge);
                
                
            }else{
                
                [LCProgressHUD showMessage:@"您还未绑定银行卡,请先绑定银行卡!"];
                
            }
            
        }else if ([_status isEqualToString:@"4"]){
            
            [LCProgressHUD showMessage:@"您已提交实名认证,还不能充值,请耐心等待管理员审核!"];
            
        }else{
            
            [LCProgressHUD showMessage:@"请先实名认证!"];
            
        }

       
    }else{
        
        LoginViewController *login = [[LoginViewController alloc]init];
        
        PUSH(login);
        
    }
        
}

//提现
- (IBAction)getMoneyClick:(id)sender
{
    if (LOGINSTATUS) {
        
        NSDictionary *params = @{@"user_id":UserDefaultGetValue(@"userId")};
        
        [HttpManager sendPostRequestWithDictionary:params withUrl:@"port/getMobileCard3.php" Success:^(NSDictionary *responseData) {
            
            NSString *status = responseData[@"status"];
            
            if ([status isEqualToString:@"1"]) {
                
                CashViewController *cash = [[CashViewController alloc]init];
                
                PUSH(cash);
                
            }else{
                
                BindCardViewController *bind = [[BindCardViewController alloc]init];
                
                PUSH(bind);
                
            }
            
        } Failed:^(NSError *error) {
            
        }];
        
    }else{
        
        LoginViewController *login = [[LoginViewController alloc]init];
        
        PUSH(login);
        
    }
}

//检查用户是否已经实名认证
- (void)checkUser
{
    if (LOGINSTATUS) {
        
        NSDictionary *parameters=@{@"user_id":UserDefaultGetValue(@"userId")};
        
        [HttpManager sendPostRequestWithDictionary:parameters withUrl:@"port/checkuser.php" Success:^(NSDictionary *responseData) {
            
            _status = [responseData objectForKey:@"status"];
            
            _cardId = [responseData objectForKey:@"card_id"];
            
            if ([_status isEqualToString:@"3"]) {
                
                [_goAuthentication setTitle:@"已实名认证" forState:UIControlStateNormal];
                
            }else if ([_status isEqualToString:@"4"]){
                
                [_goAuthentication setTitle:@"已提交实名认证,等待审核" forState:UIControlStateNormal];
                
            }
            
        } Failed:^(NSError *error) {
            
            [LCProgressHUD showMessage:@"网络请求出错,请联系管理员!"];
            
        }];
        
    }else{
        
//        _allMoney.text = @"0.00";
//        
//        _usableMoney.text = @"0.00";
//        
//        _cannotUseMoney.text = @"0.00";

        
        LoginViewController *login = [[LoginViewController alloc]init];
        
        PUSH(login);
        
    }
        
    
}


- (void)sendHttpRequest
{
    if (LOGINSTATUS) {
        
        //获取用户信息
        [HttpManager sendGetRequestWithDictionary:nil withUrl:[NSString stringWithFormat:@"port/getUserLog.php?user_id=%@",UserDefaultGetValue(@"userId")] Success:^(NSDictionary *responseData) {
            
            model = [AccountModel new];
            
            [model setValuesForKeysWithDictionary:responseData];
            
            //保存用户所有资金
            UserDefaultSetValue(model.total, @"userTotalMoney");
            
            SynchUserDefault;
            
            _userName.text = UserDefaultGetValue(@"userName");
            
            _allMoney.text = model.total;
            
            _usableMoney.text = model.use_money;
            
            _cannotUseMoney.text = model.no_use_money;
            
            
        } Failed:^(NSError *error) {
            
        }];
    }else{
        
        _userName.text = @"";
        
        _allMoney.text = @"0.00";
        
        _usableMoney.text = @"0.00";
        
        _cannotUseMoney.text = @"0.00";
        
    }

    
}

//前往登录界面
- (void)headBtnClick:(UIButton *)button
{
    if (!LOGINSTATUS) {
        LoginViewController *login = [[LoginViewController alloc]init];
        
        PUSH(login);
    }
}

//下部按钮方法
- (void)btnClick:(UIButton *)button
{
    if (LOGINSTATUS) {
        
        switch (button.tag) {
            case 10:
            {
                //交易记录
                ChargeRecordViewController *charge = [[ChargeRecordViewController alloc]init];
                
                PUSH(charge);
            }
                break;
            case 11:
            {
                //我的投资
                MyInvestViewController *invest = [[MyInvestViewController alloc]init];
                
                PUSH(invest);
                
            }
                break;
            case 12:
            {
                //零钱包
                ChangeMoneyViewController *red = [[ChangeMoneyViewController alloc]init];
                
                //red.model = model;
                
                PUSH(red);
                
            }
                break;
            case 13:
            {
                //绑定银行卡
                BindCardViewController *bind = [[BindCardViewController alloc]init];
                
                PUSH(bind);
            }
                break;
            case 14:
            {
                //推荐好友
                RecommendToFriendsViewController *recommend = [[RecommendToFriendsViewController alloc]init];
                
                PUSH(recommend);
            }
                break;
                
            default:
            {
                //安全中心
                SafityViewController *safe = [[SafityViewController alloc]init];
                
                safe.autoStatus = _status;
                
                PUSH(safe);
            }
                break;
        }

        
    }else{
        
        LoginViewController *login = [[LoginViewController alloc]init];
        
        PUSH(login);
        
    }
}


- (void)createUserBtn
{
    BtnView *btnview = [[BtnView alloc]initWithBgViewFrame:CGRectMake(0, 15, _btnBgView.frame.size.width, _btnBgView.frame.size.height) withNubOfBtnInLine:3 withNubLine:2 withTopSpace:15.0f withleftSpace:20.0f withSpace:15.0f withTitleArray:_btnTitleArray withImageArray:_btnImgArray];
    
    for (int i = 0; i < 6; i++) {
        UIButton *button = [btnview viewWithTag:10+i];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [_btnBgView addSubview:btnview];
    
}


@end
