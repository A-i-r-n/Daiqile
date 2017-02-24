//
//  EmailAuthenViewController.m
//  Daiqile
//
//  Created by daiqile on 2017/2/22.
//  Copyright © 2017年 com.daiqile.daiqile. All rights reserved.
//

#import "EmailAuthenViewController.h"
#import "AccountViewController.h"


@interface EmailAuthenViewController ()

@property (weak, nonatomic) IBOutlet UITextField *emailAuten;

@end

@implementation EmailAuthenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"邮箱验证";
    
}

//验证邮箱
- (IBAction)autenEmail:(id)sender
{
    NSDictionary *params = @{@"uid":UserDefaultGetValue(@"userId") ,@"email":_emailAuten.text};
    
    [HttpManager sendPostRequestWithDictionary:params withUrl:@"port/send_email_one.php" Success:^(NSDictionary *responseData) {
        
        NSString *status = [NSString stringWithFormat:@"%@",responseData[@"status"]];
        
        NSString *msg = [responseData objectForKey:@"msg"];
        
        [LCProgressHUD showMessage:msg];
        
        if ([status isEqualToString:@"1"]) {
            
            [LCProgressHUD showMessage:msg];
            
            AccountViewController *account = [[AccountViewController alloc]init];
            
            PUSH(account);
            
        }else{
            
            [LCProgressHUD showMessage:msg];
            
        }
        
        
        
    } Failed:^(NSError *error) {
       
        [LCProgressHUD showMessage:@"网络请求失败,请联系管理员!"];
        
    }];
}


@end
