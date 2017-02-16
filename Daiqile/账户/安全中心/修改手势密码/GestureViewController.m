
//
//  GestureViewController.m
//  juZu
//
//  Created by daiqile on 2017/1/3.
//  Copyright © 2017年 yangyukun. All rights reserved.
//

#import "GestureViewController.h"
#import "AppDelegate.h"
#import "CLLockVC.h"

@interface GestureViewController ()

@end

@implementation GestureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:13/255.0 green:52/255.0 blue:89/255.0 alpha:1];
    self.navigationController.navigationBar.hidden = YES;
    [self setGesture];
}


- (void)setGesture
{
    BOOL hasPwd = [CLLockVC hasPwd];
    
    if(hasPwd){
        //验证密码
        [CLLockVC showVerifyLockVCInVC:self forgetPwdBlock:^{
            //NSLog(@"忘记密码");
        } successBlock:^(CLLockVC *lockVC, NSString *pwd) {
            //NSLog(@"密码正确");
            [lockVC dismiss:1.0f];
             [((AppDelegate *)[UIApplication sharedApplication].delegate) setupTabBar];
        }];
        
    }else{
        //设置密码
        [CLLockVC showSettingLockVCInVC:self successBlock:^(CLLockVC *lockVC, NSString *pwd) {
            
            
            //NSLog(@"密码设置成功");
            [lockVC dismiss:1.0f];
            [((AppDelegate *)[UIApplication sharedApplication].delegate) setupTabBar];            
        }];
    }

}

@end
