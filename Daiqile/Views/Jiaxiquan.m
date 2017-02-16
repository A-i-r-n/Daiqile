//
//  Jiaxiquan.m
//  juZu
//
//  Created by daiqile on 2017/1/10.
//  Copyright © 2017年 yangyukun. All rights reserved.
//

#import "Jiaxiquan.h"

@implementation Jiaxiquan

+ (Jiaxiquan *)parseWithDict:(NSDictionary *)dict
{
    Jiaxiquan *model = [[Jiaxiquan alloc]init];
    
    model.iD = dict[@"id"];
    model.account = dict[@"account"];
    
    return model;
}

@end
