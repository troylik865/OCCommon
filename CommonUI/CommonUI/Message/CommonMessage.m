//
//  CommonMessage.m
//  CommonUI
//
//  Created by 李彬 on 15/7/9.
//  Copyright (c) 2015年 李彬. All rights reserved.
//

#import "CommonMessage.h"

@implementation CommonMessage

-(instancetype)initWithApiName:(NSString *)apiName params:(NSDictionary *)params version:(NSString *)version {
    self = [super init];
    if(self) {
        _apiName = apiName;
        _params = params;
        _version = version;
        _type = MessageTypeCommon;
    }
    return self;
}

-(instancetype)initWithHttpUrl:(NSString *)url params:(NSDictionary *)params {
    return [self initWithHttpUrl:url params:params method:@"get"];
}


-(instancetype)initWithHttpUrl:(NSString *)url params:(NSDictionary *)params method:(NSString *)method {
    self = [super init];
    if(self) {
        _apiName = url;
        _params = params;
        _type = [[method lowercaseString] isEqualToString:@"post"]?MessageTypeHttpPOST:MessageTypeHttpGET;
    }
    return self;
}


@end
