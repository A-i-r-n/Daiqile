//
//  DetailViewController.m
//  Daiqile
//
//  Created by daiqile on 2017/2/7.
//  Copyright © 2017年 com.daiqile.daiqile. All rights reserved.
//

#import "DetailViewController.h"
#import "BiaoTouTableViewCell.h"
#import "JieKuanMiaoShuViewController.h"
#import "BaseInfoViewController.h"
#import "HeTongViewController.h"
#import "TenderRecordViewController.h"
#import "RepayDetailViewController.h"


//#import "TouBiaoRecordViewController.h"
//#import "HuanKuanXiangQingViewController.h"


#define BiaoTouCell @"BiaoTouTableViewCell"

@interface DetailViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"项目详情";
    
    [self registCell];
}

- (void)registCell
{
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_tableView registerNib:[UINib nibWithNibName:@"BiaoTouTableViewCell" bundle:nil] forCellReuseIdentifier:BiaoTouCell];
}


#pragma mark tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Ratio(710);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BiaoTouTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BiaoTouCell];
    
    [cell loadDataWithModel:self.model];
    
    //信息披露
    [cell.xinXiPiLu addTarget:self action:@selector(xinXiPiLuClick) forControlEvents:UIControlEventTouchUpInside];
    
     //合同图片
     [cell.heTongTuPian addTarget:self action:@selector(heTongTuPianClick) forControlEvents:UIControlEventTouchUpInside];
    
     //项目图片
     [cell.xiangMuTuPian addTarget:self action:@selector(xiangMuTuPianClick) forControlEvents:UIControlEventTouchUpInside];
    
     //投标记录
     [cell.touBiaoJiLu addTarget:self action:@selector(touBiaoJiLuClick) forControlEvents:UIControlEventTouchUpInside];
    
     //还款计划
     [cell.huanKuanJiHua addTarget:self action:@selector(huanKuanJiHuaClick) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

//信息披露
- (void)xinXiPiLuClick
{
    JieKuanMiaoShuViewController *miaoShu = [[JieKuanMiaoShuViewController alloc]init];
    
    miaoShu.model = self.model;
    
    PUSH(miaoShu);
}

//合同图片
- (void)heTongTuPianClick
{
    BaseInfoViewController *info = [[BaseInfoViewController alloc]init];
    
    info.model = self.model;
    
    PUSH(info);
}

//项目图片
- (void)xiangMuTuPianClick
{
    HeTongViewController *heTong = [[HeTongViewController alloc]init];
    
    heTong.model = self.model;
    
    PUSH(heTong);
}

//投标记录
- (void)touBiaoJiLuClick
{
    TenderRecordViewController *record = [[TenderRecordViewController alloc]init];
    
    record.model = self.model;
    
    PUSH(record);
}

//还款计划
- (void)huanKuanJiHuaClick
{
    RepayDetailViewController *repay = [[RepayDetailViewController alloc]init];
    
    repay.model = self.model;
    
    PUSH(repay);
}


//输入框处于编辑状态
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
   
    
}



@end
