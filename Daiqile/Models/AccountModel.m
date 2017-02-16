//
//  AccountModel.m
//  YongHong
//
//  Created by daiqile on 16/5/27.
//  Copyright © 2016年 yangyukun. All rights reserved.
//

#import "AccountModel.h"

@implementation AccountModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
- (id)initWithDict:(NSDictionary *)dict;
{
    if(self = [super init])
    {
        //将字典中的键值对转换成模型属性
        self.credit = [dict[@"cash_success"] objectForKey:@"credited"];
       
    }
    return  self;
}

@end
