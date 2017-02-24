//
//  BtnView.m
//  Daiqile
//
//  Created by daiqile on 2016/11/16.
//  Copyright © 2016年 com.daiqile.daiqile. All rights reserved.
//

#import "BtnView.h"
#import "UIButton+AirButton.h"

#define  Width [UIScreen mainScreen].bounds.size.width

@implementation BtnView

- (instancetype)initWithBgViewFrame:(CGRect)frame withNubOfBtnInLine:(NSInteger)nubInLine withNubLine:(NSInteger)nubLine withTopSpace:(CGFloat)topSpace withleftSpace:(CGFloat)leftSpace withSpace:(CGFloat)space withTitleArray:(NSArray *)titleArray withImageArray:(NSArray *)imgArray
{
    
    self = [super initWithFrame:frame];
    
    //总按钮个数
    CGFloat number = nubLine *nubInLine;
    
    //计算按钮宽度
    CGFloat width = (Width - 2 *leftSpace - (nubInLine - 1)*space)/(float)nubInLine;
    
    if (self) {
        
        for (int i = 0; i < number; i++) {
            
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(leftSpace + i%nubInLine*(width+space), i/nubInLine*(width+space), width, width)];
            
            button.tag = 10 +i;
            
            [button setImage:[UIImage imageNamed:imgArray[i]] forState:UIControlStateNormal];
            
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            
            [button setTitle:titleArray[i] forState:UIControlStateNormal];
            
            //button.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
            button.layer.borderWidth = 1;
            
            button.layer.borderColor = MainColor.CGColor;
            
            [button setTitleColor:MainColor forState:UIControlStateNormal];
            
            [button verticalImageAndTitle:8];
            
            [self addSubview:button];
        }
        
    }
    return self;
}

@end
