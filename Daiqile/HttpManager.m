//
//  HttpManager.m
//  Daiqile
//
//  Created by daiqile on 2017/2/6.
//  Copyright © 2017年 com.daiqile.daiqile. All rights reserved.
//

#import "HttpManager.h"

@implementation HttpManager

//get请求
+ (void)sendGetRequestWithDictionary:(NSDictionary *)params withUrl:(NSString *)urlString Success:(SuccessBlock)success Failed:(FailedBlock)fail
{
    AFHTTPSessionManager *manager = [self getHttpSessionManager];
    
    [manager GET:[self formatUrlString:urlString] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *dataString = [[NSString alloc]initWithData:responseObject encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
        
        //NSLog(@"getArrayString ========= %@",dataString);
        
        NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        success(json);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        fail(error);
        
    }];
}


//post请求
+ (void)sendPostRequestWithDictionary:(NSDictionary *)params withUrl:(NSString *)urlString Success:(SuccessBlock)success Failed:(FailedBlock)fail
{
    AFHTTPSessionManager *manager = [self getHttpSessionManager];
    
    [manager POST:[self formatUrlString:urlString] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *dataString = [[NSString alloc]initWithData:responseObject encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
        
        //NSLog(@"postArrayString ========= %@",dataString);
        
        NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        success(json);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        fail(error);
        
    }];
}

//get请求 返回数组
+ (void)sendGetGetArrayWithDictionary:(NSDictionary *)params withUrl:(NSString *)urlString Success:(SuccessArrayBlock)success Failed:(FailedBlock)fail
{
    
    AFHTTPSessionManager *manager = [self getHttpSessionManager];
    
    [manager GET:[self formatUrlString:urlString] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *dataString = [[NSString alloc]initWithData:responseObject encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
        
        //NSLog(@"getArrayString ========= %@",dataString);
        
        NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
        
        NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        success(json);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        fail(error);
        
    }];

}

//post 请求 返回数组
+ (void)sendPostGetArrayWithDictionary:(NSDictionary *)params withUrl:(NSString *)urlString Success:(SuccessArrayBlock)success Failed:(FailedBlock)fail
{
    AFHTTPSessionManager *manager = [self getHttpSessionManager];
    
    [manager POST:[self formatUrlString:urlString] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *dataString = [[NSString alloc]initWithData:responseObject encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
        
        //NSLog(@"postArrayString ========= %@",dataString);
        
        NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
        
        NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        success(json);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        fail(error);
        
    }];

}


+ (AFHTTPSessionManager *)getHttpSessionManager
{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:config];
    
    manager.requestSerializer.timeoutInterval = 30;
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    return manager;
    
}

+ (NSString *)formatUrlString:(NSString *)urlString
{
    return [NSString stringWithFormat:@"%@%@",URLSTRING,urlString];
}

+ (void)showAlertViewWithString:(NSString *)string
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示信息" message:string preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
    //[self presentViewController:alertview animated:YES completion:nil];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window.rootViewController presentViewController:alert animated:YES completion:nil];
    
}



@end
