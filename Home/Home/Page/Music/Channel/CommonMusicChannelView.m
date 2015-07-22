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

@property (nonatomic, assign) BOOL hasInit;

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, assign) NSInteger preIndex;

@end

@implementation CommonMusicChannelView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _buttonArray = [NSMutableArray array];
        //初始化View
        self.backgroundColor = [UIColor colorFromRGB:0x009ff0];
        self.showsHorizontalScrollIndicator = NO;
        self.bounces = NO;
        _currentIndex = 0;
        _preIndex = 0;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(triggerChannelChange:) name:HOME_NOTIFICATION_CHANNEL_CHANGE object:nil];
    }
    return self;
}

- (void)triggerChannelChange:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    if (!userInfo) {
        return;
    }
    NSInteger index = [[userInfo objectForKey:@"index"] integerValue];
    _currentIndex = index;
    [self buttonBackgroundChange];
    _preIndex = index;
}

-(void)buttonBackgroundChange {
    if(_preIndex == _currentIndex) {
        return;
    }
    UIButton *preButton = [_buttonArray objectAtIndex:_preIndex];
    UIButton *currentButton = [_buttonArray objectAtIndex:_currentIndex];
    float left = currentButton.left;
    
    preButton.titleLabel.textColor = [UIColor whiteColor];
    currentButton.titleLabel.textColor = [UIColor colorWithHexString:@"#202325" alpha:0.6];
    if(left > 150){
        [self setContentOffset:CGPointMake(left + 10 - 150, 0) animated:YES];
    }
    if(_currentIndex == 1) {
        [self setContentOffset:CGPointMake(0, 0) animated:YES];
    }
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
        float y = 0,x = 10;
        NSInteger count = _channels.count;
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
            
            CGSize size = [button.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:button.titleLabel.font}];
            button.frame = CGRectMake(x, y, size.width, 44);
            x += size.width + 10;
        }
        self.contentSize = CGSizeMake(x, 0);
    }
}

-(void)buttonClick:(UIButton *)button {
    NSInteger index = button.tag - 1;
    [[NSNotificationCenter defaultCenter] postNotificationName:HOME_NOTIFICATION_TRIGGER object:nil userInfo:@{ @"index":[NSNumber numberWithInteger:index]}];
}

+(float)viewHeight:(NSDictionary *)data {
    return COMMON_NAVIBAR_HEIGHT;
}

-(void)dealloc {
    SafeRelease(_buttonArray);
    SafeRelease(_data);
    SafeRelease(_channels);
}


@end
