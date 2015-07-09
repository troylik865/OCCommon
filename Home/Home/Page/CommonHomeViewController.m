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

@end

@implementation CommonHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.navigationController.navigationBarHidden = YES;
    ClickButton *button = [[ClickButton alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
    button.backgroundColor = [UIColor blackColor];
    button.block = ^(int a,int b) {
        return a + b;
    };
    [self.view addSubview:button];
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
