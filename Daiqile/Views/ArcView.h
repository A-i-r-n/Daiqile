//
//  ArcView.h
//  Daiqile
//
//  Created by daiqile on 2016/12/21.
//  Copyright © 2016年 com.daiqile.daiqile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICountingLabel.h"
#import "Feiyangyidai.h"
@interface ArcView : UIView<CAAnimationDelegate>
{
    UICountingLabel *myLabel;
    UIBezierPath *path;
    CAShapeLayer *arcLayer;
    CGRect rect;
}
@property (nonatomic,strong)UILabel *timeLimitLabel,*moneyLabel,*rightMoneyLabel,*nameLabel;
@property (nonatomic,strong)Feiyangyidai *model;
- (void)setValueToPath:(NSString *)string;
@end
