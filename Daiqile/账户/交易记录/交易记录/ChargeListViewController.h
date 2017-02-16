//
//  ChargeListViewController.h
//  Daiqile
//
//  Created by daiqile on 2016/11/17.
//  Copyright © 2016年 com.daiqile.daiqile. All rights reserved.
//

#import "SuperViewController.h"
#import "ZJScrollPageViewDelegate.h"
@interface ChargeListViewController : SuperViewController<ZJScrollPageViewChildVcDelegate>

@property (nonatomic,strong) NSIndexPath *indexPath;
@property (nonatomic,strong) NSArray *dataArray;


@end
