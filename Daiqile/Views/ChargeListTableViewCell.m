//
//  ChargeListTableViewCell.m
//  Daiqile
//
//  Created by daiqile on 2016/11/17.
//  Copyright © 2016年 com.daiqile.daiqile. All rights reserved.
//

#import "ChargeListTableViewCell.h"

@implementation ChargeListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)loadDataWith:(NSIndexPath *)indexPath withDataArray:(NSArray *)dataArray
{
    _type.text = dataArray[indexPath.row];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
