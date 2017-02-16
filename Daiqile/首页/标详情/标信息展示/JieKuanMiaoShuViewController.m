//
//  JieKuanMiaoShuViewController.m
//  yunMai
//
//  Created by daiqile on 15/9/21.
//  Copyright (c) 2015年 yangyukun. All rights reserved.
//

#import "JieKuanMiaoShuViewController.h"

@interface JieKuanMiaoShuViewController ()<UIWebViewDelegate>

@end

@implementation JieKuanMiaoShuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"信息披露";
    
    UIWebView *detailView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    
    detailView.delegate = self;
    
    detailView.scalesPageToFit = NO;
    
    detailView.backgroundColor =[UIColor whiteColor];
    
    detailView.scrollView.showsVerticalScrollIndicator = NO;
    
    NSString *str1 = [ToolModel filterHTML:self.model.content];
    
    [detailView setFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    
    [detailView loadHTMLString:str1 baseURL:nil];
    
    [self.view addSubview:detailView];
    
}


- (void )webViewDidFinishLoad:(UIWebView  *)webView{// 网页加载完成的时候调用
    //[KVNProgress dismiss];
    
}
@end
