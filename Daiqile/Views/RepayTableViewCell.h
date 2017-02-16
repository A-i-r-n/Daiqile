//
//  RepayTableViewCell.h
//  Daiqile
//
//  Created by daiqile on 2017/2/9.
//  Copyright © 2017年 com.daiqile.daiqile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RepayModel.h"
@interface RepayTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *borrowTitle;//借入标题
@property (strong, nonatomic) IBOutlet UILabel *date;//期数
@property (strong, nonatomic) IBOutlet UILabel *apr;//还款本息
@property (strong, nonatomic) IBOutlet UILabel *endTime;//到期日

@property (nonatomic,strong) RepayModel *model;


@end
