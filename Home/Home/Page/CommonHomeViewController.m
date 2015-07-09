//
//  CommonHomeViewController.m
//  Home
//
//  Created by 李彬 on 15/5/30.
//  Copyright (c) 2015年 李彬. All rights reserved.
//

#import "CommonHomeViewController.h"

@interface CommonHomeViewController ()

@end

@implementation CommonHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.navigationController.navigationBarHidden = YES;
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
