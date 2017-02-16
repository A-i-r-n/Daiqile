//
//  HttpManager.h
//  Daiqile
//
//  Created by daiqile on 2017/2/6.
//  Copyright © 2017年 com.daiqile.daiqile. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^SuccessBlock)(NSDictionary *responseData);
typedef void (^SuccessArrayBlock)(NSArray *responseData);
typedef void (^FailedBlock)(NSError *error);

@interface HttpManager : NSObject

//get请求 返回字典
+ (void)sendGetRequestWithDictionary:(NSDictionary *)params withUrl:(NSString *)urlString Success:(SuccessBlock)success Failed:(FailedBlock)fail;

//post 请求 返回字典
+ (void)sendPostRequestWithDictionary:(NSDictionary *)params withUrl:(NSString *)urlString Success:(SuccessBlock)success Failed:(FailedBlock)fail;

//get请求 返回数组
+ (void)sendGetGetArrayWithDictionary:(NSDictionary *)params withUrl:(NSString *)urlString Success:(SuccessArrayBlock)success Failed:(FailedBlock)fail;

//post 请求 返回数组
+ (void)sendPostGetArrayWithDictionary:(NSDictionary *)params withUrl:(NSString *)urlString Success:(SuccessArrayBlock)success Failed:(FailedBlock)fail;

+ (void)showAlertViewWithString:(NSString *)string;


@end
