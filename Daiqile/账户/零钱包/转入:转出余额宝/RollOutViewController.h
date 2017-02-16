//
//  RollOutViewController.h
//  Daiqile
//
//  Created by daiqile on 2017/2/15.
//  Copyright © 2017年 com.daiqile.daiqile. All rights reserved.
//

#import "SuperViewController.h"

typedef void (^RequestSuccess)(NSString *status);

@interface RollOutViewController : SuperViewController

@property (nonatomic, strong) RequestSuccess request;

@end
