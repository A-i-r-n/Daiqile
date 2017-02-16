//
//  CollectionModel.h
//  Daiqile
//
//  Created by daiqile on 2017/2/14.
//  Copyright © 2017年 com.daiqile.daiqile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollectionModel : NSObject
@property(nonatomic,copy)NSString *borrow_name;//标名
@property(nonatomic,copy)NSString *order;
@property(nonatomic,copy)NSString *time_limit;
@property(nonatomic,copy)NSString *repay_account;//应收本息
@property(nonatomic,copy)NSString *addtime;//还款时间

+ (CollectionModel *)parseWithDictionary:(NSDictionary *)dict;
@end
