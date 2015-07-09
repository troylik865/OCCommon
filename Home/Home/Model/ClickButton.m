//
//  ClickButton.m
//  Home
//
//  Created by 李彬 on 15/7/8.
//  Copyright (c) 2015年 李彬. All rights reserved.
//

#import "ClickButton.h"

@implementation ClickButton


-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)setBlock:(clickBlock)block {
    _block = block;
}


-(void)test {
    NSLog(@"click....");
    _block(1,2);
}



@end
