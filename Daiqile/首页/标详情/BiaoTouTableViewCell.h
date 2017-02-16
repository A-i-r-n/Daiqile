//
//  BiaoTouTableViewCell.h
//  juZu
//
//  Created by Air on 2017/1/9.
//  Copyright © 2017年 yangyukun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Feiyangyidai.h"
#import "Jiaxiquan.h"
#import "MZTimerLabel.h"
#import "SDCycleScrollView.h"
@interface BiaoTouTableViewCell : UITableViewCell<UITextFieldDelegate>

{
    Jiaxiquan *quan;
    NSInteger _selectTag;
}

@property (strong, nonatomic) IBOutlet SDCycleScrollView *cycleScrollView;

//@property (weak, nonatomic) IBOutlet UIImageView *headImg;


@property (weak, nonatomic) IBOutlet UILabel *money;//贷款金额
@property (weak, nonatomic) IBOutlet UILabel *lilv;//年化利率
@property (weak, nonatomic) IBOutlet UILabel *qiXian;//期限
@property (weak, nonatomic) IBOutlet UILabel *huanKuan;//还款方式
@property (weak, nonatomic) IBOutlet UILabel *keyongjine;//可用金额
@property (strong, nonatomic) MZTimerLabel *timer;//剩余时间
@property (strong, nonatomic) IBOutlet UILabel *end_timeLabel;

//@property (nonatomic,strong) UILabel *end_timeLabel;

@property (weak, nonatomic) IBOutlet UIProgressView *press;//进度条
@property (weak, nonatomic) IBOutlet UILabel *pressNub;//进度数字
@property (weak, nonatomic) IBOutlet UILabel *allMoney;//可投金额
@property (weak, nonatomic) IBOutlet UITextField *psw;//交易密码
@property (weak, nonatomic) IBOutlet UITextField *codeTF;//验证码
@property (weak, nonatomic) IBOutlet UITextField *moneyTF;//投资金额
@property (weak, nonatomic) IBOutlet UIButton *liJiTouzi;//立即投资
@property (weak, nonatomic) IBOutlet UIButton *getCode;//更新验证码
@property (weak, nonatomic) IBOutlet UILabel *qxType;//期限类型(月,天)
@property (weak, nonatomic) IBOutlet UIView *jiaxiView;//加息券
//@property (strong, nonatomic) IBOutlet UIButton *checkDetail;//查看详情

@property (nonatomic,strong)NSMutableArray *jiaXiArray;

@property (strong,nonatomic) Feiyangyidai *model;
@property (strong, nonatomic) IBOutlet UIButton *xinXiPiLu;//信息披露
@property (strong, nonatomic) IBOutlet UIButton *heTongTuPian;//合同图片
@property (strong, nonatomic) IBOutlet UIButton *xiangMuTuPian;//项目图片
@property (strong, nonatomic) IBOutlet UIButton *touBiaoJiLu;//投标记录
@property (strong, nonatomic) IBOutlet UIButton *huanKuanJiHua;//还款计划

- (void)loadDataWithModel:(Feiyangyidai *)model;


@end
