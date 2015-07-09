//
//  UIImage+Common.m
//  CommonUI
//
//  Created by 李彬 on 15/7/6.
//  Copyright (c) 2015年 李彬. All rights reserved.
//

#import "UIImage+Common.h"

@implementation UIImage (Common)

+(UIImage *)imageLoader:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    return image;
}

@end
