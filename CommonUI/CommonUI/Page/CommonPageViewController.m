//
//  CommonPageViewController.m
//  CommonUI
//
//  Created by 李彬 on 15/5/30.
//  Copyright (c) 2015年 李彬. All rights reserved.
//

#import "CommonPageViewController.h"

@interface CommonPageViewController ()

@end

@implementation CommonPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *view = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [view setImageUrl:@"https://gtms01.alicdn.com/tps/i1/TB19acUIpXXXXX2XXXXvKyzTVXX-520-280.jpg"];
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
