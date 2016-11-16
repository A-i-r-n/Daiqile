//
//  AirTabBarController.m
//  Daiqile
//
//  Created by daiqile on 2016/11/14.
//  Copyright © 2016年 com.daiqile.daiqile. All rights reserved.
//

#import "AirTabBarController.h"
#import "AirNavigationController.h"

#import "MainViewController.h"
#import "InvestViewController.h"
#import "MoreViewController.h"
#import "AccountViewController.h"

@interface AirTabBarController ()


@end

@implementation AirTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加所有的子控制器
    [self setupChildVcs];
    
    [self setupItem];

}

- (void)setupChildVcs
{

    [self setupChildVc:[[MainViewController alloc] init] title:@"首页" image:@"icon_nav_home" selectedImage:@"icon_nav_home"];
    
    [self setupChildVc:[[InvestViewController alloc] init] title:@"投资" image:@"icon_nav_invest" selectedImage:@"icon_nav_invest"];
    
    
    [self setupChildVc:[[AccountViewController alloc] init] title:@"账户" image:@"icon_nav_user" selectedImage:@"icon_nav_user"];
    
    [self setupChildVc:[[MoreViewController alloc] init] title:@"更多" image:@"icon_nav_more" selectedImage:@"icon_nav_more"];
    
    
}

- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    AirNavigationController *nav = [[AirNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
    
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:image];
    nav.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
}

/**
 * 设置item属性
 */
- (void)setupItem
{

    //设置tabbar背景色
    [[UITabBar appearance] setBarTintColor:MainColor];

    
    // UIControlStateNormal状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    // 文字颜色
    normalAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    // 文字大小
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    
    // UIControlStateSelected状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    // 文字颜色
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    
    // 统一给所有的UITabBarItem设置文字属性
    // 只有后面带有UI_APPEARANCE_SELECTOR的属性或方法, 才可以通过appearance对象来统一设置
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

@end
