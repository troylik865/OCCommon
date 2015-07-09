//
//  RangeModel.m
//  CommonUI
//
//  Created by 李彬 on 15/7/7.
//  Copyright (c) 2015年 李彬. All rights reserved.
//

#import "RangeModel.h"

@implementation RangeModel

+ (instancetype)createRangeModelBegin:(NSUInteger)begin length:(NSUInteger)length {
    RangeModel *model = [[RangeModel alloc] init];
    model.begin = begin;
    model.length = length;
    return model;
}

@end
