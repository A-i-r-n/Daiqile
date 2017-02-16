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

@interface AirTabBarController ()<UITabBarDelegate,UITabBarControllerDelegate>


@end

@implementation AirTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置代理
    //self.delegate = self;
    
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


#pragma mark - UITabBarControllerDelegate

//这个方法根据官方文档解释意思就是点击下面的tabBar的按钮时候  根据BOOL值来判断是否处于可继续点击状态

//- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController NS_AVAILABLE_IOS(3_0){
//    
//    if (viewController.tabBarItem.tag == 3 ){
//        
//        if (LOGINSTATUS) {
//            
//            LoginViewController *loginVC = [[LoginViewController alloc] init];
//            
//            UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:loginVC];
//            
//            [self presentViewController:navi animated:YES completion:^{
//                
//            }];
//            
//            return NO;
//            
//        }else{
//            
//            return YES;
//            
//        }
//        
//    }else{
//        
//        return YES;
//    }
//    
//}
- (void)presentLeftMenuViewController{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}



@end
