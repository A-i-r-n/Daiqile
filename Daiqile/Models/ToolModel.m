//
//  TollModel.m
//  FlyingCapital
//
//  Created by daiqile on 15/7/8.
//  Copyright (c) 2015年 dql. All rights reserved.
//

#import "ToolModel.h"
#import "AppDelegate.h"
#import <CommonCrypto/CommonDigest.h>
@implementation ToolModel

+(void)setStatusbBarFontColor{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}

+(NSString*)linkUrl:(NSString*)path{
    NSString *url = URLSTRING;
    //"http://121.199.54.237:8080/feiyang/";//公司服务器http://taibaojf.com   com.TaiBaoJinFu2.YiMeng
    //"http://120.26.206.37/";//飞扬服务器
    //"http://192.168.1.213:8080/feiyang/";//本地服务器  120.26.223.51
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",url,path];
    
    return urlStr;
    //return [url stringByAppendingString:path];
}

+ (void)showAlertViewWithString:(NSString *)string
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:string delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

//HTML标签里面的图片路径拼接
+(NSString *)filterHTML:(NSString *)str
{
    NSScanner * scanner = [NSScanner scannerWithString:str];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<img alt='' src='" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@"/plugins" intoString:&text];
        //替换字符
        str  =  [str  stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@/plugins",text] withString:@"<head><style>img{max-width:320px !important;}</style></head></font><img alt='' src='http://106.14.75.136/plugins"];
    }
    
    return str;
}


//获取html中图片
+ (NSArray *)filterImage:(NSString *)html
{
    NSMutableArray *resultArray = [NSMutableArray array];
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<(img|IMG)(.*?)(/>|></img>|>)" options:NSRegularExpressionAllowCommentsAndWhitespace error:nil];
    NSArray *result = [regex matchesInString:html options:NSMatchingReportCompletion range:NSMakeRange(0, html.length)];
    
    for (NSTextCheckingResult *item in result) {
        NSString *imgHtml = [html substringWithRange:[item rangeAtIndex:0]];
        NSArray *tmpArray = nil;
        if ([imgHtml rangeOfString:@"src=\'"].location != NSNotFound) {
            tmpArray = [imgHtml componentsSeparatedByString:@"src=\'"];
        } else if ([imgHtml rangeOfString:@"src="].location != NSNotFound) {
            tmpArray = [imgHtml componentsSeparatedByString:@"src="];
        }
        
        if (tmpArray.count >= 2) {
            NSString *src = tmpArray[1];
            
            NSUInteger loc = [src rangeOfString:@"\'"].location;
            if (loc != NSNotFound) {
                src = [src substringToIndex:loc];
                
                src = [NSString stringWithFormat:@"http://106.14.75.136%@",src];
                
                [resultArray addObject:src];
            }
        }
    }
    
    return resultArray;
}


+ (BOOL)isBlankString:(NSString *)string{
    
    if (string == nil) {
        
        return YES;
        
    }
    
    if (string == NULL) {
        
        return YES;
        
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        
        return YES;
        
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        
        return YES;
        
    }
    
    return NO;
    
}

//时间戳转时间
+ (NSString *)getDateWithString:(NSString *)dateString
{
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[dateString intValue]];
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSString *destDateString=[dateFormatter stringFromDate:confromTimesp];
    
    return destDateString;
}

//+ (NSString *)md5:(NSString *)str {
//    const char *cStr = [str UTF8String];
//    unsigned char result[32];
//    CC_MD5( cStr, strlen(cStr), result );
//    return [NSString stringWithFormat:
//            @"XXXXXXXXXXXXXXXX",
//            result[0],result[1],result[2],result[3],
//            result[4],result[5],result[6],result[7],
//            result[8],result[9],result[10],result[11],
//            result[12],result[13],result[14],result[15],
//            result[16], result[17],result[18], result[19],
//            result[20], result[21],result[22], result[23],
//            result[24], result[25],result[26], result[27],
//            result[28], result[29],result[30], result[31]];
//
//}
//+ (NSString *)md5:(NSString *)str
//{
//    const char *cStr = [str UTF8String];
//    unsigned char result[32];
//    CC_MD5(cStr, (UIDeviceOrientation)strlen(cStr), result); // This is the md5 call
//    return [NSString stringWithFormat:
//            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
//            result[0], result[1], result[2], result[3],
//            result[4], result[5], result[6], result[7],
//            result[8], result[9], result[10], result[11],
//            result[12], result[13], result[14], result[15],
//            result[16], result[17],result[18], result[19],
//            result[20], result[21],result[22], result[23],
//            result[24], result[25],result[26], result[27],
//            result[28], result[29],result[30], result[31]];
//    
//}
//- (NSString*)md532BitUpper
//
//{
//    
//    const char *cStr = [self UTF8String];
//    unsigned char result[16];
//    
//    
//    
//    NSNumber *num = [NSNumber numberWithUnsignedLong:strlen(cStr)];
//    
//    CC_MD5( cStr,[num intValue], result );
//    
//    
//    
//    return [[NSString stringWithFormat:
//             
//             @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
//             
//             result[0], result[1], result[2], result[3],
//             
//             result[4], result[5], result[6], result[7],
//             
//             result[8], result[9], result[10], result[11],
//             
//             result[12], result[13], result[14], result[15]
//             
//             ] uppercaseString];
//}

//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}


+ (BOOL) checkCardNo:(NSString*)cardNo{
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[cardNo length];
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
    
    cardNo = [cardNo substringToIndex:cardNoLength - 1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1, 1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
}

//验证手机号
+ (NSString *)valiMobile:(NSString *)mobile{
    if (mobile.length < 11)
    {
        return @"手机号长度只能是11位";
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return nil;
        }else{
            return @"请输入正确的电话号码";
        }
    }
    return nil;
}

@end
