//
//  MainViewController.m
//  Daiqile
//
//  Created by daiqile on 2016/11/14.
//  Copyright © 2016年 com.daiqile.daiqile. All rights reserved.
//

#import "MainViewController.h"
#import "SDCycleScrollView.h"
#import "ArcView.h"
#import "Feiyangyidai.h"
#import "DetailViewController.h"
#import "LoginViewController.h"
@interface MainViewController ()
{
    Feiyangyidai *model;
}
@property (strong, nonatomic) IBOutlet SDCycleScrollView *cycleScroll;
@property (strong, nonatomic) ArcView *arcView;
@property (strong, nonatomic) IBOutlet UIView *progressView;


@end

@implementation MainViewController

- (ArcView *)arcView{
    
    if (!_arcView) {
        
        _arcView = [[ArcView alloc]initWithFrame:_progressView.bounds];
        
        [_progressView addSubview:_arcView];
        
    }
    
    return _arcView;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"聚租金服";
    
    _cycleScroll.localizationImageNamesGroup = @[@"banner1",@"banner2",@"banner3"];
 
    [self arcView];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self sendHttpResquest];
}


//网络请求
- (void)sendHttpResquest
{
    [HttpManager sendGetRequestWithDictionary:nil withUrl:@"port/getBorrowList.php" Success:^(NSDictionary *responseData) {
        
        NSDictionary *dict = [[responseData objectForKey:@"list"] firstObject];
        
        model = [[Feiyangyidai alloc]initWithDict:dict];
        
        self.arcView.model = model;
    
    } Failed:^(NSError *error) {
        
        [LCProgressHUD showMessage:@"网络请求出错,请联系管理员!"];
        
    }];

}

//立即投标
- (IBAction)Toubiao:(id)sender
{
    if (!LOGINSTATUS) {
        
        LoginViewController *login = [[LoginViewController alloc]init];
        
        PUSH(login);
        
    }else{
        
        DetailViewController *detail = [[DetailViewController alloc]init];
        
        detail.model = model;
        
        PUSH(detail);
    }
    
}


@end
