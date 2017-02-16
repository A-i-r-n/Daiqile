//
//  TenderTableViewCell.h
//  Daiqile
//
//  Created by daiqile on 2017/2/9.
//  Copyright © 2017年 com.daiqile.daiqile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TenderModel.h"
@interface TenderTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *tenderName;//投标人
@property (strong, nonatomic) IBOutlet UILabel *apr;//年利率
@property (strong, nonatomic) IBOutlet UILabel *tenderMoney;//投标金额
@property (strong, nonatomic) IBOutlet UILabel *validMoney;//有效金额
@property (strong, nonatomic) IBOutlet UILabel *time;//时间
@property (strong, nonatomic) IBOutlet UILabel *status;//状态

@property (nonatomic,strong) TenderModel *model;

@end
