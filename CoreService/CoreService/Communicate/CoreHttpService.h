//
//  CoreHttpService.h
//  CoreService
//
//  Created by 李彬 on 15/5/30.
//  Copyright (c) 2015年 李彬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreHttpService : NSObject

+(void)getDataWithURL:(NSString *)url block:(void (^)(NSData* data)) block;


@end
