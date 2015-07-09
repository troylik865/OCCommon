//
//  CoreServiceFileManager.h
//  CoreService
//
//  Created by 李彬 on 15/7/7.
//  Copyright (c) 2015年 李彬. All rights reserved.
//

#import <Foundation/Foundation.h>

//文件了II型
typedef enum {
    CACHE_FILE,             //缓存文件 ：会有一定的cache时间，例：几天
    DOCUMENT_FILE,          //文档文件 ：存在周期比较长，不受系统干涉
    TEMPORARY_FILE          //临时文件 ：随着应用的退出就销毁
} FILE_TYPE;

@interface CoreServiceFileManager : NSObject


+ (NSString *)storeFile:(NSData *)data fileName:(NSString *)fileName fileType:(FILE_TYPE)type;


@end
