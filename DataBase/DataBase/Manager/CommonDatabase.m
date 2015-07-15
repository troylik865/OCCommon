//
//  CommonDatabase.m
//  Database
//
//  Created by 李彬 on 15/7/15.
//  Copyright (c) 2015年 李彬. All rights reserved.
//

#import "CommonDatabase.h"
#import <sqlite3.h>

@interface CommonDatabase () {
    sqlite3 *sqlite;
}


@end

@implementation CommonDatabase

+(instancetype)getInstance {
    static CommonDatabase *database;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        database = [[CommonDatabase alloc] init];
    });
    return database;
}

-(BOOL)open {
    int oResult = 0;
    if((oResult = sqlite3_open([self getDataFileName], &sqlite)) != SQLITE_OK){
        NSLog(@"打开数据库异常！结果码：%zi",oResult);
        return NO;
    }
    return YES;
}

#pragma mark 关闭数据库
-(BOOL) close {
    sqlite3_close(sqlite);
    sqlite = nil;
    return YES;
}


-(char *)getDataFileName {
    return (char *)[[NSHomeDirectory() stringByAppendingString:@"/Documents/sqlData.sqlite"] UTF8String];
}

-(NSArray *)executeQuery:(NSString *)sql params:(NSArray *)params {
    return nil;
}

-(BOOL)executeSql:(NSString *)sql params:(NSArray *)params {
    return YES;
}

@end
