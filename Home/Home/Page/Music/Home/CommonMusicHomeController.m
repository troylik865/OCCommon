
//
//  CommonMusicHomeController.m
//  Home
//
//  Created by 李彬 on 15/7/13.
//  Copyright (c) 2015年 李彬. All rights reserved.
//

#import "CommonMusicHomeController.h"
#import "CommonMusicChannelView.h"
#import "CommonMusicContentView.h"

@interface CommonMusicHomeController ()

@property (nonatomic, strong) CommonMusicChannelView *channelScrollView;

@property (nonatomic, strong) CommonMusicContentView *musicContentView;

@property (nonatomic, strong) NSDictionary *data;


@end

@implementation CommonMusicHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    CommonMessage *message = [[CommonMessage alloc] initWithHttpUrl:HOME_MUSIC_CHANNELS params:nil];
    [self sendMessage:message];
    
    CommonDatabase *database = [[CommonDatabase alloc] init];
    [database propertyKeys];
    [database setAttribute:@{@"name":@"zhangsan",@"isFileOpen":@1}];
    [database open];
    [database close];
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

-(BOOL)isNeedBackButton{
    return NO;
}


- (void)initUI {
    float screenWidth = COMMON_SCREEN_WIDTH;
    self.channelScrollView = [[CommonMusicChannelView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, [CommonMusicChannelView viewHeight:_data])];
    [self.channelScrollView renderUIWithData:_data];
    [self.contentView addSubview:self.channelScrollView];
    
    float bottom = self.channelScrollView.bottom;
    self.musicContentView = [[CommonMusicContentView alloc] initWithFrame:CGRectMake(0, bottom, screenWidth, COMMON_SCREEN_HEIGHT - bottom)];
    [self.musicContentView renderUIWithData:_data];
    [self.contentView addSubview:self.musicContentView];
}


-(void)messageSuccess:(CommonMessage *)message {
    NSString *messageApi = message.apiName;
    if([messageApi isEqualToString:HOME_MUSIC_CHANNELS]) {
        NSDictionary *data = [message getDictionaryData];
        if(!data) {
            return;
        } else {
            _data = data;
        }
        [self initUI];
    }
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

-(void)dealloc {
    SafeRelease(_data);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
