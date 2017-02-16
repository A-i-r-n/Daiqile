//
//  ChargeListTableViewCell.h
//  Daiqile
//
//  Created by daiqile on 2016/11/17.
//  Copyright © 2016年 com.daiqile.daiqile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChargeListTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *type;
@property (strong, nonatomic) IBOutlet UILabel *time;
@property (strong, nonatomic) IBOutlet UILabel *moneyNub;
@property (strong, nonatomic) IBOutlet UILabel *state;

- (void)loadDataWith:(NSIndexPath *)indexPath withDataArray:(NSArray *)dataArray;

@end
