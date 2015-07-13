//
//  NSString+Common.m
//  CommonUI
//
//  Created by 李彬 on 15/7/7.
//  Copyright (c) 2015年 李彬. All rights reserved.
//

#import "NSString+Common.h"
#import "RangeModel.h"

@implementation NSString (Common)


- (NSArray *)indexsInString:(NSString *)str ignoreCase:(BOOL)ignore {
    NSMutableArray *array = [NSMutableArray array];
    NSUInteger begin = 0;
    NSString *content = ignore ? [[self copy] lowercaseString] : [self copy];
    NSString *compareStr = ignore ? [str lowercaseString] : str;
    while (YES) {
        NSRange range = [content rangeOfString:compareStr];
        if (range.location == NSNotFound) {
            return array;
        }
        [array addObject:[RangeModel createRangeModelBegin:range.location + begin length:range.length]];
        begin += range.location + range.length;
        content = [content substringFromIndex:(range.location + range.length)];
    }
    return array;
}

+(NSString *)insert:(NSArray *)strs separation:(NSString *)sep {
    NSInteger count = strs.count;
    NSMutableString *str = [NSMutableString string];
    for (int i = 0; i < count; i++ ) {
        NSString *s = [strs objectAtIndex:i];
        if(STRING_IS_BLANK(s)) {
            continue;
        }
        [str appendString:s];
        if(i != (count - 1)){
            [str appendString:sep];
        }
    }
    return str;
}

- (NSDictionary *)dictionaryWithJsonString {
    if (self == nil) {
        return nil;
    }
    
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


@end
