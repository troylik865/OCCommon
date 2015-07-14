//
//  CommonPageViewController.h
//  CommonUI
//
//  Created by 李彬 on 15/5/30.
//  Copyright (c) 2015年 李彬. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CommonMessage;

@interface CommonPageViewController : UIViewController

@property (nonatomic, strong) NSDictionary *pageParams;

@property (nonatomic, strong) UIView *contentView;

- (BOOL) isNeedBackButton;


- (void)sendMessage:(CommonMessage *)message;


- (void)messageSuccess:(CommonMessage *)message;

- (void)messageFailed:(CommonMessage *)message;

- (void)messageCancel:(CommonMessage *)message;

@end
