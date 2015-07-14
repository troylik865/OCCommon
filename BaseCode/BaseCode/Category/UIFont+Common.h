//
//  UIFont+Common.h
//  BaseCode
//
//  Created by 李彬 on 15/7/14.
//  Copyright (c) 2015年 李彬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (Common)

+ (UIFont *)getHeitiSCFont:(float)fontSize;
+ (UIFont *)getHeitiSCBoldFont:(float)fontSize;
+ (UIFont *)getHiraKakuBlodFont:(float)fontSize;
+ (UIFont *)getHelveticaNeueFont:(float)fontSize;
+ (UIFont *)getHelveticaNeueBoldFont:(float)fontSize;

- (UIFont *)adaptiveFontWithBiggerSize:(float)biggerSize;

@end
