
//
//  MyInvestTableViewCell.m
//  Daiqile
//
//  Created by daiqile on 2016/11/18.
//  Copyright © 2016年 com.daiqile.daiqile. All rights reserved.
//

#import "MyInvestTableViewCell.h"


@implementation MyInvestTableViewCell

//借款
- (void)setModel:(InvestModel *)model
{
    _biaoName.text = model.borrow_name;
    
    _money.text = model.tender_account;
    
    _time.text = model.addtime;
    
    _benXi.text = model.repayment_account;
}

//待收
- (void)setCollectionModel:(CollectionModel *)collectionModel
{
    _biaoName.text = collectionModel.borrow_name;
    
    _money.text = [NSString stringWithFormat:@"%d/%@",[collectionModel.order intValue]+1,collectionModel.time_limit];
    
    _time.text = collectionModel.addtime;
    
    _benXi.text = collectionModel.repay_account;
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
