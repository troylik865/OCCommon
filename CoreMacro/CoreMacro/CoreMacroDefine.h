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


#endif
