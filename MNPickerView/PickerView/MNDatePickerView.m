//
//  MNDatePickerView.m
//  MNPickerView
//
//  Created by 马宁 on 16/8/18.
//  Copyright © 2016年 马宁. All rights reserved.
//

#import "MNDatePickerView.h"
#import "MNPickerViewMacros.h"

static CGFloat bottomH = 240;

@interface MNDatePickerView()

@property(nonatomic,strong)NSDate *date;
@property (nonatomic,strong)UIView *bgV;
@property (nonatomic,strong)UIView *titleBgV;
@property (nonatomic,strong)UIView *lineBottomView;
@property (nonatomic,strong)UIButton *btnCancle;
@property (nonatomic,strong)UIButton *btnOK;
@property (nonatomic,strong)UIDatePicker *pickerV;
@property(nonatomic,assign)UIDatePickerMode datePickerMode;
@property(nonatomic,assign)NSInteger maxYear;
@property(nonatomic,assign)NSInteger minYear;

@end

@implementation MNDatePickerView

-(instancetype)initWithDate:(NSDate *)date
{
    self.date = date;
    self.datePickerMode = UIDatePickerModeDate;
    if(self == [super initWithFrame:CGRectMake(0, 0, MNScreenWidth, MNScreenHeight)]){
        [self initViews];
    }
    return self;
}

-(instancetype)initWithDate:(NSDate *)date maxYear:(NSInteger)maxYear minYear:(NSInteger)minYear
{
    self.date = date;
    self.datePickerMode = UIDatePickerModeDate;
    self.maxYear = maxYear;
    self.minYear = minYear;
    if(self == [super initWithFrame:CGRectMake(0, 0, MNScreenWidth, MNScreenHeight)]){
        [self initViews];
    }
    return self;
}

-(instancetype)initWithDate:(NSDate *)date withDatePickerMode:(UIDatePickerMode)datePickerMode
{
    self.date = date;
    self.datePickerMode = datePickerMode;
    if(self == [super initWithFrame:CGRectMake(0, 0, MNScreenWidth, MNScreenHeight)]){
        [self initViews];
    }
    return self;
}

-(void)initViews
{
    CGFloat textSize = 16;
    CGFloat btnW = 60;
    CGFloat bottomTitleH = 44;
    bottomH = MNScreenHeight * 0.4;
    if(IS_IPHONE4){
        textSize = 14;
        bottomTitleH = 36;
    }else if(IS_IPHONE5){
        textSize = 15;
        bottomTitleH = 40;
    }else if(IS_IPHONE6){
        bottomH = MNScreenHeight * 0.36;
        textSize = 17;
        bottomTitleH = 50;
    }else{
        bottomH = MNScreenHeight * 0.36;
        textSize = 18;
        bottomTitleH = 50;
    }
    
    self.frame = CGRectMake(0, 0, MNScreenWidth, MNScreenHeight);
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    //整体背景View
    self.bgV = [[UIView alloc]initWithFrame:CGRectMake(0, MNScreenHeight, MNScreenWidth, bottomH)];
    self.bgV.backgroundColor = MNPickerViewBgColor;
    
    //标题背景View
    self.titleBgV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MNScreenWidth, bottomTitleH)];
    self.titleBgV.backgroundColor = MNPickerTitleBgColor;
    
    //按钮
    self.btnCancle = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnCancle.titleLabel.font = [UIFont systemFontOfSize:textSize];
    self.btnCancle.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.btnCancle.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.btnCancle setTitle:@"取消" forState:UIControlStateNormal];
    [self.btnCancle addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.btnCancle setTitleColor:MNPickerButtonTextColor forState:UIControlStateNormal];
    
    
    self.btnOK = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnOK.titleLabel.font = [UIFont systemFontOfSize:textSize];
    self.btnOK.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.btnOK.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.btnOK setTitle:@"确定" forState:UIControlStateNormal];
    [self.btnOK addTarget:self action:@selector(okBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.btnOK setTitleColor:MNPickerButtonTextColor forState:UIControlStateNormal];
    
    //线
    self.lineBottomView = [UIView new];
    self.lineBottomView.backgroundColor = MNPickerLineColor;
    
    //UIDatePickerView
    self.pickerV = [UIDatePicker new];
    //设置地区
    self.pickerV.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    // 设置时区
    [self.pickerV setTimeZone:[NSTimeZone localTimeZone]];
    //设置日期模式
    self.pickerV.datePickerMode = self.datePickerMode;
    //监听滚动
    [self.pickerV addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    //位置
    self.btnCancle.frame = CGRectMake(0, 0, btnW, bottomTitleH);
    self.btnOK.frame = CGRectMake(MNScreenWidth - btnW, 0, btnW, bottomTitleH);
    self.lineBottomView.frame = CGRectMake(0, bottomTitleH, MNScreenWidth, 0.5);
    self.pickerV.frame = CGRectMake(0, bottomTitleH + 1, MNScreenWidth, bottomH - bottomTitleH - 1);
    
    [self addSubview:self.bgV];
    [self.bgV addSubview:_titleBgV];
    [self.titleBgV addSubview:_btnCancle];
    [self.titleBgV addSubview:_btnOK];
    [self.titleBgV addSubview:_lineBottomView];
    [self.bgV addSubview:_pickerV];
    
    //默认选中
    if(self.date == nil){
        self.date  = [NSDate date];
    }
    [self.pickerV setDate:self.date];
    
    //设置最大和最小可选日期
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd"];
    NSString *tempStr = [formater stringFromDate:self.date];
    NSArray *dateArray = [tempStr componentsSeparatedByString:@"-"];
    //设置日期选择器最大可选日期
    if (self.maxYear) {
        NSInteger maxYear = [dateArray[0] integerValue] + self.maxYear;
        NSString *maxStr = [NSString stringWithFormat:@"%zd-%@-%@",maxYear,dateArray[1],dateArray[2]];
        NSDate *maxDate = [formater dateFromString:maxStr];
        self.pickerV.maximumDate = maxDate;
        NSLog(@"maximumDate:%@",self.pickerV.maximumDate);
    }
    //设置日期选择器最小可选日期
    if (self.minYear) {
        NSInteger minYear = [dateArray[0] integerValue] - self.minYear;
        NSString *minStr = [NSString stringWithFormat:@"%zd-%@-%@",minYear,dateArray[1],dateArray[2]];
        NSDate* minDate = [formater dateFromString:minStr];
        self.pickerV.minimumDate = minDate;
        NSLog(@"maximumDate:%@",self.pickerV.minimumDate);
    }
    
}


-(void)datePickerValueChanged:(id)sender {
    self.date = self.pickerV.date;
}

-(void)cancelBtnClick
{
    [self hideAnimation];
}

-(void)okBtnClick
{
    [self hideAnimation];
    if(self.delegate && [self.delegate respondsToSelector:@selector(MNDatePickerViewSelectedDate: tag:)]){
        [self.delegate MNDatePickerViewSelectedDate:self.date tag:_pickerTag];
    }else{
        NSLog(@"没有实现MNDatePickerView的代理方法");
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self hideAnimation];
}

//隐藏动画
- (void)hideAnimation{
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        CGRect frame = self.bgV.frame;
        frame.origin.y = MNScreenHeight;
        self.bgV.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

//显示动画
- (void)showAnimation{
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        CGRect frame = self.bgV.frame;
        frame.origin.y = MNScreenHeight - bottomH;
        self.bgV.frame = frame;
    }];
}

-(void)showPickerView
{
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window addSubview:self];
    [self showAnimation];
}

@end
