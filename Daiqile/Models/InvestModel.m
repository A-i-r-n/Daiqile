//
//  InvestModel.m
//  Daiqile
//
//  Created by daiqile on 2017/2/14.
//  Copyright © 2017年 com.daiqile.daiqile. All rights reserved.
//

#import "InvestModel.h"

@implementation InvestModel

+ (InvestModel *)parseWithDictionary:(NSDictionary *)dict
{
    InvestModel *model = [[InvestModel alloc]init];
    
    model.borrow_name = dict[@"borrow_name"];
    
    model.tender_account = dict[@"tender_account"];
    
    model.repayment_account = dict[@"repayment_account"];
    
    model.addtime = [ToolModel getDateWithString:dict[@"addtime"]];
    
    return model;
}

@end
