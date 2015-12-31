//
//  ViewController.m
//  HZInputpasswordView
//
//  Created by 邢现庆 on 15/12/31.
//  Copyright © 2015年 XianQing Xing. All rights reserved.
//

#import "ViewController.h"
#import "HZIputpasswordView.h"

@interface ViewController ()<HZInputPasswordViewDelegate>
@property(nonatomic,strong)HZInputPasswordView* popuView;
@property(nonatomic,copy)NSString* password;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)action:(id)sender {
    
    //实例化
    self.popuView = [[HZInputPasswordView alloc]initWithFrame:self.view.bounds];
    self.popuView.delegate    = self;
    self.popuView.alertString = @"您需要支付:";
    self.popuView.factMoney   = @"1000";
    [self.view addSubview:self.popuView];
    
}
#pragma mark InputPasswordViewDelegate
-(void)sendMessageToViewController:(HZInputPasswordView *)inputPWDView andClick:(HZInputPasswordViewClick)click{
    
    switch (click) {
            //确认
        case HZInputPasswordViewClickFinished:
            self.password = inputPWDView.password;
            [self.popuView removeFromSuperview];
            break;
            //忘记
        case HZInputPasswordViewClickFoegetPWD:
           [self.popuView removeFromSuperview];
            //......
            break;
            //关闭/删除
        case HZInputPasswordViewClickRemove:
            [self.popuView removeFromSuperview];
            //......
            break;
            
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
