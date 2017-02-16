
//
//  InvestViewController.m
//  Daiqile
//
//  Created by daiqile on 2016/11/14.
//  Copyright © 2016年 com.daiqile.daiqile. All rights reserved.
//

#import "InvestViewController.h"

#import "InvestTableViewCell.h"
#import "StoreTableViewCell.h"
#import "Feiyangyidai.h"
#import "DetailViewController.h"
#import "LoginViewController.h"


#define StoreCell @"StoreTableViewCell"

@interface InvestViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    long _pageNum;
}
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *modelArray;//所有model的数组
@property (strong, nonatomic) NSMutableArray *refreshArray;//下拉请求数组

@end

@implementation InvestViewController

- (NSMutableArray *)modelArray
{
    if (!_modelArray) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}

- (NSMutableArray *)refreshArray
{
    if (!_refreshArray) {
        _refreshArray = [NSMutableArray array];
    }
    return _refreshArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor clearColor];
    
    
    self.navigationItem.title = @"投资";
    [self createTableView];
    [self registCell];
    [self refresh];
    
}

- (void)refresh
{
    [self updataHttpRequest];
    
    //下拉
    
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(updataHttpRequest)];
    
    //上拉
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshHttpRequest)];
}

//下拉刷新
- (void)updataHttpRequest
{
    _pageNum = 1;
    
    [self.modelArray removeAllObjects];
    
    [HttpManager sendGetRequestWithDictionary:nil withUrl:[NSString stringWithFormat:@"port/getBorrowList.php?is_new=0&pageSize=10&page=%ld",_pageNum] Success:^(NSDictionary *responseData) {
        
        NSArray *array = [responseData objectForKey:@"list"];
        
        for (NSDictionary *dict in array) {
            
            [self.modelArray addObject:[[Feiyangyidai alloc] initWithDict:dict]];
            
        }
        
        [_tableView reloadData];
        [_tableView.mj_header endRefreshing];
    } Failed:^(NSError *error) {
      
       [LCProgressHUD showMessage:@"网络请求出错,请联系管理员!"];
        
    }];
}

//上拉加载
- (void)refreshHttpRequest
{
    _pageNum += 1;
    
    [HttpManager sendGetRequestWithDictionary:nil withUrl:[NSString stringWithFormat:@"port/getBorrowList.php?is_new=0&pageSize=10&page=%ld",(long)_pageNum] Success:^(NSDictionary *responseData) {
        
        NSArray *array = [responseData objectForKey:@"list"];
        
        if (array.count != 0) {
            
            for (NSDictionary *dict in array) {
                
                [self.refreshArray addObject:[[Feiyangyidai alloc] initWithDict:dict]];
                
                [self.modelArray addObjectsFromArray:self.refreshArray];
            }

        }else{
            
            [LCProgressHUD showMessage:@"没有更多数据啦!"];
        
        }
        
        [_tableView reloadData];
        [_tableView.mj_footer endRefreshing];
    } Failed:^(NSError *error) {
        
        [LCProgressHUD showMessage:@"网络请求出错,请联系管理员!"];
        
    }];

}


#pragma mark tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.modelArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 8;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Ratio(210);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:StoreCell];
    
    [cell loadDataWtihArray:self.modelArray withIndexPath:indexPath];
    
    [cell.buyClick addTarget:self action:@selector(buyClick:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)buyClick:(UIButton *)button
{
    //找到对应model
    Feiyangyidai *model = self.modelArray[button.tag];
    
    if (LOGINSTATUS) {
        
        DetailViewController *detail = [[DetailViewController alloc]init];
        
        detail.model = model;
        
        PUSH(detail);
        
    }else{
        
        LoginViewController *login = [[LoginViewController alloc]init];
        
        PUSH(login);
        
    }
}

#pragma mark 注册cell
- (void)registCell
{
    [_tableView registerNib:[UINib nibWithNibName:@"StoreTableViewCell" bundle:nil] forCellReuseIdentifier:StoreCell];
}

#pragma mark 创建tableView
- (void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    //_tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"all_bg"]];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //_tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
}


@end
