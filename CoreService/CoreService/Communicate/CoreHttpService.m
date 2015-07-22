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

+ (void)getDataWithURL:(NSString *)url block:(void (^)(NSData *data, NSError *connectionError))block {
    [CoreHttpService getDataWithURL:url needCache:NO block:block];
}

+ (void)getDataWithURL:(NSString *)url needCache:(BOOL)needCache block:(void (^)(NSData *data, NSError *connectionError))block {
    [CoreHttpService getDataWithUURL:url params:nil method:@"get" needCache:needCache block:block];
}

/**
 *  判断文件是否存在
 *
 *  @param url 文件链接地址
 *
 *  @returns 对应URL文件如果存在的情况下 就返回该文件的本地路径
 */
+ (NSString *)fileExist:(NSString *)url {
    NSFileManager *manager = [NSFileManager defaultManager];
    
    NSURL *realUrl = [NSURL URLWithString:url];
    NSArray *params = [realUrl pathComponents];
    NSString *fileName = [params objectAtIndex:params.count - 1];
    NSString *extend = [fileName substringFromIndex:[fileName indexOf:@"."]];
    NSString *md5Name = [NSString stringWithFormat:@"%@%@",[url md5],extend];
    NSString *filePath = [[[NSHomeDirectory() stringByAppendingPathComponent:@"Library"] stringByAppendingPathComponent:@"Caches"] stringByAppendingPathComponent:md5Name];
    if ([manager fileExistsAtPath:filePath]) {
        return filePath;
    }
    return nil;
}

+ (void)getDataWithUURL:(NSString *)url params:(NSDictionary *)params method:(NSString *)method needCache:(BOOL)needCache block:(void (^)(NSData *, NSError *))block {
    if (STRING_IS_BLANK(url)) {
        block(nil, nil);
        return;
    }
    
    NSURL *realUrl = [NSURL URLWithString:url];
    if (!realUrl) {
        block(nil, nil);
        return;
    }
    
    NSString *lowerMethod = [method lowercaseString];
    if ([@"get" isEqualToString:lowerMethod] || [@"post" isEqualToString:lowerMethod]) {
        NSFileManager *manager = [NSFileManager defaultManager];
        
        NSString *filePath;
        
        //如果需要缓存的情况下
        if (needCache) {
            /**
             *  1。获取文件名
             *  2。进行文件是否存在的判断
             *  3。如果存在的情况下直接读取，如果不存在的情况下进行网络请求 如果需要缓存的文件数据就进行文件存储
             */
            
            NSArray *params = [realUrl pathComponents];
            NSString *fileName = [params objectAtIndex:params.count - 1];
            NSString *extend = [fileName substringFromIndex:[fileName indexOf:@"."]];
            NSString *md5Name = [NSString stringWithFormat:@"%@%@",[url md5],extend];
            filePath = [[[NSHomeDirectory() stringByAppendingPathComponent:@"Library"] stringByAppendingPathComponent:@"Caches"] stringByAppendingPathComponent:md5Name];
            if ([manager fileExistsAtPath:filePath]) {
                NSData *data = [manager contentsAtPath:filePath];
                block(data, nil);
                return;
            }
        }
        
        NSURLRequest *request;
        
        if ([@"get" isEqualToString:[method lowercaseString]]) {
            request = [NSURLRequest requestWithURL:realUrl];
        }
        else {
            NSMutableURLRequest *mutableRequest = [[NSMutableURLRequest alloc] initWithURL:realUrl];
            [mutableRequest setHTTPMethod:@"POST"];
            [mutableRequest setHTTPBody:[[params JSONString] dataUsingEncoding:NSUTF8StringEncoding]];
            request = mutableRequest;
        }
        [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler: ^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            
            if (!data || connectionError) {
                return;
            }
            
            if (needCache) {
                //将文件写入
                [manager createFileAtPath:filePath contents:data attributes:nil];
            }
            block(data, connectionError);
        }];
        
        return;
    }
    else {
        //暂时不处理
    }
}

@end
