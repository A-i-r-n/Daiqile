//
//  RepayDetailViewController.m
//  Daiqile
//
//  Created by daiqile on 2017/2/9.
//  Copyright © 2017年 com.daiqile.daiqile. All rights reserved.
//

#import "RepayDetailViewController.h"
#import "RepayTableViewCell.h"
#import "RepayModel.h"

#define RepayCell @"RepayTableViewCell"
@interface RepayDetailViewController ()

{
    long _pageNum;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *repayArray;

@end

@implementation RepayDetailViewController

- (NSMutableArray *)repayArray
{
    if (!_repayArray) {
        
        _repayArray = [NSMutableArray array];
        
    }
    
    return _repayArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"还款计划";
    
    _pageNum = 1;
    
    //注册单元格
    [self registCell];
    
    //请求数据
    [self refresh];
}

- (void)refresh
{
    [self headerRefresh];
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreh)];
}

//下拉
- (void)headerRefresh
{
    [HttpManager sendGetRequestWithDictionary:nil withUrl:[NSString stringWithFormat:@"port/getRepamentList.php?user_id=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userId" ]] Success:^(NSDictionary *responseData) {
        
        NSArray *array = [responseData objectForKey:@"list"];
        
        for (NSDictionary *dict in array) {
            
            [self.repayArray addObject:[RepayModel parseWithDictionary:dict]];
            
        }
        
        [_tableView reloadData];
    
    } Failed:^(NSError *error) {
        
        [LCProgressHUD showMessage:@"网络请求出错,请联系管理员!"];
        
    }];

}

//上拉
- (void)footerRefreh
{
    _pageNum = _pageNum+1;
    
    NSDictionary *parameters=@{@"currentPage":[NSString stringWithFormat:@"%ld",_pageNum],@"user_id": [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"]};
    
    [HttpManager sendGetRequestWithDictionary:parameters withUrl:@"port/getRepamentList.php" Success:^(NSDictionary *responseData) {
        
        NSArray *array = [responseData objectForKey:@"list"];
        
        if (array.count > 0) {
            for (NSDictionary *dict in array) {
                
                [self.repayArray addObject:[RepayModel parseWithDictionary:dict]];
                
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

- (void)registCell
{
     _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    [_tableView registerNib:[UINib nibWithNibName:@"RepayTableViewCell" bundle:nil] forCellReuseIdentifier:RepayCell];
}

#pragma mark tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.repayArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RepayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RepayCell];
    
    RepayModel *model = self.repayArray[indexPath.row];
    
    cell.model = model;
    
    return cell;
}
@end
