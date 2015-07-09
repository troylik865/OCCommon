//
//  UIImageView+Cache.h
//  CommonUI
//
//  Created by 李彬 on 15/7/6.
//  Copyright (c) 2015年 李彬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Cache)

-(void)setImageUrl:(NSString *)url;

-(void)setImageUrl:(NSString *)url defaultImage:(NSString *)defaultUrl;


@end
