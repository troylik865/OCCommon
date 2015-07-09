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
    CommonMessage *message = [[CommonMessage alloc] initWithHttpUrl:@"https://gtms01.alicdn.com/tps/i1/TB19acUIpXXXXX2XXXXvKyzTVXX-520-280.jpg" params:nil];
    [self sendMessage:message];
}


-(void)messageSuccess:(CommonMessage *)message {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    typeof(UIImageView) *weakSelf = imageView;
    dispatch_async(dispatch_get_main_queue(), ^{
        imageView.image = [UIImage imageWithData:message.data];
        [self.view addSubview:imageView];
    });
    
}



-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
