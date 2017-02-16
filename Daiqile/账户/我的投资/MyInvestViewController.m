//
//  MyInvestViewController.m
//  Daiqile
//
//  Created by daiqile on 2016/11/16.
//  Copyright © 2016年 com.daiqile.daiqile. All rights reserved.
//

#import "MyInvestViewController.h"
#import "MyInvestTableViewCell.h"
#import "InvestModel.h"

#define MyInvestCell @"MyInvestTableViewCell"

@interface MyInvestViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    int _pageNum;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *investArray;//投资数组

@end

@implementation MyInvestViewController

- (NSMutableArray *)investArray
{
    if (!_investArray) {

        _investArray = [NSMutableArray array];
        
    }
    return _investArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _pageNum = 1;
    
    self.navigationItem.title = @"我的投资";
    
    //获取数据
    [self getData];
    
    //注册cell
    [self registCell];
}

- (void)getData
{
    //第一次加载
    [self loadData];
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(fresh)];
}

- (void)loadData
{
    NSDictionary *parameters=@{@"user_id": UserDefaultGetValue(@"userId")};
    [HttpManager sendPostGetArrayWithDictionary:parameters withUrl:@"port/getTenderList.php?dcode=7d5372bbcd6cc79f1bd71211f092622e" Success:^(NSArray *responseData) {
        
        for (NSDictionary *dict in responseData) {
            
            [self.investArray addObject:[InvestModel parseWithDictionary:dict]];
            
        }
        
        [_tableView reloadData];
        
    } Failed:^(NSError *error) {
        
        [LCProgressHUD showMessage:@"网络请求出错,请联系管理员!"];
        
    }];
    
}

- (void)fresh
{
    
    _pageNum += 1;
    
    NSDictionary *parameters=@{@"pageNum":[NSString stringWithFormat:@"%d",_pageNum],@"userId": UserDefaultGetValue(@"userId")};
    
    [HttpManager sendPostRequestWithDictionary:parameters withUrl:@"port/getBorrowSuccess.php" Success:^(NSDictionary *responseData) {
        
        NSArray *array = responseData[@"list"];
        
        if (array.count > 0) {
            
            for (NSDictionary *dict in array) {
                
                [self.investArray addObject:[InvestModel parseWithDictionary:dict]];
                
            }
            
        }else{
            
            [LCProgressHUD showMessage:@"没有更多数据了"];
            
        }
        
        [_tableView reloadData];

        [_tableView.mj_footer endRefreshing];
        
    } Failed:^(NSError *error) {
        
        [LCProgressHUD showMessage:@"网络请求出错,请联系管理员!"];
        
    }];
    
}

- (void)registCell
{
    [_tableView registerNib:[UINib nibWithNibName:@"MyInvestTableViewCell" bundle:nil] forCellReuseIdentifier:MyInvestCell];
}

#pragma mark tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.investArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyInvestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyInvestCell];
    
    InvestModel *model = self.investArray[indexPath.section];
    
    cell.model = model;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


@end
