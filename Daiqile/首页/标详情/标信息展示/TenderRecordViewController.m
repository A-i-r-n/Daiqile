//
//  TenderRecordViewController.m
//  Daiqile
//
//  Created by daiqile on 2017/2/9.
//  Copyright © 2017年 com.daiqile.daiqile. All rights reserved.
//

#import "TenderRecordViewController.h"
#import "TenderTableViewCell.h"
#import "TenderModel.h"

#define TenderCell @"TenderTableViewCell"
@interface TenderRecordViewController ()

{
    long _pageNum;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *tenderArray;

@end

@implementation TenderRecordViewController

- (NSMutableArray *)tenderArray
{
    if (!_tenderArray) {
        _tenderArray = [NSMutableArray array];
    }
    return _tenderArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"投标记录";
    
    _pageNum = 1;
    
    //注册cell
    [self registCell];
    
    //网络请求
    [self refresh];
    
}

- (void)registCell
{
     _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    [_tableView registerNib:[UINib nibWithNibName:@"TenderTableViewCell" bundle:nil] forCellReuseIdentifier:TenderCell];
}


- (void)refresh
{
    [self headerRefresh];
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreh)];
}

//下拉
- (void)headerRefresh
{
    
    [HttpManager sendGetRequestWithDictionary:nil withUrl:[NSString stringWithFormat:@"port/getTenderLogList.php?borrow_id=%@",self.model.borrowID ] Success:^(NSDictionary *responseData) {
        
        NSArray *array = [responseData objectForKey:@"list"];
        for (NSDictionary *dict in array) {
            
            [self.tenderArray addObject:[TenderModel parseWithDictionary:dict]];
            
        }
        
        [_tableView reloadData];
        
        [_tableView.mj_footer endRefreshing];
        
    } Failed:^(NSError *error) {
        
    }];
    
}

//上拉
- (void)footerRefreh
{
    _pageNum = _pageNum+1;
    
    NSDictionary *parameters=@{@"currentPage":[NSString stringWithFormat:@"%ld",_pageNum],@"borrow_id":self.model.borrowID};
    
    [HttpManager sendGetRequestWithDictionary:parameters withUrl:@"port/getRepamentList.php" Success:^(NSDictionary *responseData) {
        
        NSArray *array = [responseData objectForKey:@"list"];
        if (array.count > 0) {
            
            for (NSDictionary *dict in array) {
                
                [self.tenderArray addObject:[TenderModel parseWithDictionary:dict]];
                
            }

        }else{
            [LCProgressHUD showMessage:@"没有更多数据啦!"];
        }
        
        [_tableView reloadData];
        
        [_tableView.mj_footer endRefreshing];
        
    } Failed:^(NSError *error) {
        
    }];
    
}

#pragma mark tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tenderArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TenderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TenderCell];
    
    TenderModel *model = self.tenderArray[indexPath.row];
    
    cell.model = model;
    
    return cell;
}


@end
