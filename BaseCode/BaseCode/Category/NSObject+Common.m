//
//  NSObject+Common.m
//  BaseCode
//
//  Created by 李彬 on 15/7/16.
//  Copyright (c) 2015年 李彬. All rights reserved.
//

#import "NSObject+Common.h"
#import <objc/runtime.h>

@implementation NSObject (Common)


/**
 *  遍历对象里面所有的属性
 *
 *  @returns 属性列表
 */
- (NSArray *)propertyKeys {
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    NSMutableArray *keys = [[NSMutableArray alloc] initWithCapacity:outCount];
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        [keys addObject:propertyName];
    }
    free(properties);
    return keys;
}

/**
 *  替换方法
 */
-(void)exchangeMethod {
    Method method1 = class_getInstanceMethod([NSString class], @selector(lowercaseString));
    Method method2 = class_getInstanceMethod([self class], @selector(test));
    method_exchangeImplementations(method1, method2);
    NSLog(@"lowcase of WENG zilin:%@", [@"WENG zilin" lowercaseString]);
    NSLog(@"uppercase of WENG zilin:%@", [@"WENG zilin" uppercaseString]);
}


-(NSString *)test {
    if([self isKindOfClass:[NSString class]]){
        NSLog(@"%@",self);
    }
    return @"111";
}

/**
 *  利用方法进行属性的赋值
 */
//- (void)setAttribute:(NSDictionary *)data {
//    unsigned int count = 0;
//    Method *memberFuncs = class_copyMethodList([self class], &count);
//    for (int i = 0; i < count; i++) {
//        SEL name = method_getName(memberFuncs[i]);
//        NSString *methodName = [NSString stringWithCString:sel_getName(name) encoding:NSUTF8StringEncoding];
//        NSLog(@"member method:%@", methodName);
//        if([methodName isEqualToString:@"setName:"]) {
//            [self performSelector:name withObject:@"fuck"];
//        }
//    }
//}

/**
 *  进行对象的属性赋值
 *
 *  @param data 字典类型的数据，key需要和属性名相同
 */
- (void)setAttribute:(NSDictionary *)data {
    NSArray *attributes = [self propertyKeys];
    for (NSString *paramName in attributes) {
        id value = [data objectForKey:paramName];
        if (!value) {
            continue;
        }
        object_setIvar(self, class_getInstanceVariable([self class], [[NSString stringWithFormat:@"_%@", paramName] UTF8String]), value);
    }
}

@end
