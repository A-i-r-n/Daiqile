//
//  LiActivityIndicator.h
//  LiActivityIndicator
//
//  Created by li on 16/2/26.
//  Copyright © 2016年 医视时代. All rights reserved.
//
//
//  Email:  786452210@qq.com
//  GitHub: https://github.com/libing1125
//  如有问题或建议请给我发 Email,如果觉得有用记得在Github 上 star（关注一下）
//


#import <Foundation/Foundation.h>
#define IMAGE(filename, ext) [UIImage imageNamed:[NSString stringWithFormat:@"resource.bundle/%@.%@", filename, ext]]
#define CURRENTDEVICE [[[UIDevice currentDevice] systemVersion] floatValue]
#define SCREEN_WIDTH  MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)
#define SCREEN_HEIGHT  MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)

#define UISCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#define UISCREEN_HEIGHT [[UIScreen mainScreen].bounds.size.height
@interface LiActivityIndicator : NSObject

+ (void)show;
+ (void)show:(NSString*)message needdismiss:(BOOL)dismiss;
+ (void)dismiss;

@end
