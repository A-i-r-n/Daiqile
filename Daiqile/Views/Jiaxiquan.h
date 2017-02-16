//
//  Jiaxiquan.h
//  juZu
//
//  Created by daiqile on 2017/1/10.
//  Copyright © 2017年 yangyukun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Jiaxiquan : NSObject
@property (nonatomic,strong) NSString *iD;
@property (nonatomic,strong) NSString *account;

+ (Jiaxiquan *)parseWithDict:(NSDictionary *)dict;
@end
