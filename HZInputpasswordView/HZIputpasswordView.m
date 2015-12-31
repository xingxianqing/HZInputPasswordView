//
//  HZIputpasswordView.m
//  HZInputpasswordView
//
//  Created by 邢现庆 on 15/12/31.
//  Copyright © 2015年 XianQing Xing. All rights reserved.
//

#import "HZIputpasswordView.h"

@interface HZInputPasswordView ()

@property(nonatomic,strong)NSMutableArray * array;
@property(nonatomic,strong)UITextField  * inputNumPWDTF;///<输入数字的输入框
@property(nonatomic,strong)UITextField  * longPWDInputTF;///<输入长密码的输入框
@property(nonatomic,strong)UILabel * moneyLable;///<金额Lable
@property(nonatomic,strong)UIView  * contentView;
@property(nonatomic,strong)UIView  * inputView;
@property(nonatomic,strong)UILabel * alertStringLable;///<金额上边的标题Lable

@end
@implementation HZInputPasswordView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clear = NO;
        self.layer.cornerRadius = 8;
        self.backgroundColor = [UIColor clearColor];
        [self initUI:frame];
    }
    return self;
}

-(void)initUI:(CGRect)frame{
    self.array=[NSMutableArray array];
    //灰层
    UIView* backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    backView.backgroundColor = COLOR(0, 0, 0, 0.5);
    
    CGFloat y = 0;
    y = [UIScreen mainScreen].bounds.size.height > 500 ? 40 : 5 ;
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/2-140, y, 280, 210)];
    view.layer.cornerRadius = 8;
    view.backgroundColor=[UIColor whiteColor];
    
    UILabel* title=[[UILabel alloc]initWithFrame:CGRectMake(15, 5, view.frame.size.width-20, 30)];
    [title setFont:[UIFont systemFontOfSize:15]];
    [title setText:@"请输入交易密码"];
    [view addSubview:title];
    
    UILabel* borderLable=[[UILabel alloc]initWithFrame:CGRectMake(0, 40, view.frame.size.width, 0.5)];
    borderLable.backgroundColor = COLOR(153, 153, 153, 0.3);
    [view addSubview:borderLable];
    
    UILabel* nameLable=[[UILabel alloc]initWithFrame:CGRectMake(20, borderLable.frame.origin.y+14, view.frame.size.width-40, 20)];
    [nameLable setText:@""];
    [nameLable setTextColor:[UIColor grayColor]];
    [nameLable setFont:[UIFont systemFontOfSize:12]];
    nameLable.textAlignment=NSTextAlignmentCenter;
    self.alertStringLable = nameLable;
    [view addSubview:nameLable];
    UILabel* moneyLable=[[UILabel alloc]initWithFrame:CGRectMake(20, nameLable.frame.origin.y+25, view.frame.size.width-40, 30)];
    [moneyLable setFont:[UIFont systemFontOfSize:21]];
    moneyLable.textAlignment=NSTextAlignmentCenter;
    self.moneyLable = moneyLable;
    [view addSubview:moneyLable];
    
    UIButton* btn=[[UIButton alloc]initWithFrame:CGRectMake(view.frame.size.width-28, 13, 15, 15)];
    [btn setBackgroundImage:[UIImage imageNamed:@"guanbi.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(removePopupView:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    
    NSString* string =@"不是6位数字密码?使用长密码支付" ;
    NSUInteger stringLength = [string length];
    NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:string];
    [titleString addAttribute:NSForegroundColorAttributeName value:ORANGE_COLOR range:NSMakeRange(stringLength-7,7)];
    UIButton* btn3=[[UIButton alloc]initWithFrame:CGRectMake(15,view.frame.size.height-35 , view.frame.size.width-20, 20)];
    [btn3 setAttributedTitle:titleString forState:UIControlStateNormal];
    [btn3.titleLabel setFont:[UIFont systemFontOfSize:13]];
    btn3.titleLabel.shadowColor = [UIColor clearColor];
    [btn3 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [btn3 setTitleColor:ORANGE_COLOR forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(notNumPassword:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn3];
    
    UIView * contentView=[[UIView alloc]initWithFrame:CGRectMake(15,view.frame.size.height-90, 250, 40)];
    contentView.layer.borderWidth=0.5f;
    contentView.layer.borderColor=COLOR(204, 204, 204, 1.0).CGColor;
    
    UITextField* textField=[[UITextField alloc]initWithFrame:CGRectMake(0, 0, 240, 40)];
    [textField addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventEditingChanged];
    textField.textColor=[UIColor clearColor];
    textField.keyboardType=UIKeyboardTypeNumberPad;
    textField.secureTextEntry=YES;
    textField.tintColor=[UIColor clearColor];
    textField.textAlignment=NSTextAlignmentCenter;
    textField.selected = NO;
    self.inputNumPWDTF = textField;
    
    for (int i=0; i<6; i++) {
        if (i>0) {
            UILabel* lable=[[UILabel  alloc]initWithFrame:CGRectMake(i*41.6, 0, 0.5, contentView.frame.size.height)];
            lable.backgroundColor=COLOR(204, 204, 204, 0.5);
            [contentView addSubview:lable];
        }
        UITextField* textField=[[UITextField alloc]initWithFrame:CGRectMake(i*41.6, 0, 40, 40)];
        textField.tag=i;
        [textField setFont:[UIFont systemFontOfSize:22]];
        textField.keyboardType=UIKeyboardTypeNumberPad;
        textField.secureTextEntry=YES;
        textField.tintColor=[UIColor clearColor];
        textField.textAlignment=NSTextAlignmentCenter;
        [self.array addObject:textField];
        [contentView addSubview:textField];
    }
    [contentView addSubview:textField];
    [textField becomeFirstResponder];
    self.contentView = contentView;
    [view addSubview:contentView];
    UITapGestureRecognizer* tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [view addGestureRecognizer:tap];
    self.inputView = view;
    [backView addSubview:view];
    [self addSubview:backView];
    
}
/**
 *  不是6位数字密码
 */
-(void)notNumPassword:(UIButton*)sender{
    [sender setHidden:YES];
    [self.inputNumPWDTF resignFirstResponder];
    CGRect frame = self.contentView.frame;
    [self.contentView removeFromSuperview];
    self.contentView = [[UIView alloc]initWithFrame:frame];
    self.contentView.layer.borderWidth = 0.5f;
    self.contentView.layer.borderColor = COLOR(204, 204, 204, 1.0).CGColor;
    
    UITextField* textField=[[UITextField alloc]initWithFrame:CGRectMake(0, 1, 240, frame.size.height)];
    [textField addTarget:self action:@selector(notNumPasswordValueChanged:) forControlEvents:UIControlEventEditingChanged];
    textField.secureTextEntry=YES;
    [textField setFont:[UIFont systemFontOfSize:22]];
    [textField setBorderStyle:UITextBorderStyleNone];
    textField.selected = NO;
    [textField setTextAlignment:NSTextAlignmentCenter];
    self.longPWDInputTF = textField;
    [self.contentView addSubview:textField];
    
    CGRect viewFrame = self.inputView.frame;
    viewFrame.origin.y -= 18;
    viewFrame.size.height += 42;
    self.inputView.frame = viewFrame;
    
    UIButton* btn2=[[UIButton alloc]initWithFrame:CGRectMake(self.inputView.frame.size.width-110,
                                                             self.inputView.frame.size.height-80 ,
                                                             100,
                                                             20)];
    [btn2 setTitle:@"忘记交易密码" forState:UIControlStateNormal];
    [btn2.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(alterPassword:) forControlEvents:UIControlEventTouchUpInside];
    [self.inputView addSubview:btn2];
    
    UIButton* cash=[[UIButton alloc]initWithFrame:CGRectMake(frame.origin.x-5,
                                                             self.inputView.frame.size.height-52,
                                                             frame.size.width+10,
                                                             40)];
    [cash setTitle:@"确认" forState:UIControlStateNormal];
    [cash setBackgroundColor:ORANGE_COLOR];
    [cash setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cash.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [cash addTarget:self action:@selector(ensureCashAction:) forControlEvents:UIControlEventTouchUpInside];
    cash.layer.cornerRadius = BUTTON_CORNERRADIUS;
    [self.inputView addSubview:cash];
    [self.inputView addSubview:self.contentView];
    [textField becomeFirstResponder];
}

/**
 * 不是6位数字密码时的密码
 */
-(void)notNumPasswordValueChanged:(UITextField *)textField{
    self.password = textField.text;
    
}
/**
 * 不是6位数字密码的弹框中的确认提现按钮
 */
-(void)ensureCashAction:(UIButton*)sender{
    
    [self.delegate sendMessageToViewController:self andClick:HZInputPasswordViewClickFinished];//确认
}
//忘记密码按钮
-(void)alterPassword:(UIButton*)sender{
    [self.longPWDInputTF resignFirstResponder];
    [self.inputNumPWDTF resignFirstResponder];
    [self.delegate sendMessageToViewController:self andClick:HZInputPasswordViewClickFoegetPWD];//忘记交易密码
    
}
//删除输入密码的框
-(void)removePopupView:(UIButton*)sender{
    [self.delegate sendMessageToViewController:self andClick:HZInputPasswordViewClickRemove];
}
//密码框事件
- (void)valueChanged:(UITextField *)textField{
    
    if (textField.text.length<=6) {
        self.password=textField.text;
        for (int i = 0; i<6; i++) {
            UITextField* text = self.array[i];
            text.text=@"";
        }
        for (int i = 0; i<self.password.length; i++) {
            UITextField* text = self.array[i];
            text.text=@"*";
        }
        if (self.password.length==6) {
            [self.delegate sendMessageToViewController:self andClick:HZInputPasswordViewClickFinished];//确认
        }
    }
}
//属性字符串  把金额后边的元变小一点
-(NSMutableAttributedString*)setAttributedStringWithString:(NSString*)string andColor:(UIColor*)color{
    NSUInteger length = [string length];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12]
                             range:NSMakeRange(length-1,1)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:SECEND_TITLE_COLOR
                             range:NSMakeRange(length-1,1)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:color
                             range:NSMakeRange(0,length-1)];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:21]
                             range:NSMakeRange(0,length-1)];
    return attributedString;
}
-(void)tap:(UITapGestureRecognizer*)tap{
    [self.inputNumPWDTF resignFirstResponder];
    [self.longPWDInputTF resignFirstResponder];
}


- (void)drawRect:(CGRect)rect {
    
    NSMutableAttributedString* moneyStr = [self setAttributedStringWithString:[NSString stringWithFormat:@"%.2f元",self.factMoney.floatValue]
                                                                     andColor:SECEND_TITLE_COLOR];
    [self.moneyLable setAttributedText:moneyStr];
    
    [self.alertStringLable setText:self.alertString];
    
    if (self.clear) {
        for (int i = 0; i<self.array.count; i++) {//清空密码框
            UITextField* text = self.array[i];
            text.text = @"";
        }
        self.longPWDInputTF.text = nil;
        self.inputNumPWDTF.text = nil;
    }
}
@end


