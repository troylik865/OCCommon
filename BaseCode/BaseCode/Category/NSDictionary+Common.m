
//
//  NSDictionary+Common.m
//  BaseCode
//
//  Created by 李彬 on 15/7/13.
//  Copyright (c) 2015年 李彬. All rights reserved.
//

#import "NSDictionary+Common.h"

@implementation NSDictionary (Common)

-(instancetype)objectForKeys:(NSArray *)keys {
    id result = self;
    for (NSObject *key in keys) {
        result = [result objectForKey:key];
        if(!result) {
            return nil;
        }
    }
    return  result;
}

@end
