//
//  BiaoTouTableViewCell.m
//  juZu
//
//  Created by Air on 2017/1/9.
//  Copyright © 2017年 yangyukun. All rights reserved.
//

#import "BiaoTouTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
//#import "LodingViewController.h"

#import "DLRadioButton.h"

@implementation BiaoTouTableViewCell

- (NSMutableArray *)jiaXiArray
{
    if (!_jiaXiArray) {
        _jiaXiArray = [NSMutableArray array];
    }
    return _jiaXiArray;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)loadDataWithModel:(Feiyangyidai *)model
{

    self.model = model;
  
    NSArray *imgArray = [ToolModel filterImage:model.pro_pic];
    _cycleScrollView.imageURLStringsGroup = imgArray;
    
    
    //NSLog(@"model.project_pic2 == %@",model.project_pic2);
    
    _money.text = [NSString stringWithFormat:@"%.2f",model.account_yes];
    _lilv.text = [NSString stringWithFormat:@"%.2f",model.apr];
    
    if ([model.isDay isEqualToString:@"0"]) {
        _qiXian.text = model.time_limit;
        _qxType.text = @"月";
    }else{
        _qiXian.text = model.time_limit_day;
        _qxType.text = @"天";

    }

    if ([model.style isEqual:@"0"]) {
        _huanKuan.text = @"一次性还本付息";
    }else if ([model.style isEqual:@"1"]){
        _huanKuan.text = @"等额本息,按月还款";
    }else{
        _huanKuan.text = @"按月付息,到期还本";
    }


    _keyongjine.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"userTotalMoney"];
    
    
    _allMoney.text = [NSString stringWithFormat:@"%.2f",model.account - model.account_yes];
    
    //NSLog(@"moooooo === %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userTotalMoney"]);
    
    float press  = model.account_yes/model.account;

    _press.progress = press;
    
    _pressNub.text = [NSString stringWithFormat:@"%.2f",press * 100];
    
    //_keyongjine.text = [NSString stringWithFormat:@"%.2f",model.account-model.account_yes];
    
    [_getCode addTarget:self action:@selector(getImgCode) forControlEvents:UIControlEventTouchUpInside];

    //倒计时
    NSDate *dateNow=[NSDate dateWithTimeIntervalSinceNow:0];
    
    NSTimeInterval timeNow = [dateNow timeIntervalSince1970];
    
    NSString *strTimeNow=[NSString stringWithFormat:@"%.0f",timeNow];
    
    NSInteger timeNow2 = [strTimeNow intValue];
    
    NSInteger endTime = [model.verify_time intValue] + ([model.valid_time intValue]*24*60*60) - timeNow2 - 86400;
    
    _timer = [[MZTimerLabel alloc] initWithLabel:_end_timeLabel andTimerType:MZTimerLabelTypeTimer];
    
    [_timer setCountDownTime:endTime];
    
    [_timer start];
    
    if (endTime < 0) {
        
        _end_timeLabel.text = @"已到期";
        
        _liJiTouzi.enabled = NO;
        
        [_liJiTouzi setTitle:@"已到期" forState:UIControlStateNormal];
        
        _liJiTouzi.backgroundColor = [UIColor lightGrayColor];
        
        [ToolModel setStatusbBarFontColor];
        
        [_timer pause];
        
        _timer = nil;
    }
    
    if (model.account_yes == model.account) {
        
        
        _liJiTouzi.enabled = NO;
        
        [_liJiTouzi setTitle:@"正在还款" forState:UIControlStateNormal];
        
        _liJiTouzi.backgroundColor = [UIColor lightGrayColor];
        
    }
    
    
    //判断是否为新手标
    if ([model.is_ti isEqualToString:@"1"]) {
        [_liJiTouzi addTarget:self action:@selector(xinShouBiao) forControlEvents:UIControlEventTouchUpInside];
    }else /*if ([model.is_fast isEqualToString:@"1"])*/{
        [_liJiTouzi addTarget:self action:@selector(youXuanBiao) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self getTicket];
    [self getImgCode];
    
}


//获取图形验证码
- (void)getImgCode
{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString*urlStr = [ToolModel linkUrl:@"plugins/index.php?q=imgcode&t=1231"];

    [manager POST:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [_getCode setBackgroundImage:[UIImage imageWithData:responseObject] forState:UIControlStateNormal];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [LCProgressHUD showMessage:@"网络请求出错,请联系管理员!"];
        
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}

//获取加息券
- (void)getTicket
{
    NSDictionary *params = @{@"user_id":[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"],@"status":@"0"};

    [HttpManager sendPostRequestWithDictionary:params withUrl:@"port/getInterestList.php" Success:^(NSDictionary *responseData) {
        NSArray *array = [responseData objectForKey:@"list"];
        if (array.count>0) {
            for (NSDictionary *dict in array) {
                [self.jiaXiArray addObject:[Jiaxiquan parseWithDict:dict ]];
            }
        }
        
        DLRadioButton *firstBtn = [[DLRadioButton alloc]initWithFrame:CGRectMake(8, 20, 65, 20)];
        [firstBtn setTitleColor:MainColor forState:UIControlStateNormal];
        [firstBtn setTitle:@"不使用" forState:UIControlStateNormal];
        firstBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [firstBtn addTarget:self action:@selector(logSelectedButton:) forControlEvents:UIControlEventTouchUpInside];
        firstBtn.iconColor = MainColor;
        firstBtn.indicatorColor = MainColor;
        
        [_jiaxiView addSubview:firstBtn];
        
        NSMutableArray *otherButtons = [NSMutableArray new];
        
        for (int i = 0; i<array.count; i++) {
            DLRadioButton *button = [[DLRadioButton alloc]initWithFrame:CGRectMake(73+i%8*(65+10), 20+i/8*(20+0), 65, 20)];
            button.iconColor = MainColor;
            button.indicatorColor = MainColor;
            [button setTitleColor:MainColor forState:UIControlStateNormal];
            [button deselectOtherButtons];
            button.titleLabel.font = [UIFont systemFontOfSize:12];
            [_jiaxiView addSubview:button];
            [button addTarget:self action:@selector(logSelectedButton:) forControlEvents:UIControlEventTouchUpInside];
            Jiaxiquan *model = self.jiaXiArray[i];
            button.tag = [model.iD intValue];
            
            [button setTitle:model.account forState:UIControlStateNormal];
            [otherButtons addObject:button];
            
        }
        
        
        firstBtn.otherButtons = otherButtons;
    } Failed:^(NSError *error) {
        
        [LCProgressHUD showMessage:@"网络请求出错,请联系管理员!"];
        
    }];
 
    

}

- (void)logSelectedButton:(DLRadioButton *)radioButton {

    _selectTag = radioButton.selectedButton.tag;
    
}

//新手标投标
- (void)xinShouBiao
{
    NSDictionary *params = @{@"user_id":[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"],@"money":_moneyTF.text,@"id":self.model.iD,@"paypassword":_psw.text,@"valicode":_codeTF.text};
    [HttpManager sendPostRequestWithDictionary:params withUrl:@"port/tender.php" Success:^(NSDictionary *responseData) {
        
        NSString *msg = [responseData objectForKey:@"msg"];
        
        [LCProgressHUD showMessage:msg];

        
    } Failed:^(NSError *error) {
        
       [LCProgressHUD showMessage:@"网络请求出错,请联系管理员!"];

    }];
    
}

//其他标,投标
- (void)youXuanBiao
{
//    NSLog(@"quan.id ==== %ld",_selectTag);
    
    NSDictionary *params;
    if (_selectTag == 0) {
      params = @{@"user_id":[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"],@"money":_moneyTF.text,@"id":self.model.iD,@"paypassword":_psw.text,@"interest":@"0",@"valicode":_codeTF.text};
    }else{
        params = @{@"user_id":[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"],@"money":_moneyTF.text,@"id":self.model.iD,@"paypassword":_psw.text,@"interest":[NSNumber numberWithInteger:_selectTag],@"valicode":_codeTF.text};
    }
    
    [HttpManager sendPostRequestWithDictionary:params withUrl:@"port/tender.php" Success:^(NSDictionary *responseData) {
        
        NSString *msg = [responseData objectForKey:@"msg"];
        [ToolModel showAlertViewWithString:msg];
        
        
    } Failed:^(NSError *error) {
        
       [LCProgressHUD showMessage:@"网络请求出错,请联系管理员!"];
        
    }];

    
}



//点击回车,结束编辑状态
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField endEditing:YES];
    
    return YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
