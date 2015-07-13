//
//  CoreHttpService.h
//  CoreService
//
//  Created by 李彬 on 15/5/30.
//  Copyright (c) 2015年 李彬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreHttpService : NSObject

+ (void)getDataWithURL:(NSString *)url block:(void (^)(NSData *data, NSError *connectionError))block;

+ (void)getDataWithURL:(NSString *)url needCache:(BOOL)needCache block:(void (^)(NSData *data, NSError *connectionError))block;

+ (void)getDataWithUURL:(NSString *)url params:(NSDictionary *)params method:(NSString *)method needCache:(BOOL)needCache block:(void (^)(NSData *, NSError *))block;


@end
