//
//  ChargeListViewController.m
//  Daiqile
//
//  Created by daiqile on 2016/11/17.
//  Copyright © 2016年 com.daiqile.daiqile. All rights reserved.
//

#import "ChargeListViewController.h"
#import "ChargeListTableViewCell.h"

@interface ChargeListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation ChargeListViewController

//- (void)setLeftImg:(UIImage *)leftImg
//{
//    _leftImg = leftImg;
//    UIImageView *imageView = [[UIImageView alloc]initWithImage:leftImg];
//    self.leftView = imageView;
//    self.leftViewMode = UITextFieldViewModeAlways;
//}

//- (void)setIndexPath:(NSIndexPath *)indexPath
//{
//    _indexPath = indexPath;
//}
//
//- (void)setDataArray:(NSArray *)dataArray
//{
//    if (!_dataArray) {
//        _dataArray = [[NSArray alloc]init];
//    }
//    _dataArray = dataArray;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //装model
    _dataArray = @[@"投资",@"充值",@"提现"];
    
    [self createTableView];
    [self registCell];
}

- (void)createTableView
{
    self.view.backgroundColor = [UIColor clearColor];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    _tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"all_bg"]];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [_tableView setSeparatorInset:UIEdgeInsetsZero];
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
}

- (void)registCell
{
    [_tableView registerNib:[UINib nibWithNibName:@"ChargeListTableViewCell" bundle:nil] forCellReuseIdentifier:@"listCell"];
}

#pragma mark tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Ratio(60);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChargeListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listCell"];
    [cell loadDataWith:indexPath withDataArray:_dataArray];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"indexPath = %@",indexPath);
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

@end
