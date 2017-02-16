//
//  CollectionModel.m
//  Daiqile
//
//  Created by daiqile on 2017/2/14.
//  Copyright © 2017年 com.daiqile.daiqile. All rights reserved.
//

#import "CollectionModel.h"

@implementation CollectionModel

+ (CollectionModel *)parseWithDictionary:(NSDictionary *)dict
{
    CollectionModel *model = [[CollectionModel alloc]init];
    
    model.borrow_name = dict[@"borrow_name"];
    
    model.order = dict[@"order"];
    
    model.time_limit = dict[@"time_limit"];
    
    model.repay_account = dict[@"repay_account"];
    
    model.addtime = [ToolModel getDateWithString:dict[@"addtime"]];
    
    return model;
}


@end
