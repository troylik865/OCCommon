//
//  CommonDatabase.h
//  Database
//
//  Created by 李彬 on 15/7/15.
//  Copyright (c) 2015年 李彬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonDatabase : NSObject

/**
 *  文件是否打开
 */
@property (nonatomic, assign) BOOL isFileOpen;

@property (nonatomic, strong) NSString *name;

/**
 *  获取数据库操作对象
 *
 *  @returns 操作对象
 */
+ (instancetype)getInstance;

/**
 *  打开数据库文件
 *
 *  @returns 是否成功
 */
- (BOOL)open;


/**
 *  关闭数据库文件
 *
 *  @returns 是否关闭成功
 */
- (BOOL)close;

/**
 *  执行查询操作
 *
 *  @param sql    sql语句
 *  @param params 参数列表
 *
 *  @returns 结果集
 */
-(NSArray *)executeQuery:(NSString *)sql params:(NSArray *)params;

/**
 *  执行sql语句
 *
 *  @param sql    sql语句
 *  @param params 参数
 *
 *  @returns 执行结果
 */
-(BOOL)executeSql:(NSString *)sql params:(NSArray *)params;



@end
