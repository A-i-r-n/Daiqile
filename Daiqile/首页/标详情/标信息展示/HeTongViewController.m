//
//  HeTongViewController.m
//  juZu
//
//  Created by daiqile on 2017/1/4.
//  Copyright © 2017年 yangyukun. All rights reserved.
//

#import "HeTongViewController.h"

@interface HeTongViewController ()<UIWebViewDelegate>

@end

@implementation HeTongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    self.title = @"项目图片";
   
    UIWebView *detailView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    
    detailView.delegate = self;
    
    detailView.scalesPageToFit = NO;
    
    detailView.backgroundColor =[UIColor whiteColor];
    
    detailView.scrollView.showsVerticalScrollIndicator = NO;
    
    NSString *str1 = [ToolModel filterHTML:self.model.pro_pic];
    
    [detailView setFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    
    [detailView loadHTMLString:str1 baseURL:nil];
    
    [self.view addSubview:detailView];

    
    
}



@end
