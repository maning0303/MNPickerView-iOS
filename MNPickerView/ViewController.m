//
//  ViewController.m
//  MNPickerView
//
//  Created by 马宁 on 2017/8/1.
//  Copyright © 2017年 MaNing. All rights reserved.
//

#import "ViewController.h"
#import "MNDatePickerView.h"
#import "MNPickerView.h"

@interface ViewController ()<MNDatePickerViewDelegate,MNPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lableShow;

@property(nonatomic,strong)MNDatePickerView *picker01;
@property(nonatomic,strong)MNDatePickerView *picker02;
@property(nonatomic,strong)MNDatePickerView *picker03;

@property(nonatomic,strong)MNPickerView *picker04;
@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化PickerView
    [self initPickerView];
    
}

-(void)initPickerView
{
    NSDate *nowDate = [NSDate new];
    
    _picker01 = [[MNDatePickerView alloc] initWithDate:nowDate];
    _picker01.delegate = self;
    _picker01.pickerTag = 0;
    
    _picker02 = [[MNDatePickerView alloc] initWithDate:nowDate withDatePickerMode:UIDatePickerModeTime];
    _picker02.delegate = self;
    _picker02.pickerTag = 1;
    
    _picker03 = [[MNDatePickerView alloc] initWithDate:nowDate withDatePickerMode:UIDatePickerModeDateAndTime];
    _picker03.delegate = self;
    _picker03.pickerTag = 2;
    
    _dataArray = [NSMutableArray array];
    [_dataArray addObject:@"小米"];
    [_dataArray addObject:@"魅族"];
    [_dataArray addObject:@"华为"];
    [_dataArray addObject:@"苹果"];
    [_dataArray addObject:@"三星"];
    [_dataArray addObject:@"诺基亚"];
    [_dataArray addObject:@"VIVO"];
    _picker04 = [[MNPickerView alloc] initWithDataArray:_dataArray defaultSelecte:0];
    _picker04.delegate = self;
    
}

-(void)MNPickerViewdidSelectRow:(NSInteger)row
{
    _lableShow.text = _dataArray[row];
}

-(void)MNDatePickerViewSelectedDate:(NSDate *)date tag:(NSInteger)tag
{

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    if(tag == 0){
        dateFormatter.dateFormat = @"yyyy-MM-dd";
        NSString *dateStr01 = [dateFormatter stringFromDate:date];
        _lableShow.text = dateStr01;
    }else if(tag == 1){
        dateFormatter.dateFormat = @"hh:mm";
        NSString *dateStr01 = [dateFormatter stringFromDate:date];
        _lableShow.text = dateStr01;
    }else if(tag == 2){
        dateFormatter.dateFormat = @"yyyy-MM-dd hh:mm";
        NSString *dateStr01 = [dateFormatter stringFromDate:date];
        _lableShow.text = dateStr01;
    }
}


- (IBAction)btnDatePicker01:(id)sender {
    [_picker01 showPickerView];
}
- (IBAction)btnDatePicker02:(id)sender {
    [_picker02 showPickerView];
}
- (IBAction)btnDatePicker03:(id)sender {
    [_picker03 showPickerView];
}
- (IBAction)btnOtherPicker:(id)sender {
    [_picker04 showPickerView];
}

@end
