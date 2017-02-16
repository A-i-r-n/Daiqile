//
//  TenderTableViewCell.m
//  Daiqile
//
//  Created by daiqile on 2017/2/9.
//  Copyright © 2017年 com.daiqile.daiqile. All rights reserved.
//

#import "TenderTableViewCell.h"

@implementation TenderTableViewCell

- (void)setModel:(TenderModel *)model
{
    //投资人
    _tenderName.text = [NSString stringWithFormat:@"%@***",[model.username substringToIndex:2]];
    
    //年利率
    _apr.text = [NSString stringWithFormat:@"%@%%",model.apr];
    
    //投资金额
    _tenderMoney.text = [NSString stringWithFormat:@"%.2f",[model.money floatValue]];
    
    //可用金额
    _validMoney.text = [NSString stringWithFormat:@"%.2f",[model.tender_account floatValue]];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[model.addtime intValue]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"yy/MM/dd"];
    
    NSString *destDateString = [dateFormatter stringFromDate:confromTimesp];
    //时间
    _time.text = destDateString;
    
    //状态
    if ([model.money isEqualToString:model.tender_account]) {
        _status.text = @"全部通过";
    }else{
        _status.text = @"部分通过";
    }

}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
