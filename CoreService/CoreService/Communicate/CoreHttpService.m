//
//  CoreHttpService.m
//  CoreService
//
//  Created by 李彬 on 15/5/30.
//  Copyright (c) 2015年 李彬. All rights reserved.
//

#import "CoreHttpService.h"
#import <UIKit/UIKit.h>

@implementation CoreHttpService

+(void)getDataWithURL:(NSString *)url block:(void (^)(NSData* data)) block {
    
    if(STRING_IS_BLANK(url)) {
        block(nil);
        return;
    }
    
    NSURL *realUrl = [NSURL URLWithString:url];
    if(!realUrl) {
        block(nil);
        return;
    }
    
    /**
     *  1。获取文件名
     *  2。进行文件是否存在的判断
     *  3。如果存在的情况下直接读取，如果不存在的情况下进行网络请求 如果需要缓存的文件数据就进行文件存储
     */
    NSString *md5Name = [url md5];
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *filePath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:md5Name];
    if([manager fileExistsAtPath:filePath]){
        NSData *data = [manager contentsAtPath:filePath];
        block(data);
    } else {
        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:realUrl] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            block(data);
            
            if(!data || !connectionError) {
                return;
            }
            //将文件写入
            [manager createFileAtPath:filePath contents:data attributes:nil];
        }];
    }
}

@end
