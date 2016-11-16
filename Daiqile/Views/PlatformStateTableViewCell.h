//
//  PlatformStateTableViewCell.h
//  Daiqile
//
//  Created by daiqile on 2016/11/16.
//  Copyright © 2016年 com.daiqile.daiqile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlatformStateTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *stateTile;
@property (strong, nonatomic) IBOutlet UILabel *stateTime;
@property (strong, nonatomic) IBOutlet UIImageView *stateImg;

@end
