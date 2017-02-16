//
//  RepayModel.m
//  Daiqile
//
//  Created by daiqile on 2017/2/9.
//  Copyright © 2017年 com.daiqile.daiqile. All rights reserved.
//

#import "RepayModel.h"

@implementation RepayModel

+ (RepayModel *)parseWithDictionary:(NSDictionary *)dict
{
    RepayModel *model = [[RepayModel alloc]init];
    
    model.borrow_name = dict[@"borrow_name"];
    
    model.order = dict[@"order"];
    
    model.time_limit = dict[@"time_limit"];
    
    model.repayment_account = dict[@"repayment_account"];
    
    model.repayment_time = dict[@"repayment_time"];
    
    return model;
}

@end
