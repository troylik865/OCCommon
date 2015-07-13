//
//  CommonHomeViewController.m
//  Home
//
//  Created by 李彬 on 15/5/30.
//  Copyright (c) 2015年 李彬. All rights reserved.
//

#import "CommonHomeViewController.h"
#import "ClickButton.h"

@interface CommonHomeViewController ()

@property (nonatomic, strong) UIScrollView *channelScrollView;

@property (nonatomic, strong) NSDictionary *data;

@end

@implementation CommonHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    CommonMessage *message = [[CommonMessage alloc] initWithHttpUrl:@"http://www.douban.com/j/app/radio/channels" params:nil];
    [self sendMessage:message];
}


- (void)initUI {
    float y = 0;
    if(iOSVersionGreaterThan(@"7.0")) {
        y = 20;
    }
    self.channelScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, y, COMMON_SCREEN_WIDTH, 44)];
    self.channelScrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.channelScrollView];
}


-(void)messageSuccess:(CommonMessage *)message {
    NSDictionary *data = [message getDictionaryData];
    if(!data) {
        return;
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
