//
//  EEDzJuSign.h
//  EasyEase
//
//  Created by lizhenghao on 2018/11/4.
//  Copyright © 2018 lizhenghao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    EEJuSignT_2HeJu,
    EEJuSignT_2Chong,
    EEJuSignT_2Hai,
    EEJuSignT_3HeJu,
    EEJuSignT_3Xing,
    
    EEJuSignT_JinTuiShen,
}EEJuSignT;

typedef enum {
    EE2HeJuType_None,
    EE2HeJuType_HeQi,
    EE2HeJuType_HeZhu,
    EE2HeJuType_HeHao,
    EE2HeJuType_HuaFu,
}EE2HeJuType;

@class EESignPos,EEPosSet;
/**
 解析地支与地支之间关系：对冲，2害，2合，3合，3刑
 */
@interface EEDzJuSign : NSObject

+(instancetype)tryJuSignP1:(EESignPos*)p1 p2:(EESignPos*)p2;
+(NSArray *)try3XingJuByPosSet:(EEPosSet *)set;
+(NSArray *)try3HeJuAryByPosSet:(EEPosSet*)set;
+(instancetype)tryJinTuiShenP1:(EESignPos*)p1 p2:(EESignPos*)p2;

@property(readonly)EESignPos *p1;
@property(readonly)EESignPos *p2;

@property(readonly)NSArray *heju3Ary;
@property(readonly)NSArray *xingju3Ary;
@property(readonly)NSString *xing3Str;

@property(readonly)EE5Xing *xing5;
@property(readonly)EEJuSignT type;
@property(readonly)EE2HeJuType heJu2Type;

@end
