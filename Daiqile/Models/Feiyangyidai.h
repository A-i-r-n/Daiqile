//
//  Feiyangyidai.h
//  FlyingCapital
//
//  Created by daiqile on 15/7/14.
//  Copyright (c) 2015年 dql. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Feiyangyidai : NSObject
@property (nonatomic,copy) NSString *iD;//标id
@property (nonatomic,copy) NSString *name;//标名
@property (nonatomic,copy) NSString *time;//发标时间
@property (nonatomic,assign) float account_yes;//已完成
@property (nonatomic,assign) float apr;//年利率
@property (nonatomic,copy) NSString *time_limit;//期限(月)
@property (nonatomic,copy) NSString *time_limit_day;//期限(天)
@property (nonatomic,copy) NSString *isDay;  //期限是否是天
@property (nonatomic,assign) float account;//金额
@property (nonatomic,copy) NSString *end_time;//剩余时间
@property (nonatomic,copy) NSString *verify_time;//剩余时间
@property (nonatomic,copy) NSString *valid_time;//剩余时间
@property (nonatomic,copy) NSString *status;//状态
@property (nonatomic,copy) NSString *repayment_accout;//状态
@property (nonatomic,copy) NSString *repayment_yesaccount;//状态
@property (nonatomic,copy) NSString *project_pic2;//标背景图
@property (nonatomic,copy) NSString *borrowID;//标号
@property (nonatomic,copy) NSString *style;//还款方式
@property (nonatomic,copy) NSString *is_ti;//是新手标
@property (nonatomic,copy) NSString *is_fast;//聚租优选
@property (nonatomic,copy) NSString *lowest_account;//最低投标额
@property (nonatomic,copy) NSString *pro_pic;//项目图片
@property (nonatomic,copy) NSString *content;//项目描述
@property (nonatomic,copy) NSArray *contract_pic;//
+ (id)feiyangyidaiWithDict:(NSDictionary *)dict;
- (id)initWithDict:(NSDictionary *)dict;
@end
