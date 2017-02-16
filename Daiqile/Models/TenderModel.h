//
//  TenderModel.h
//  Daiqile
//
//  Created by daiqile on 2017/2/9.
//  Copyright © 2017年 com.daiqile.daiqile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TenderModel : NSObject

@property (nonatomic,strong) NSString *username;//投资人
@property (nonatomic,strong) NSString *apr;//年利率
@property (nonatomic,strong) NSString *money;//投资金额
@property (nonatomic,strong) NSString *tender_account;//有效金额
@property (nonatomic,strong) NSString *addtime;//时间

+ (TenderModel *)parseWithDictionary:(NSDictionary *)dict;

@end
