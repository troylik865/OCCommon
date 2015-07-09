//
//  NSString+Common.h
//  CommonUI
//
//  Created by 李彬 on 15/7/7.
//  Copyright (c) 2015年 李彬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Common)

- (NSArray *)indexsInString:(NSString *)str ignoreCase:(BOOL)ignore;

+ (NSString *)insert:(NSArray *)strs separation:(NSString *)sep;

@end
