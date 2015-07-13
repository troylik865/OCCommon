//
//  CommonMusicChannelView.h
//  Home
//
//  Created by 李彬 on 15/7/13.
//  Copyright (c) 2015年 李彬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonMusicChannelView : UIScrollView


-(void)renderUIWithData:(NSDictionary *)data;

+(float)viewHeight:(NSDictionary *)data;

@end
