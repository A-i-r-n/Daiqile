//
//  InvestModel.h
//  Daiqile
//
//  Created by daiqile on 2017/2/14.
//  Copyright © 2017年 com.daiqile.daiqile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InvestModel : NSObject

@property(nonatomic,copy)NSString *borrow_name;//标名
@property(nonatomic,copy)NSString *tender_account;//投资金额
@property(nonatomic,copy)NSString *repayment_account;//应收本息
@property(nonatomic,copy)NSString *addtime;//投资时间

+ (InvestModel *)parseWithDictionary:(NSDictionary *)dict;
@end
