//
//  MNPickerView.m
//  MNPickerView
//
//  Created by 马宁 on 16/8/17.
//  Copyright © 2016年 马宁. All rights reserved.
//

#import "MNPickerView.h"
#import "MNPickerViewMacros.h"

@interface MNPickerView()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,strong)UIView *bgV;
@property (nonatomic,strong)UIView *titleBgV;
@property (nonatomic,strong)UIView *line;
@property (nonatomic,strong)UIButton *btnCancle;
@property (nonatomic,strong)UIButton *btnOK;
@property (nonatomic,strong)UIPickerView *pickerV;
@property(nonatomic,strong)NSArray<NSString *> *mDatas;
@property(nonatomic,assign)NSInteger currentRow;

@end

@implementation MNPickerView

static CGFloat bottomH = 220;


-(instancetype)initWithDataArray:(NSArray *)dataArray defaultSelecte:(NSInteger)row
{
    self.mDatas = dataArray;
    self.currentRow = row;
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
    }
    else if(IS_IPHONE5){
        textSize = 15;
        bottomTitleH = 40;
    }
    else{
        bottomH = MNScreenHeight * 0.36;
        textSize = 18;
        bottomTitleH = 50;
    }
    
    self.frame = CGRectMake(0, 0, MNScreenWidth, MNScreenHeight);
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    }];
    
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
    self.line = [UIView new];
    self.line.backgroundColor = MNPickerLineColor;
    
    //PickerView
    self.pickerV = [UIPickerView new];
    self.pickerV.delegate = self;
    self.pickerV.dataSource = self;
    
    //位置
    self.btnCancle.frame = CGRectMake(0, 0, btnW, bottomTitleH);
    self.btnOK.frame = CGRectMake(MNScreenWidth - btnW, 0, btnW, bottomTitleH);
    self.line.frame = CGRectMake(0, bottomTitleH, MNScreenWidth,0.5);
    self.pickerV.frame = CGRectMake(0, bottomTitleH + 1, MNScreenWidth, bottomH - bottomTitleH - 1);
    
    [self addSubview:self.bgV];
    [self.bgV addSubview:_titleBgV];
    [self.titleBgV addSubview:_btnCancle];
    [self.titleBgV addSubview:_btnOK];
    [self.titleBgV addSubview:_line];
    [self.bgV addSubview:_pickerV];
    
    //默认选中
    [self.pickerV selectRow:self.currentRow inComponent:0 animated:NO];
    
}

-(void)cancelBtnClick
{
    [self hideAnimation];
}

-(void)okBtnClick
{
    [self hideAnimation];
    if(self.delegate && [self.delegate respondsToSelector:@selector(MNPickerViewdidSelectRow:)]){
        [self.delegate MNPickerViewdidSelectRow:self.currentRow];
    }else{
        NSLog(@"没有实现MNPickerView的代理方法");
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self hideAnimation];
}

#pragma mark    -- UIPickerView --
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(self.mDatas != nil && self.mDatas.count > 0){
        return self.mDatas.count;
    }else{
        return 0;
    }
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *result = self.mDatas[row];
    return result;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.currentRow = row;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    if(IS_IPHONE4)
    {
        return 30;
    }else if(IS_IPHONE5)
    {
        return 36;
    }else
    {
        return 40;
    }
}

//隐藏动画
- (void)hideAnimation{
    [UIView animateWithDuration:0.3 animations:^{
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
        CGRect frame = self.bgV.frame;
        frame.origin.y = MNScreenHeight - bottomH;
        self.bgV.frame = frame;
    }];
}


//----------------对外提供方法---------------
-(void)showPickerView
{
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window addSubview:self];
    [self showAnimation];
}

@end
