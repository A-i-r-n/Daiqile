//
//  TenderModel.m
//  Daiqile
//
//  Created by daiqile on 2017/2/9.
//  Copyright © 2017年 com.daiqile.daiqile. All rights reserved.
//

#import "TenderModel.h"

@implementation TenderModel

+ (TenderModel *)parseWithDictionary:(NSDictionary *)dict
{
    TenderModel *model = [[TenderModel alloc]init];
    
    model.username = dict[@"username"];
    
    model.apr = dict[@"apr"];
    
    model.money = dict[@"money"];
    
    model.tender_account = dict[@"tender_account"];
    
    model.addtime = dict[@"addtime"];
    
    return model;
}
@end
