//
//  LiActivityIndicator.m
//  LiActivityIndicator
//
//  Created by li on 16/2/26.
//  Copyright © 2016年 医视时代. All rights reserved.
//
//  Email:  786452210@qq.com
//  GitHub: https://github.com/libing1125
//  如有问题或建议请给我发 Email,如果觉得有用记得在Github 上 star（关注一下）

#import "LiActivityIndicator.h"
#import <UIKit/UIKit.h>

@interface LiActivityIndicator (){
    UIWindow *window;
    
    UIView *background;
    
    UIImageView *imageRorate;
    UIImageView *imageInside;
    
    UILabel *textLabel;
    UIButton *closeButton;
    NSTimer     *Timer;
}
@property(nonatomic, copy) NSString *message;
@property (nonatomic, assign) BOOL hidden;

+ (instancetype)shared;
@end

@implementation LiActivityIndicator
+ (instancetype)shared{
    static LiActivityIndicator *indicator = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        indicator = [[LiActivityIndicator alloc] init];
    });
    
    return indicator;
}

- (id)init{
    
    if (self = [super init]){
        
        id<UIApplicationDelegate> delegate = [[UIApplication sharedApplication] delegate];
        
        if ([delegate respondsToSelector:@selector(window)])
            window = [delegate performSelector:@selector(window)];
        else window = [[UIApplication sharedApplication] keyWindow];
        
        
        _hidden = YES;
    }
    
    return self;
}


- (void)setMessage:(NSString *)message {
    _message = [message copy];
    
    if (!_hidden){
        textLabel.text = message;
        [background setNeedsLayout];
    }
}

- (void)create{
    
    if (background == nil){
        background = [[UIView alloc] init];
        background.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    }
    if (background.superview == nil){
        [window addSubview:background];
    }
    
    if (imageInside == nil) {
        imageInside = [[UIImageView alloc] init];
        imageInside.image = IMAGE(@"loading_inside", @"png");
    }
    
    if (imageInside.superview == nil) {
        [background addSubview:imageInside];
    }
    
    if (!Timer)
    {
        Timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(startShining) userInfo:nil repeats:YES];
    }

    
    
    
    if (imageRorate == nil) {
        imageRorate = [[UIImageView alloc] init];
        imageRorate.image = IMAGE(@"loading", @"png");
    }
    
    if (imageRorate.superview == nil) {
        [background addSubview:imageRorate];
    }
    
    if (closeButton == nil) {
        closeButton = [[UIButton alloc] init];
        [closeButton setImage:IMAGE(@"close_window", @"png") forState:UIControlStateNormal];
    }
    
    if (closeButton.superview == nil) {
//        [background addSubview:closeButton];   // 取消按钮去掉
        [closeButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    }

    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 1.5f;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 99999;
    
    [imageRorate.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    if (_message != nil){
        if (textLabel == nil){
            textLabel = [[UILabel alloc] init];
            textLabel.backgroundColor = [UIColor clearColor];
            textLabel.numberOfLines = 3;
            textLabel.font = [UIFont systemFontOfSize:15];
            textLabel.text = _message;
            textLabel.textColor = [UIColor whiteColor];
        }
        
        if (textLabel.superview == nil){
            [background addSubview:textLabel];
        }
        
    }
    
    _hidden = NO;
}
-(void)startShining
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"bounds"];
    animation.duration =1;
    CGSize centSize = imageInside.bounds.size;
    CGPoint centPoint = imageInside.bounds.origin;
    CGFloat x = centSize.width;
    CGFloat y = centSize.height;
    CGRect  leftPoint = CGRectMake(centPoint.x,centPoint.y,  x-10, y-10);
    CGRect centerPoint = CGRectMake(centPoint.x,centPoint.y,x, y);
    CGRect rightPoint = CGRectMake(centPoint.x,centPoint.y,x+10, y+10);
    
    NSArray * array = [NSArray arrayWithObjects:
                       [NSValue valueWithCGRect:centerPoint],
                       [NSValue valueWithCGRect:leftPoint],
                       [NSValue valueWithCGRect:centerPoint],
                       [NSValue valueWithCGRect:rightPoint],
                       [NSValue valueWithCGRect:centerPoint],
                       nil];
    animation.values = array;
    [imageInside.layer addAnimation:animation forKey:@""];

    
}

- (void)resize{
    
    imageInside.frame = CGRectMake(0, 0, 30, 30);
    imageRorate.frame = CGRectMake(0, 0, 60, 60);
    closeButton.frame = CGRectMake(0, 20, 60, 60);
    CGSize size = [_message sizeWithFont:textLabel.font constrainedToSize:CGSizeMake(240, 60)];
    textLabel.frame = CGRectMake(0, 0, size.width, size.height);
    
    switch ([UIApplication sharedApplication].statusBarOrientation) {
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
        {
            if (CURRENTDEVICE >= 8.0){
                background.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
            }else
            {
                background.frame = CGRectMake(0, 0, SCREEN_HEIGHT, SCREEN_WIDTH);
            }
            
            imageRorate.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2 - size.height/2);
            imageInside.center = imageRorate.center;
            textLabel.center = CGPointMake(SCREEN_WIDTH/2, imageRorate.frame.origin.y + imageRorate.frame.size.height + size.height/2);
            
        }
        case UIDeviceOrientationPortraitUpsideDown:
        {

            background.frame = CGRectMake(0, 0, SCREEN_HEIGHT, SCREEN_HEIGHT);

            imageRorate.center = background.center;
            imageInside.center = imageRorate.center;
            textLabel.center = CGPointMake(SCREEN_HEIGHT/2, imageRorate.frame.origin.y + imageRorate.frame.size.height + size.height/2);
        }
            
        case UIDeviceOrientationPortrait:
        {
            
            background.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
           
            
            imageRorate.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2 - size.height/2);

            imageInside.center = imageRorate.center;
            textLabel.center = CGPointMake(SCREEN_WIDTH/2, imageRorate.frame.origin.y + imageRorate.frame.size.height + size.height/2);
        }
            break;
        default:
            break;
    }
    
}
+ (void)show{
    [[self class] show:nil needdismiss:NO];
}
+ (void)show:(NSString*)message needdismiss:(BOOL)dismiss{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [[self shared] setMessage:message];
        
        [[self shared] create];
        
        [[self shared] resize];
        
        if (dismiss) {
            [[self shared] performSelector:@selector(hide) withObject:nil afterDelay:15];
        }
        
    });
    
}

- (void)hide{
    _hidden = YES;
    if (textLabel.superview ) {
        [textLabel removeFromSuperview];
        textLabel = nil;
    }
    if (imageRorate.superview) {
        [imageRorate removeFromSuperview];
        imageRorate = nil;
    }
    if (imageInside.superview){
        [imageInside removeFromSuperview];
        imageInside = nil;
    }
    if (closeButton.superview){
        [closeButton removeFromSuperview];
        closeButton = nil;
    }
    if (Timer)
    {
        [Timer invalidate];
        Timer = nil;
    }

    if (background.superview){
        [background removeFromSuperview];
        background = nil;
    }
    
}

+ (void)dismiss{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[self shared] hide];
    });
}

@end
