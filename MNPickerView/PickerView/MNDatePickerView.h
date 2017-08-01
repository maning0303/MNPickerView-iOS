//
//  MNDatePickerView.h
//  MNPickerView
//
//  Created by 马宁 on 16/8/18.
//  Copyright © 2016年 马宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MNDatePickerViewDelegate <NSObject>

@optional

-(void)MNDatePickerViewSelectedDate:(NSDate *)date tag:(NSInteger) tag;

@end

@interface MNDatePickerView : UIView

-(instancetype)initWithDate:(NSDate *)date;

-(instancetype)initWithDate:(NSDate *)date maxYear:(NSInteger)maxYear minYear:(NSInteger)minYear;

-(instancetype)initWithDate:(NSDate *)date withDatePickerMode:(UIDatePickerMode)datePickerMode;

-(void)showPickerView;

//设置PickerView的Tag：区分PickerView
@property(nonatomic,assign)NSInteger pickerTag;

/**
 *  代理
 */
@property(nonatomic,assign)id<MNDatePickerViewDelegate> delegate;

@end
