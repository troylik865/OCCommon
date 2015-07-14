//
//  CommonPageViewController.m
//  CommonUI
//
//  Created by 李彬 on 15/5/30.
//  Copyright (c) 2015年 李彬. All rights reserved.
//

#import "CommonPageViewController.h"
#import "CommonMessage.h"

@interface CommonPageViewController ()

@property (nonatomic, strong) UIButton *backButton;

@end

@implementation CommonPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initPageViewUI];
}

-(BOOL)isNeedBackButton {
    return YES;
}

-(void)initPageViewUI {
    _contentView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_contentView];
    
    if([self isNeedBackButton]){
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.frame = CGRectMake(20, 30, 40, 40);
        _backButton.layer.cornerRadius = 20;
        _backButton.imageView.frame = _backButton.bounds;
        [_backButton setImage:[UIImage imageLoader:@"common_back"] forState:UIControlStateNormal];
        _backButton.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.4];
        [self.view addSubview:_backButton];
        [_backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)sendMessage:(CommonMessage *)message {
    if (message.type == MessageTypeHttpGET) {
        NSDictionary *params = message.params;
        NSString *realUrl;
        if(params) {
            NSString *url = message.apiName;
            
            NSMutableString *paramStr = [NSMutableString string];
            if([url rangeOfString:@"?"].location == NSNotFound) {
                int count = 0;
                for (NSString *key in params.keyEnumerator) {
                    if(++count == 1) {
                        [paramStr appendString:@"?"];
                    } else {
                        [paramStr appendString:@"&"];
                    }
                    [paramStr appendString:[NSString stringWithFormat:@"%@=%@",key,[params objectForKey:key]]];
                }
            } else {
                for (NSString *key in params.keyEnumerator) {
                    [paramStr appendString:[NSString stringWithFormat:@"&%@=%@",key,[params objectForKey:key]]];
                }
            }
            realUrl = [NSString stringWithFormat:@"%@%@",url,paramStr];
        } else {
            realUrl = message.apiName;
        }
        __weak CommonPageViewController *weakSelf = self;
        [CoreHttpService getDataWithURL:realUrl block:^(NSData *data,NSError *connectionError) {
            if(data) {
                message.data = data;
                if([weakSelf respondsToSelector:@selector(messageSuccess:)]) {
                    [weakSelf performSelectorOnMainThread:@selector(messageSuccess:) withObject:message waitUntilDone:NO];
                }
            } else {
                if([weakSelf respondsToSelector:@selector(messageFailed:)]) {
                    [weakSelf performSelectorOnMainThread:@selector(messageFailed:) withObject:message waitUntilDone:NO];
                }
            }
        }];
    }
    else if (message.type == MessageTypeHttpPOST) {
        __weak CommonPageViewController *weakSelf = self;
        [CoreHttpService getDataWithUURL:message.apiName params:message.params method:@"post" needCache:NO block:^(NSData * data, NSError *connectionError) {
            if(data) {
                message.data = data;
                if([weakSelf respondsToSelector:@selector(messageSuccess:)]) {
                    [weakSelf performSelectorOnMainThread:@selector(messageSuccess:) withObject:message waitUntilDone:NO];
                }
            } else {
                if([weakSelf respondsToSelector:@selector(messageFailed:)]) {
                    [weakSelf performSelectorOnMainThread:@selector(messageFailed:) withObject:message waitUntilDone:NO];
                }
            }

        }];
    }
    
    //封装了协议的通讯方式（待有服务端配合的时候实现）
    else if (message.type == MessageTypeCommon) {
        
        
    }
}

-(void)messageFailed:(CommonMessage *)message {
    
}

-(void)messageCancel:(CommonMessage *)message {
    
}

-(void)messageSuccess:(CommonMessage *)message {
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
