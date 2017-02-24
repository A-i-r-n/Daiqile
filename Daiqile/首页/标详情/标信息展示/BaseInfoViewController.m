
//
//  BaseInfoViewController.m
//  juZu
//
//  Created by daiqile on 2017/1/4.
//  Copyright © 2017年 yangyukun. All rights reserved.
//

#import "BaseInfoViewController.h"

@interface BaseInfoViewController ()<UIWebViewDelegate>
{
    NSMutableArray *_imageURLArr;
    NSMutableArray *_imageArr;
    UIScrollView *scrollView;
}
@end

@implementation BaseInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"合同图片";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _imageURLArr=[[NSMutableArray alloc] init];
    
    _imageArr=[[NSMutableArray alloc] init];
    
    scrollView = [[UIScrollView alloc] init];
    
    scrollView.frame = CGRectMake(0, 0, ScreenWidth , ScreenHeight);
    
    scrollView.showsHorizontalScrollIndicator = NO;

    [self.view addSubview:scrollView];
    
    
    //图片地址
    if (self.model.contract_pic == nil) {
        
    }else{
        
        for (NSDictionary *dic in self.model.contract_pic) {
            
                [_imageURLArr addObject:dic[@"litpic"]];
  
        }
    }
    
    scrollView.contentSize=CGSizeMake(ScreenWidth, 150*_imageURLArr.count);
  __block  int a=0;
    
    __block CGFloat Contentheight=0;
    //请求图片
    for (NSString *imageUrlStr in _imageURLArr) {
        AFHTTPSessionManager *manger=[AFHTTPSessionManager manager];
        manger.responseSerializer=[AFHTTPResponseSerializer serializer];
        manger.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"image/jpeg", nil];
        [manger GET:[ToolModel linkUrl:imageUrlStr] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            UIImage *image=[UIImage imageWithData:responseObject];
            
            //创建图片
            
            UIImageView *imageV=[[UIImageView alloc] initWithFrame:CGRectMake(0, Contentheight, ScreenWidth, ScreenWidth/image.size.width*image.size.height)];
            imageV.backgroundColor=[UIColor redColor];
            imageV.image=image;
            
            [scrollView addSubview:imageV];
            
            a++;
            
            Contentheight+=imageV.frame.size.height;
            
            scrollView.contentSize=CGSizeMake(ScreenWidth, Contentheight);
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [LCProgressHUD showMessage:@"网络请求出错,请联系管理员!"];
            
        }];

        
    }
    
    

}











@end
