//
//  AirTextField.m
//  Daiqile
//
//  Created by daiqile on 2016/11/16.
//  Copyright © 2016年 com.daiqile.daiqile. All rights reserved.
//

#import "AirTextField.h"

@implementation AirTextField

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    [self setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
}

- (void)setLeftImg:(UIImage *)leftImg
{
    _leftImg = leftImg;
    UIImageView *imageView = [[UIImageView alloc]initWithImage:leftImg];
    self.leftView = imageView;
    self.leftViewMode = UITextFieldViewModeAlways;
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    CGRect frame = [super leftViewRectForBounds:bounds];
    frame.origin.x += 8;
    return frame;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
