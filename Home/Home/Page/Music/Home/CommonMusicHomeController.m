
//
//  CommonMusicHomeController.m
//  Home
//
//  Created by 李彬 on 15/7/13.
//  Copyright (c) 2015年 李彬. All rights reserved.
//

#import "CommonMusicHomeController.h"
#import "CommonMusicChannelView.h"

@interface CommonMusicHomeController ()

@property (nonatomic, strong) CommonMusicChannelView *channelScrollView;

@property (nonatomic, strong) NSDictionary *data;

@end

@implementation CommonMusicHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    CommonMessage *message = [[CommonMessage alloc] initWithHttpUrl:@"http://www.douban.com/j/app/radio/channels" params:nil];
    [self sendMessage:message];
}


- (void)initUI {
    self.channelScrollView = [[CommonMusicChannelView alloc] initWithFrame:CGRectMake(0, 0, COMMON_SCREEN_WIDTH, [CommonMusicChannelView viewHeight:_data])];
    [self.channelScrollView renderUIWithData:_data];
    [self.view addSubview:self.channelScrollView];
}


-(void)messageSuccess:(CommonMessage *)message {
    NSDictionary *data = [message getDictionaryData];
    if(!data) {
        return;
    } else {
        _data = data;
    }
    [self initUI];
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
