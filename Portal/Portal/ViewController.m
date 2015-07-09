//
//  ViewController.m
//  Portal
//
//  Created by 李彬 on 15/5/30.
//  Copyright (c) 2015年 李彬. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    NSString *controllerName = @"CommonHomeViewController";
    [self.navigationController pushViewController:[[NSClassFromString(controllerName) alloc] init] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
