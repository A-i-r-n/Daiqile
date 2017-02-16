//
//  ArcView.m
//  Daiqile
//
//  Created by daiqile on 2016/12/21.
//  Copyright © 2016年 com.daiqile.daiqile. All rights reserved.
//

#import "ArcView.h"

@implementation ArcView


- (void)setModel:(Feiyangyidai *)model
{
    _moneyLabel.text = [NSString stringWithFormat:@"金额: %.2lf",model.account];
    NSLog(@"account === %f",model.account);
    if ([model.isDay isEqualToString:@"1"]) {
        _timeLimitLabel.text = [NSString stringWithFormat:@"期限: %@天", model.time_limit_day];
    }else{
        _timeLimitLabel.text = [NSString stringWithFormat:@"期限: %@个月", model.time_limit];
    }
    
    float epr = model.account_yes/model.account;
    [self setValueToPath:[NSString stringWithFormat:@"%.2f%%",epr*100]];
    
    _nameLabel.text = model.name;
    
    _rightMoneyLabel.text = [NSString stringWithFormat:@"%@元起投",model.lowest_account];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor greenColor];
        rect=[UIScreen mainScreen].bounds;
        UIBezierPath *path1=[UIBezierPath bezierPath];
        
        UIBezierPath *path0=[UIBezierPath bezierPath];
        
        [path0 addArcWithCenter:CGPointMake(ArcCenterX,ArcCenterY) radius:ScreenWidth/3 startAngle:M_PI*5/6 endAngle:M_PI/6 clockwise:YES];
        CAShapeLayer *  arcLayer0=[CAShapeLayer layer];
        arcLayer0.path=path0.CGPath;//46,169,230
        arcLayer0.fillColor = nil;
        arcLayer0.strokeColor = AssistColor.CGColor;
        arcLayer0.lineWidth=2;
        arcLayer0.frame=self.frame;
        [self.layer addSublayer:arcLayer0];
        
        
        [path1 addArcWithCenter:CGPointMake(ArcCenterX,ArcCenterY) radius:ScreenWidth/3-20 startAngle:M_PI*5/6 endAngle:M_PI/6 clockwise:YES];
        CAShapeLayer *  arcLayer1=[CAShapeLayer layer];
        arcLayer1.path=path1.CGPath;//46,169,230
        arcLayer1.fillColor = nil;
        arcLayer1.strokeColor= GoldColor.CGColor;//[UIColor colorWithRed:254/255.0 green:238/255.0 blue:193/255.0 alpha:1].CGColor;
        arcLayer1.lineWidth=20;
        arcLayer1.frame=self.frame;
        [self.layer addSublayer:arcLayer1];
        
        
        
        
        CGFloat endAg=M_PI*5/6;
        for (int i=0; i<5; i++) {
            UIBezierPath *path04=[UIBezierPath bezierPath];
            
            [path04 addArcWithCenter:CGPointMake(ArcCenterX,ArcCenterY) radius:ScreenWidth/3-50 startAngle:endAg endAngle:M_PI*4/15+endAg clockwise:YES];
            [path04 addLineToPoint:CGPointMake(rect.size.width/2,rect.size.height/4-20)];
            [path04 closePath];
            
            CAShapeLayer *  arcLayer4=[CAShapeLayer layer];
            arcLayer4.path = path04.CGPath;//46,169,230
            arcLayer4.fillColor = nil;
            arcLayer4.strokeColor = AssistColor.CGColor;
            arcLayer4.lineWidth=3;
            arcLayer4.frame=self.frame;
            [self.layer addSublayer:arcLayer4];
            endAg=M_PI*4/15+endAg;
            
        }
        
        
        UIBezierPath *path03=[UIBezierPath bezierPath];
        
        [path03 addArcWithCenter:CGPointMake(ArcCenterX,ArcCenterY) radius:ScreenWidth/3-58 startAngle:M_PI*5/6 endAngle:M_PI/6 clockwise:YES];
        CAShapeLayer *  arcLayer3=[CAShapeLayer layer];
        //arcLayer3.fillRule = kCAFillRuleEvenOdd;
        arcLayer3.path=path03.CGPath;//46,169,230
        arcLayer3.fillColor = [UIColor whiteColor].CGColor;
        arcLayer3.strokeColor=[UIColor clearColor].CGColor;
        //    arcLayer3.lineWidth=3;
        arcLayer3.frame=self.frame;
        [self.layer addSublayer:arcLayer3];
        
        
        [self nameLabel];
        
        
        myLabel=[[UICountingLabel alloc] initWithFrame:CGRectMake(0, 0, 80, 50)];
        
        myLabel.textColor= AssistColor;//[UIColor whiteColor];
        myLabel.textAlignment=NSTextAlignmentCenter;
        myLabel.font=[UIFont systemFontOfSize:17];
        myLabel.center=CGPointMake(rect.size.width/2,rect.size.height/4-20);
        [self addSubview:myLabel];
        
        
        
        //__block int count=0;
        
        myLabel.method = UILabelCountingMethodLinear;
        myLabel.format = @"%d";
        
        
        
        
        
        [self timeLimitLabel];
        
        [self moneyLabel];
        UILabel *lineLabel = [[UILabel alloc]init];
        lineLabel.backgroundColor = [UIColor blackColor];
        [self addSubview:lineLabel];
        [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.offset(myLabel.frame.origin.y+myLabel.frame.size.height+45+30+15);
            make.centerX.equalTo(myLabel.mas_centerX);
            make.centerY.equalTo(_moneyLabel.mas_centerY);
            
            make.width.offset(1);
            make.height.offset(20);
        }];
        
        
        [self rightMoneyLabel];
        

    }
    return self;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.text = @"推荐标：xxxxxxxxxx";
        [self addSubview:_nameLabel];
    
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(-5);
            make.left.offset(8);
            make.width.offset(160);
            make.height.offset(25);
            
        }];
        
    }
    return _nameLabel;
}


- (UILabel *)timeLimitLabel{
    if (!_timeLimitLabel) {
        _timeLimitLabel = [[UILabel alloc]init];
        _timeLimitLabel.textColor = [UIColor blackColor];
        _timeLimitLabel.text =[NSString stringWithFormat:@"期限：0个月"] ;
        _timeLimitLabel.textAlignment = NSTextAlignmentCenter;
        _timeLimitLabel.backgroundColor =  AssistColor;
        _timeLimitLabel.layer.cornerRadius = 15;
        _timeLimitLabel.clipsToBounds = YES;
        
        
        [self addSubview:_timeLimitLabel];
        [_timeLimitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(myLabel.frame.origin.y+myLabel.frame.size.height+45);
            make.centerX.equalTo(myLabel.mas_centerX);
            make.width.offset(180);
            make.height.offset(30);
            
        }];
    }
    return _timeLimitLabel;
}



- (UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc]init];
        _moneyLabel.textColor = [UIColor blackColor];
        _moneyLabel.font = [UIFont systemFontOfSize:15];
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
        _moneyLabel.text = @"金额：0";
//            _moneyLabel.backgroundColor = [UIColor redColor];
        [self addSubview:_moneyLabel];
        [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(myLabel.frame.origin.y+myLabel.frame.size.height+45+30+5);
            
            make.left.offset(0);
            make.width.offset(rect.size.width/2-10);
            make.height.offset(30);
            if (!kDevice_Is_iPhone5) {
                make.bottom.offset(0);
            }
         
        }];
        
    }
    return _moneyLabel;
}

- (UILabel *)rightMoneyLabel{
    if(!_rightMoneyLabel){
        _rightMoneyLabel = [[UILabel alloc]init];
        _rightMoneyLabel.textColor = [UIColor blackColor];
        _rightMoneyLabel.text = @"50元起投";
        _rightMoneyLabel.textAlignment = NSTextAlignmentCenter;
        _rightMoneyLabel.font = [UIFont systemFontOfSize:15];
//            _rightMoneyLabel.backgroundColor = [UIColor greenColor];
        [self addSubview:_rightMoneyLabel];
        [_rightMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(myLabel.frame.origin.y+myLabel.frame.size.height+45+30+5);
            make.left.offset(rect.size.width/2+10);
            make.width.offset(rect.size.width/2-10);
            make.height.offset(30);
            if (!kDevice_Is_iPhone5) {
                make.bottom.offset(0);
            }
        }];
        
    }
    return _rightMoneyLabel;
}
-(void)drawLineAnimation:(CALayer*)layer
{
    CABasicAnimation *bas=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    bas.duration=1;
    bas.delegate=self;
    bas.fromValue=[NSNumber numberWithInteger:0];
    bas.toValue=[NSNumber numberWithInteger:1];
    [layer addAnimation:bas forKey:@"key"];
    [self.layer addSublayer:arcLayer];
}
- (void)setValueToPath:(NSString *)string{
    if (!([string intValue]==0)) {
        [arcLayer removeFromSuperlayer];
        
        [myLabel countFrom:1 to:[string doubleValue] withDuration:1.0];
        //    CGRect rect=[UIScreen mainScreen].applicationFrame;
        path=[UIBezierPath bezierPath];
        [path addArcWithCenter:CGPointMake(ArcCenterX,ArcCenterY) radius:ScreenWidth/3-20 startAngle:M_PI*5/6 endAngle:(500+8*[string doubleValue])*M_PI/600.0 clockwise:YES];
        arcLayer=[CAShapeLayer layer];
        arcLayer.path=path.CGPath;//46,169,230
        arcLayer.fillColor = nil;
        arcLayer.strokeColor = MainColor.CGColor;
        arcLayer.lineWidth=20;
        arcLayer.frame=self.frame;
        //        [self.layer addSublayer:arcLayer];
        [self drawLineAnimation:arcLayer];
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
