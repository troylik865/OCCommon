//
//  UIView+CommonUI.h
//  CommonUI
//
//  Created by 李彬 on 15/7/13.
//  Copyright (c) 2015年 李彬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonMessage.h"

@interface UIView (CommonUI)



- (void)sendMessage:(CommonMessage *)message;

- (void)messageSuccess:(CommonMessage *)message;

- (void)messageFailed:(CommonMessage *)message;

- (void)messageCancel:(CommonMessage *)message;


@end
