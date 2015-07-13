//
//  CommonMessage.h
//  CommonUI
//
//  Created by 李彬 on 15/7/9.
//  Copyright (c) 2015年 李彬. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    MessageTypeHttpPOST,        //HTTP调用    POST方式
    MessageTypeHttpGET,         //HTTP调用    GET方式
    MessageTypeCommon       //和服务器之间利用某种协议封装的类型
} MessageType;

@interface CommonMessage : NSObject

/**
 *  消息类型MessageType
 */
@property (nonatomic, assign) long type;

/**
 *  api的名字 如果是http的请求
 */
@property (nonatomic, strong) NSString *apiName;

/**
 *  api版本
 */
@property (nonatomic, strong) NSString *version;

/**
 *  请求携带的参数
 */
@property (nonatomic, strong) NSDictionary *params;

/**
 *  返回的数据
 */
@property (nonatomic, strong) NSData *data;


/**
 *  由data装换过的NSString格式的内容
 */
@property (nonatomic, strong) NSString *content;

/**
 *  默认使用get方式
 *
 *  @param url    需要请求的url
 *  @param params 参数
 *  @returns 消息对象
 */
- (instancetype)initWithHttpUrl:(NSString *)url params:(NSDictionary *)params;

/**
 *  可以传请求类型的的方法
 *
 *  @param url    需要请求的url
 *  @param params 参数列表
 *  @param method 方法类型
 *  @returns 消息对象
 */
- (instancetype)initWithHttpUrl:(NSString *)url params:(NSDictionary *)params method:(NSString *)method;


/**
 *  请求的消息
 *
 *  @param apiName api的名称
 *  @param params  参数
 *  @param version api版本
 *  @returns 消息对象
 */
- (instancetype)initWithApiName:(NSString *)apiName params:(NSDictionary *)params version:(NSString *)version;

/**
 *  获取字典类型的数据
 *
 *  @returns 字典类型
 */
- (NSDictionary *)getDictionaryData;

@end
