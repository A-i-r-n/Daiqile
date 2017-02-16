//
//  fuyouRechargeViewController.m
//  HuLianDai
//
//  Created by daiqile on 16/4/29.
//  Copyright © 2016年 yangyukun. All rights reserved.
//

#import "fuyouRechargeViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "WebViewJavascriptBridge.h"
#import "D3Generator.h"
@interface fuyouRechargeViewController ()<UIWebViewDelegate>
{
    UIActivityIndicatorView *activityIndicator;
}

@property(nonatomic,strong)WebViewJavascriptBridge *bridge;

@end

@implementation fuyouRechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"充值";

    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    webView.delegate = self;
    //    webView.scalesPageToFit = YES;
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:self.money]];
    [self.view addSubview: webView];
    [webView loadRequest:request];
    [self addRoute:webView];
    
    
}
-(void)addRoute:(UIWebView*)webView{
    _bridge = [WebViewJavascriptBridge bridgeForWebView:webView webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"ObjC received message from JS: %@", data);
        responseCallback(@"报告: IOS收到！！！");
        
        [D3Generator createViewControllerWithDictAndPush:data];
        //        或者:
        //        UIViewController *vc = [D3Generator createViewControllerWithDict:data];
        //        [self.navigationController pushViewController:vc animated:YES];
        
        //        var data = {'className': 'AccountCenterViewController'};
        //        window.WebViewJavascriptBridge.send(data);
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (void )webViewDidStartLoad:(UIWebView  *)webView{//网页开始加载的时候调用
    //创建UIActivityIndicatorView背底半透明View
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight+64)];
    [view setTag:108];
    [view setBackgroundColor:[UIColor blackColor]];
    [view setAlpha:0.5];
    [self.view addSubview:view];
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
    [activityIndicator setCenter:view.center];
    [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [view addSubview:activityIndicator];
    
    [activityIndicator startAnimating];
    
}
- (void )webViewDidFinishLoad:(UIWebView  *)webView{// 网页加载完成的时候调用
    [activityIndicator stopAnimating];
    UIView *view = (UIView*)[self.view viewWithTag:108];
    [view removeFromSuperview];
    
}
- (void)webView:(UIWebView *)webView  didFailLoadWithError:(NSError *)error{//网页加载错误的时候调用
    [activityIndicator stopAnimating];
    UIView *view = (UIView*)[self.view viewWithTag:108];
    [view removeFromSuperview];
}

@end
