//
//  MNPickerViewMacros.h
//  MNPickerView
//
//  Created by 马宁 on 2017/8/1.
//  Copyright © 2017年 MaNing. All rights reserved.
//

#define MNScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define MNScreenHeight ([UIScreen mainScreen].bounds.size.height)

#define IS_IPHONE4      (([[UIScreen mainScreen] bounds].size.height - 480)?NO:YES)
#define IS_IPHONE5      (([[UIScreen mainScreen] bounds].size.height - 568)?NO:YES)
#define IS_IPHONE6      (([[UIScreen mainScreen] bounds].size.width - 375)?NO:YES)

#define MNUIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define MNPickerLineColor MNUIColorFromRGB(0xE8E8E8)
#define MNPickerTitleBgColor MNUIColorFromRGB(0xFFFFFF)
#define MNPickerViewBgColor MNUIColorFromRGB(0xFFFFFF)
#define MNPickerButtonTextColor MNUIColorFromRGB(0x000000)
