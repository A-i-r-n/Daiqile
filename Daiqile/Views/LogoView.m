//
//  LogoView.m
//  Daiqile
//
//  Created by daiqile on 2016/11/16.
//  Copyright © 2016年 com.daiqile.daiqile. All rights reserved.
//

#import "LogoView.h"

@implementation LogoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *img = [[UIImageView alloc]init];
        img.image = [UIImage imageNamed:@"top_title_yellow"];
        
        [self addSubview:img];
        
        UILabel *design = [[UILabel alloc]init];
        design.text = @"安全,透明,便捷,值得投资";
        design.textColor = MainColor;
        [self addSubview:design];
        
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(10);
            make.centerX.equalTo(self.mas_centerX);
//            make.width.offset(60);
//            make.height.offset(60);
        }];
        
        [design mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(img.mas_bottom).offset(10);
            make.centerX.equalTo(img.mas_centerX);
        }];
        

    }
    return self;
}




@end
