//
//  HZIputpasswordView.h
//  HZInputpasswordView
//
//  Created by 邢现庆 on 15/12/31.
//  Copyright © 2015年 XianQing Xing. All rights reserved.
//

#import <UIKit/UIKit.h>

//设备高度
#define ScreenHeight  [UIScreen mainScreen].bounds.size.height
//设备宽度
#define ScreenWidth   [UIScreen  mainScreen].bounds.size.width
//颜色
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0              alpha:A]
//橙色
#define ORANGE_COLOR  [UIColor colorWithRed:239.0/255.0 green:104.0/255.0 blue:60.0/255.0       alpha:1.0]
//button cornerRadius
#define BUTTON_CORNERRADIUS 20
//二级内容颜色
#define SECEND_TITLE_COLOR [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]

typedef enum{
    HZInputPasswordViewClickFinished = 11,//确认
    HZInputPasswordViewClickFoegetPWD,//忘记交易密码
    HZInputPasswordViewClickRemove,//删除输入框
} HZInputPasswordViewClick;


@class HZInputPasswordView;

@protocol HZInputPasswordViewDelegate <NSObject>

-(void)sendMessageToViewController:(HZInputPasswordView*)inputPWDView andClick:(HZInputPasswordViewClick)click;

@end

@interface HZInputPasswordView : UIView

@property(nonatomic,weak)id<HZInputPasswordViewDelegate> delegate;

@property(nonatomic,strong)NSString * password;///<密码

@property(nonatomic,copy) NSString* factMoney;///<显示的金额

@property(nonatomic,copy)NSString *alertString;///<金额上边的标题Lable的内容

@property(nonatomic,assign)BOOL clear;///<是否清空密码
@end
