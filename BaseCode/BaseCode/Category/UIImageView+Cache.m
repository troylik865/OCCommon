//
//  UIImageView+Cache.m
//  CommonUI
//
//  Created by 李彬 on 15/7/6.
//  Copyright (c) 2015年 李彬. All rights reserved.
//

#import "UIImageView+Cache.h"

@implementation UIImageView (Cache)


- (void)setImageUrl:(NSString *)url {
    [self setImageUrl:url defaultImage:nil];
}

- (void)setImageUrl:(NSString *)url defaultImage:(NSString *)defaultUrl {
    if (!STRING_IS_BLANK(defaultUrl)) {
        UIImage *image = [UIImage imageLoader:defaultUrl];
        self.image = image;
    }
    [CoreHttpService getDataWithURL:url block:^(NSData *data) {
        dispatch_async(dispatch_get_main_queue(), ^{
           self.image = [UIImage imageWithData:data];
        });
    }];
}

@end
