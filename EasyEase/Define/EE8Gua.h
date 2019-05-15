//
//  EE8Gua.h
//  EasyEase
//
//  Created by lizhenghao on 2018/10/24.
//  Copyright © 2018 lizhenghao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EEYao.h"

//tian ren di,从上到下-》从左到右
typedef enum {
    EE8Gua_Qian     = 0b111,//7
    EE8Gua_Kan      = 0b010,//2
    EE8Gua_Gen      = 0b100,//4
    EE8Gua_Zhen     = 0b001,//1
    EE8Gua_Xun      = 0b110,//6
    EE8Gua_Li       = 0b101,//5
    EE8Gua_Kun      = 0b000,//0
    EE8Gua_Dui      = 0b011,//3
}EE8GuaT;

extern NSString *EE8GuaString(EE8GuaT gua);

typedef enum {
    EE8Xiang_Tian    = EE8Gua_Qian,
    EE8Xiang_Shui    = EE8Gua_Kan,
    EE8Xiang_Shan    = EE8Gua_Gen,
    EE8Xiang_Lei     = EE8Gua_Zhen,
    EE8Xiang_Feng    = EE8Gua_Xun,
    EE8Xiang_Huo     = EE8Gua_Li,
    EE8Xiang_Di      = EE8Gua_Kun,
    EE8Xiang_Ze      = EE8Gua_Dui,
}EE8Xiang;

extern NSString *EE8XiangStr(EE8Xiang xiang);

/**
 8 Gua
 */

@protocol EE8GuaProtocol <NSObject>

@end

@interface EE8Gua : NSObject <EE8GuaProtocol>

- (instancetype)initByDiY:(EEYY)diY renY:(EEYY)renY tianY:(EEYY)tianY;
- (instancetype)initByType:(EE8GuaT)type;
- (instancetype)initByXtGuaXu:(NSInteger)gx;

@property(readonly)EE8GuaT type;
@property(readonly)EE8Xiang xiang;

@property(readonly)EELocation htLocation;

@property(readonly)EE5Xing *xing5;

@property(readonly)EEYY ytTian;
@property(readonly)EEYY ytRen;
@property(readonly)EEYY ytDi;

@property(readonly)EEYao *yTian;
@property(readonly)EEYao *yRen;
@property(readonly)EEYao *yDi;

@property(readonly)EE6Shen shen6;

@end

typedef enum {
    EE8GuaPos_Inner,
    EE8GuaPos_Outer
}EE8Gua_Pos;

@class EE10TianGan;
@interface EE8GuaExt : EE8Gua

-(instancetype)initByType:(EE8GuaT)type pos:(EE8Gua_Pos)pos;

@property(readonly)EE8Gua_Pos pos;

@property(readonly)EE10TianGan *tianGan10;

@end


