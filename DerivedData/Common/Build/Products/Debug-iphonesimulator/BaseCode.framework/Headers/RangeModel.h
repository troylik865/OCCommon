//
//  RangeModel.h
//  CommonUI
//
//  Created by 李彬 on 15/7/7.
//  Copyright (c) 2015年 李彬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RangeModel : NSObject


@property (nonatomic, assign) NSUInteger begin;

@property (nonatomic, assign) NSUInteger length;


+(instancetype)createRangeModelBegin:(NSUInteger)begin length:(NSUInteger)length;


@end
