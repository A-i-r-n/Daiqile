//
//  BtnView.h
//  Daiqile
//
//  Created by daiqile on 2016/11/16.
//  Copyright © 2016年 com.daiqile.daiqile. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BtnView : UIView
- (instancetype)initWithBgViewFrame:(CGRect)frame withNubOfBtnInLine:(NSInteger)nubInLine withNubLine:(NSInteger)nubLine withTopSpace:(CGFloat)topSpace withleftSpace:(CGFloat)leftSpace withSpace:(CGFloat)space withTitleArray:(NSArray *)titleArray withImageArray:(NSArray *)imgArray;
@end
