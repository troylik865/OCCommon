//
//  NSObject+Common.h
//  BaseCode
//
//  Created by 李彬 on 15/7/16.
//  Copyright (c) 2015年 李彬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Common)

- (NSArray*)propertyKeys;

- (void)setAttribute:(NSDictionary *)data;

@end
