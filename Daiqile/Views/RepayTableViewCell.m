//
//  RepayTableViewCell.m
//  Daiqile
//
//  Created by daiqile on 2017/2/9.
//  Copyright © 2017年 com.daiqile.daiqile. All rights reserved.
//

#import "RepayTableViewCell.h"

@implementation RepayTableViewCell

- (void)setModel:(RepayModel *)model
{

    //借款人
    _borrowTitle.text = model.borrow_name;
    
    //期数  (order+1)/( time_limit)期数
    _date.text = [NSString stringWithFormat:@"%@/%@",[NSString stringWithFormat:@"%d",[model.order intValue]],model.time_limit];
    
    //还款本息
    _apr.text = model.repayment_account;
    
    //到期日
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[model.repayment_time intValue]];
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *destDateString=[dateFormatter stringFromDate:confromTimesp];
    
    _endTime.text = destDateString;

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
