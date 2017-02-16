//
//  AccountModel.h
//  YongHong
//
//  Created by daiqile on 16/5/27.
//  Copyright © 2016年 yangyukun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountModel : NSObject
@property(nonatomic,copy)NSString *use_money;//
@property(nonatomic,copy)NSString *total;//总资产
@property(nonatomic,copy)NSString *collection;//代收总额
@property(nonatomic,copy)NSString *no_use_money;//冻结金额
@property(nonatomic,copy)NSString *credit;//积分

@property(nonatomic,copy)NSString *award_add;//总收益
@property(nonatomic,copy)NSString *fund;//余额宝
@property(nonatomic,copy)NSString *borrow_num;//借款
@property(nonatomic,copy)NSString *tender;//投资总额
@property(nonatomic,copy)NSString *credited;//提现
@property(nonatomic,copy)NSString *rechargesum;//充值
@property(nonatomic,copy)NSString *success_account;//总额


@property (nonatomic,strong)NSDictionary *cash_success;

@end
