//
//  MNPickerView.h
//  MNPickerView
//
//  Created by 马宁 on 16/8/17.
//  Copyright © 2016年 马宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MNPickerViewDelegate <NSObject>

@optional

-(void)MNPickerViewdidSelectRow:(NSInteger)row;

@end

@interface MNPickerView : UIView

-(instancetype)initWithDataArray:(NSArray *)dataArray defaultSelecte:(NSInteger)row;

/**
 *  代理
 */
@property(nonatomic,assign)id<MNPickerViewDelegate> delegate;

-(void)showPickerView;

@end
