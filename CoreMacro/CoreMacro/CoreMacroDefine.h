//
//  CoreMacroDefine.h
//  CoreMacro
//
//  Created by 李彬 on 15/7/7.
//  Copyright (c) 2015年 李彬. All rights reserved.
//

#ifndef CoreMacro_CoreMacroDefine_h
#define CoreMacro_CoreMacroDefine_h

//判空
#define STRING_IS_BLANK(str) (str==nil ||![str isKindOfClass:[NSString class]]|| [str length]<1)
#define STRING_DEFAULT_BLANK(str) ((str==nil)?@"":str)
#define STRING_DEFAULT_IF_BLANK(str,defaultStr)  STRING_IS_BLANK(str) ? defaultStr:str
#define DICTIONARY_IS_EMPTY(dic) ((dic)==nil || ![(dic) isKindOfClass:[NSDictionary class]] || (dic).count < 1)
#define ARRAY_IS_EMPTY(array) ((array)==nil || ![(array) isKindOfClass:[NSArray class]] || (array).count < 1)

//如果从字典中获取到的数据为空的情况下，默认返回空字符串
#define DEFAULT_BLANK_IN_DICTIONARY(data,key) [data objectForKey:key] == nil?@"":[data objectForKey:key]

//如果对象不为空的情况下 放入字典
#define ADD_TO_DIC_IF_NOT_NULL(obj,params,key) if(obj!=nil)[params setObject:obj forKey:key]

#define COMMON_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define COMMON_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define SafeRelease(obj) if(obj) obj = nil

//判断系统版本
#define iOSVersionGreaterThan(v)          ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)

//navigationBar高度
#define COMMON_NAVIBAR_HEIGHT 44

#endif
