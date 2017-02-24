//
//  StoreTableViewCell.m
//  juZu
//
//  Created by daiqile on 2017/1/3.
//  Copyright © 2017年 yangyukun. All rights reserved.
//

#import "StoreTableViewCell.h"
#import "Feiyangyidai.h"
#import "UIImageView+WebCache.h"
@implementation StoreTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)loadDataWtihArray:(NSArray *)dataArray withIndexPath:(NSIndexPath *)indexPath
{
    
    
    Feiyangyidai *model = dataArray[indexPath.section];
    
    _name.text = model.name;
    _time.text = model.time;
    _lilv.text = [NSString stringWithFormat:@"%.2lf%%",model.apr];
    
    if (model.is_ti != nil && [model.is_ti isEqualToString:@"1"]) {
        _type.text = @"新手标";
    }else if (model.is_fast != nil && [model.is_fast isEqualToString:@"1"]){
        _type.text = @"聚租优选";
    }else{
        _type.text = @"众享计划";

    }
    
    
    if ([model.isDay isEqualToString:@"1"]) {
        _expires.text = [NSString stringWithFormat:@"%@天", model.time_limit_day];
    }else{
        _expires.text = [NSString stringWithFormat:@"%@月", model.time_limit];
    }
    
    float epr = model.account_yes/model.account;
    
    _buyClick.tag = indexPath.section;
    
    _press.progress = epr;
    
    _pressNum.text = [NSString stringWithFormat:@"%.2f%%",epr*100];
    
    _count.text = [NSString stringWithFormat:@"¥ %.2f",model.account];
    
    [_bgImg sd_setImageWithURL:[NSURL URLWithString:[ToolModel linkUrl:model.project_pic2]] placeholderImage:[UIImage imageNamed:@""]];
    
    if (model.account == model.account_yes) {
        
        [_buyClick setTitle:@"已满标" forState:UIControlStateNormal];
        
        _buyClick.backgroundColor = [UIColor lightGrayColor];
        
    }
    
    
}


//- (CGFloat)getCellHeightWith:(NSMutableArray *)dataArray with:(NSIndexPath *)indexPath
//{
// 
//    Feiyangyidai *model = dataArray[indexPath.section];
//    
//}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
