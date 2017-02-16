//
//  TollModel.h
//  FlyingCapital
//
//  Created by daiqile on 15/7/8.
//  Copyright (c) 2015年 dql. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToolModel : NSObject

+(void)setStatusbBarFontColor;

+(NSString*)linkUrl:(NSString*)path;
+(NSString *)filterHTML:(NSString *)str;
+ (NSString *)md5:(NSString *)str;
- (NSString*)md532BitUpper;
+ (BOOL) validateIdentityCard: (NSString *)identityCard;
+ (NSString *)valiMobile:(NSString *)mobile;
+ (BOOL) checkCardNo:(NSString*)cardNo;
+ (BOOL)isBlankString:(NSString *)string;
-(NSString*)convertNull:(id)object;
+ (void)showAlertViewWithString:(NSString *)string;

+ (NSArray *)filterImage:(NSString *)html;

+ (NSString *)getDateWithString:(NSString *)dateString;//时间戳转时间
@end
