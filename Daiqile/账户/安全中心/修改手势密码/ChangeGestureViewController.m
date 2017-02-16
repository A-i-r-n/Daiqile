//
//  ChangeGestureViewController.m
//  Daiqile
//
//  Created by daiqile on 2017/2/14.
//  Copyright © 2017年 com.daiqile.daiqile. All rights reserved.
//

#import "ChangeGestureViewController.h"
#import "AppDelegate.h"
#import "CLLockVC.h"


@interface ChangeGestureViewController ()

@end

@implementation ChangeGestureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.title = @"修改手势密码";
    
    self.view.backgroundColor = [UIColor colorWithRed:13/255.0 green:52/255.0 blue:89/255.0 alpha:1];
    self.navigationController.navigationBar.hidden = YES;
    [self setGesture];
}

- (void)setGesture
{
    BOOL hasPwd = [CLLockVC hasPwd];
    
    if(!hasPwd){
        
        [CLLockVC showSettingLockVCInVC:self successBlock:^(CLLockVC *lockVC, NSString *pwd) {
            [((AppDelegate *)[UIApplication sharedApplication].delegate) setupTabBar];

            [lockVC dismiss:1.0f];
        }];
        
    }else {
        
        [CLLockVC showModifyLockVCInVC:self successBlock:^(CLLockVC *lockVC, NSString *pwd) {
            
            [((AppDelegate *)[UIApplication sharedApplication].delegate) setupTabBar];

            [lockVC dismiss:.5f];
        }];
    }
}


@end
