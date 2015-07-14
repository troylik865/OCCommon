//
//  NSString+CoreService.m
//  CoreService
//
//  Created by 李彬 on 15/7/7.
//  Copyright (c) 2015年 李彬. All rights reserved.
//

#import "NSString+CoreService.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (CoreService)

- (NSString *)md5 {
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result );
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}


-(NSInteger)indexOf:(NSString *)charact {
    NSRange range = [self rangeOfString:charact];
    if(range.location == NSNotFound) {
        return -1;
    }
    return range.location;
}
@end
