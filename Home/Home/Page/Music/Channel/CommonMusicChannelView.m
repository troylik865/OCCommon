//
//  CommonMusicChannelView.m
//  Home
//
//  Created by 李彬 on 15/7/13.
//  Copyright (c) 2015年 李彬. All rights reserved.
//

#import "CommonMusicChannelView.h"

@interface CommonMusicChannelView ()

@property (nonatomic, strong) NSMutableArray *buttonArray;

@property (nonatomic, strong) NSDictionary *data;

@property (nonatomic, strong) NSArray *channels;

@end

@implementation CommonMusicChannelView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _buttonArray = [NSMutableArray array];
        //初始化View
        self.backgroundColor = [UIColor colorWithHexString:@"#202325" alpha:0.8];
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}


-(void)renderUIWithData:(NSDictionary *)data {
    _channels = [data objectForKey:@"channels"];
    if(_buttonArray) {
        [_buttonArray removeAllObjects];
    }
    if(!_channels){
        if(ARRAY_IS_EMPTY(_buttonArray)){
            return;
        }
        //清楚内部所有的button
        else {
            for (UIButton *button in _buttonArray) {
                [button  removeFromSuperview];
            }
            [_buttonArray removeAllObjects];
        }
        
        return;
    }
    
    //如果不为空的情况下 进行button的添加和UI的渲染
    else {
        NSInteger count = _channels.count;
        float y = 0;
        if(iOSVersionGreaterThan(@"7.0")) {
            y = 20;
        }
        for (int i = 0; i < count; i++) {
            NSDictionary *data = [_channels objectAtIndex:i];
            if(!data) {
                continue;
            }
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            NSString *buttonName = DEFAULT_BLANK_IN_DICTIONARY(data,@"name");
            [button setTitle:buttonName forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [_buttonArray addObject:button];
            [button setTag:(i + 1)];
            [self addSubview:button];
        }
    }
}

-(void)layoutSubviews {
    [super layoutSubviews];
    NSInteger count = _buttonArray.count;
    float x = 10;
    float y = 0;
    if(iOSVersionGreaterThan(@"7.0")) {
        y = 20;
    }
    for (int i = 0; i < count; i++) {
        UIButton *button = (UIButton *)[self viewWithTag:(i + 1)];
        if(!button) {
            continue;
        }
        CGSize size = [button.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:button.titleLabel.font}];
        button.frame = CGRectMake(x, y, size.width, 44);
        x += size.width + 10;
    }
    self.contentSize = CGSizeMake(x, 44);
}

-(void)buttonClick:(UIButton *)button {
    NSInteger index = button.tag - 1;
    NSDictionary *data = [_channels objectAtIndex:index];
    [[NSNotificationCenter defaultCenter] postNotificationName:HOME_NOTIFICATION_TRIGGER object:nil userInfo:@{ @"index":[NSNumber numberWithInteger:index]}];
}



+(float)viewHeight:(NSDictionary *)data {
    
    float y = 0;
    if(iOSVersionGreaterThan(@"7.0")) {
        y = 20;
    }
    return COMMON_NAVIBAR_HEIGHT + y;
}

-(void)dealloc {
    SafeRelease(_buttonArray);
    SafeRelease(_data);
    SafeRelease(_channels);
}


@end
