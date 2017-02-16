//
//  RepayModel.h
//  Daiqile
//
//  Created by daiqile on 2017/2/9.
//  Copyright © 2017年 com.daiqile.daiqile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RepayModel : NSObject

@property (nonatomic,strong) NSString *borrow_name;
@property (nonatomic,strong) NSString *order;
@property (nonatomic,strong) NSString *time_limit;
@property (nonatomic,strong) NSString *repayment_account;
@property (nonatomic,strong) NSString *repayment_time;

+ (RepayModel *)parseWithDictionary:(NSDictionary *)dict;

@end
