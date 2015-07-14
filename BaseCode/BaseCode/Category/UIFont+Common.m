//
//  UIFont+Common.m
//  BaseCode
//
//  Created by 李彬 on 15/7/14.
//  Copyright (c) 2015年 李彬. All rights reserved.
//

#import "UIFont+Common.h"

@implementation UIFont (Common)


+ (UIFont *)getHeitiSCFont:(float)fontSize {
    return [UIFont fontWithName:@"HelveticaNeue"
                           size:fontSize];
}

+ (UIFont *)getHeitiSCBoldFont:(float)fontSize {
    return [UIFont fontWithName:@"HelveticaNeue-Bold"
                           size:fontSize];
}

+ (UIFont *)getHiraKakuBlodFont:(float)fontSize {
    return [UIFont fontWithName:@"HelveticaNeue-Bold"
                           size:fontSize];
}

+ (UIFont *)getHelveticaNeueFont:(float)fontSize {
    return [UIFont fontWithName:@"HelveticaNeue"
                           size:fontSize];
}

+ (UIFont *)getHelveticaNeueBoldFont:(float)fontSize {
    return [UIFont fontWithName:@"HelveticaNeue-Bold"
                           size:fontSize];
}

- (UIFont *)adaptiveFontWithBiggerSize:(float)biggerSize {
    BOOL iPhone6 = ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO);
    BOOL iPhone6plus = ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO);
    if (!iPhone6 && !iPhone6plus) {
        return self;
    }
    return [UIFont fontWithName:self.fontName size:biggerSize];
}


@end
