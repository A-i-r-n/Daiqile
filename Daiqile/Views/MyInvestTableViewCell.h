//
//  MyInvestTableViewCell.h
//  Daiqile
//
//  Created by daiqile on 2016/11/18.
//  Copyright © 2016年 com.daiqile.daiqile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InvestModel.h"
#import "CollectionModel.h"

@interface MyInvestTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *biaoName;//标名
@property (strong, nonatomic) IBOutlet UILabel *money;//投资金额
@property (strong, nonatomic) IBOutlet UILabel *time;//投资时间
@property (strong, nonatomic) IBOutlet UILabel *benXi;//应收本息

@property (nonatomic,strong) InvestModel *model;

@property (nonatomic,strong) CollectionModel *collectionModel;

@end
