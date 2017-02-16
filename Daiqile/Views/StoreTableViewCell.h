//
//  StoreTableViewCell.h
//  juZu
//
//  Created by daiqile on 2017/1/3.
//  Copyright © 2017年 yangyukun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bgImg;//背景图片
@property (strong, nonatomic) IBOutlet UILabel *name;//标名
@property (strong, nonatomic) IBOutlet UILabel *time;//当前时间
@property (strong, nonatomic) IBOutlet UILabel *lilv;//利率
@property (strong, nonatomic) IBOutlet UILabel *expires;//还款期限
@property (strong, nonatomic) IBOutlet UIProgressView *press;//进度
@property (strong, nonatomic) IBOutlet UILabel *pressNum;//进度数
@property (strong, nonatomic) IBOutlet UIButton *buyClick;//立即投标
@property (strong, nonatomic) IBOutlet UILabel *count;
@property (weak, nonatomic) IBOutlet UILabel *type;


- (void)loadDataWtihArray:(NSArray *)dataArray withIndexPath:(NSIndexPath *)indexPath;

@end
