//
//  ChargeRecordViewController.m
//  Daiqile
//
//  Created by daiqile on 2016/11/16.
//  Copyright © 2016年 com.daiqile.daiqile. All rights reserved.
//

#import "ChargeRecordViewController.h"
#import "ZJScrollPageView.h"
#import "ChargeListViewController.h"
#import "RechargeViewController.h"
#import "GetMoneyViewController.h"
#import "InvestRecordViewController.h"


#import "MyInvestTableViewCell.h"
#import "CollectionModel.h"

#define MyInvestCell @"MyInvestTableViewCell"

@interface ChargeRecordViewController ()<ZJScrollPageViewDelegate>
{
    
    int _pageNum;
    
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property(strong, nonatomic)NSArray<NSString *> *titles;

@property(strong, nonatomic)NSArray<UIViewController *> *childVcs;

@property (strong, nonatomic) NSMutableArray *recordArray;

@end

@implementation ChargeRecordViewController

- (NSMutableArray *)recordArray
{
    if (!_recordArray) {
        _recordArray = [NSMutableArray array];
    }
    return _recordArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"待收记录";
    
    _pageNum = 1;
    
    //多条可滑动 (根据项目需要使用)
    //[self createSlideView];
    
    [self getData];
    
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
    NSDictionary *parameters=@{@"user_id": UserDefaultGetValue(@"userId"),@"pageNum":@"1"};
    
    [HttpManager sendPostRequestWithDictionary:parameters withUrl:@"port/getBorrowGathering.php" Success:^(NSDictionary *responseData) {
        
        NSArray *array = responseData[@"list"];
        
        for (NSDictionary *dict in array) {
            
            [self.recordArray addObject:[CollectionModel parseWithDictionary:dict]];
            
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
    
    [HttpManager sendPostRequestWithDictionary:parameters withUrl:@"port/getBorrowGathering.php" Success:^(NSDictionary *responseData) {
        
        NSArray *array = responseData[@"list"];
        
        if (array.count > 0) {
            
            for (NSDictionary *dict in array) {
                
                [self.recordArray addObject:[CollectionModel parseWithDictionary:dict]];
                
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
    return self.recordArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyInvestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyInvestCell];
    
    CollectionModel *model = self.recordArray[indexPath.section];
    
    cell.collectionModel = model;
    
    return cell;
}





- (void)createSlideView
{
    //必要的设置, 如果没有设置可能导致内容显示不正常
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    //显示滚动条
    style.showLine = YES;
    //设置视图没有弹性
    style.contentViewBounces = NO;
    //自适应标题大小
    style.autoAdjustTitlesWidth = YES;
    style.scrollLineColor = MainColor;
    style.normalTitleColor = AssistColor;
    style.selectedTitleColor = MainColor;
    // 颜色渐变
    style.gradualChangeTitleColor = YES;
    style.scaleTitle = NO;
    self.titles = @[@"交易记录",
                    @"充值记录",
                    @"投资记录",
                    @"提现记录"
                    ];
    // 初始化
    ZJScrollPageView *scrollPageView = [[ZJScrollPageView alloc] initWithFrame:CGRectMake(0, NavBarHeight, ScreenWidth, ScreenHeight - NavBarHeight) segmentStyle:style titles:self.titles parentViewController:self delegate:self];
    [self.view addSubview:scrollPageView];
}

- (NSInteger)numberOfChildViewControllers {
    return self.titles.count;
}


- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    UIViewController<ZJScrollPageViewChildVcDelegate> *childVc = reuseViewController;
    if (childVc == nil) {
        
        childVc = [[ChargeListViewController alloc]init];

        
//        switch (index) {
//            case 0 :
//            {
//                //根据实际情况,来选择是否可以通过一个控制器(以传不同的参数的方式)来完成数据填充
//                childVc = [[ChargeListViewController alloc]init];
//            }
//                break;
//            case 1:
//            {
//                childVc = [[RechargeViewController alloc]init];
//            }
//                break;
//            case 2:
//            {
//                childVc = [[InvestRecordViewController alloc]init];
//            }
//                break;
//            case 3:
//            {
//                childVc = [[GetMoneyViewController alloc]init];
//            }
//                break;
//                
//            default:
//                
//                break;
//        }
    }
    
    return childVc;
}

- (BOOL)shouldAutomaticallyForwardAppearanceMethods {
    return NO;
}


@end
