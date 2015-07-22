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

@property (nonatomic, strong) UIView *firstView;

@property (nonatomic, strong) UIView *secondView;

@property (nonatomic, strong) UIButton *button;


@property (nonatomic, strong) UIButton *button2;


@end

@implementation CommonHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
}


- (void)initUI {
    _secondView = [[UIView alloc] initWithFrame:CGRectMake(80, 80, 100, 100)];
    _secondView.backgroundColor = [UIColor blueColor];
    _secondView.layer.transform = CATransform3DMakeTranslation(0, 0, -60);
    [self.contentView addSubview:_secondView];
    
//    _firstView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    _firstView.backgroundColor = [UIColor redColor];
//    [self.contentView addSubview:_firstView];
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setTitle:@"测试" forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.contentView addSubview:_button];
    [_button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    _button.frame = CGRectMake(100, 44, 50, 30);
    
    _button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button2 setTitle:@"测试" forState:UIControlStateNormal];
    [_button2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.contentView addSubview:_button2];
    [_button2 addTarget:self action:@selector(buttonClick2) forControlEvents:UIControlEventTouchUpInside];
    _button2.frame = CGRectMake(160, 44, 50, 30);
}

-(void)buttonClick {
    __weak UIView *weakView = _secondView;
    [UIView animateWithDuration:1 animations:^{
        weakView.layer.transform = CATransform3DRotate(CATransform3DMakeScale(0.5, 0.5, 1), 0.75, 0, 0, 1);
    }];
}

-(void)buttonClick2 {
    CATransform3D transform = CATransform3DMakeRotation(0.75,0 , 1, 0);
    _secondView.layer.transform = transform;
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}


-(BOOL)isNeedBackButton {
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
