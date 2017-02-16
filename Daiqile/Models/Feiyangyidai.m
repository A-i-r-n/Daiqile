//
//  Feiyangyidai.m
//  FlyingCapital
//
//  Created by daiqile on 15/7/14.
//  Copyright (c) 2015年 dql. All rights reserved.
//

#import "Feiyangyidai.h"


@implementation Feiyangyidai

- (id)initWithDict:(NSDictionary *)dict;
{
    if(self = [super init])
    {
        //将字典中的键值对转换成模型属性
        self.iD = dict[@"id"];
        self.name = dict[@"name"];
        self.time = dict[@"time"];
        self.account_yes = [dict[@"account_yes"] floatValue];
        self.apr= [dict[@"apr"] floatValue];
        self.time_limit = dict[@"time_limit"];
        self.time_limit_day = dict[@"time_limit_day"];
        self.isDay = dict[@"isday"];
        self.account = [dict[@"account"] floatValue];
        self.verify_time = [NSString stringWithFormat:@"%@",dict[@"verify_time"]];
        self.valid_time = dict[@"valid_time"];
        self.end_time = [NSString stringWithFormat:@"%@",dict[@"end_time"]];
        
        self.status = dict[@"status"];
        self.borrowID = dict[@"id"];
        self.repayment_accout = dict[@"repayment_accout"];
        self.repayment_yesaccount = dict[@"repayment_yesaccount"];
        self.project_pic2 = dict[@"project_pic2"];
        self.style = dict[@"style"];
        self.is_ti = [NSString stringWithFormat:@"%@",dict[@"is_ti"]];
        self.is_fast = [NSString stringWithFormat:@"%@",dict[@"is_fast"]];
        self.pro_pic = dict[@"pro_pic"];
        self.lowest_account = dict[@"lowest_account"];
        self.content = dict[@"content"];
        self.contract_pic = dict[@"contract_pic"];
    }
    return  self;
}
+ (id)feiyangyidaiWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
@end
