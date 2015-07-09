//
//  ClickButton.h
//  Home
//
//  Created by 李彬 on 15/7/8.
//  Copyright (c) 2015年 李彬. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef int (^clickBlock) (int a , int b);

@interface ClickButton : UIButton

@property (nonatomic, copy) clickBlock block;

@end
