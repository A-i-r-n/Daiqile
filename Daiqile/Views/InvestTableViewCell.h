//
//  InvestTableViewCell.h
//  Daiqile
//
//  Created by daiqile on 2016/11/15.
//  Copyright © 2016年 com.daiqile.daiqile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InvestTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *investName;//标名
@property (strong, nonatomic) IBOutlet UILabel *ratio;//回报率
@property (strong, nonatomic) IBOutlet UILabel *monthNub;//月数
@property (strong, nonatomic) IBOutlet UIImageView *complateImg;//完成图片显示
@property (strong, nonatomic) IBOutlet UIImageView *littleImg;//进度小图
@property (strong, nonatomic) IBOutlet UILabel *progress;//进度

@property (strong, nonatomic) IBOutlet UIProgressView *progressView;//进度条





@end
