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

@end

@implementation CommonPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
        typeof(CommonMessage) *weakMessage = message;
        typeof(CommonPageViewController) *weakSelf = self;
        [CoreHttpService getDataWithURL:realUrl block:^(NSData *data,NSError *connectionError) {
            if(data) {
                weakMessage.data = data;
                if([weakSelf respondsToSelector:@selector(messageSuccess:)]) {
                    [weakSelf performSelector:@selector(messageSuccess:) withObject:weakMessage];
                }
            } else {
                if([weakSelf respondsToSelector:@selector(messageFailed:)]) {
                    [weakSelf performSelector:@selector(messageFailed:) withObject:weakMessage];
                }
            }
        }];
    }
    else if (message.type == MessageTypeHttpPOST) {
    }
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
