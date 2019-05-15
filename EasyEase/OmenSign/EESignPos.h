//
//  EESignPos.h
//  EasyEase
//
//  Created by lizhenghao on 2018/11/4.
//  Copyright © 2018 lizhenghao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    EESignPos_Shang     = EEYaoPos_Shang,
    EESignPos_Chu       = EEYaoPos_Chu,
    EESignPos_Er        = EEYaoPos_Er,
    EESignPos_San       = EEYaoPos_San,
    EESignPos_Si        = EEYaoPos_Si,
    EESignPos_Wu        = EEYaoPos_Wu,
    
    EESignPos_Month,
    EESignPos_Day,
    EESignPos_Year,
    EESignPos_Hour,
}EESignPosT;

@interface EESignPos : NSObject

- (instancetype)initYaoPosByYao:(EEYao*)yao;

@property(readonly)EESignPosT type;

@property(readonly)EEYao *yao;
@property(readonly)EE12DiZhi *dizhi;
@property(readonly)EE5Xing  *xing;
@property(readonly)BOOL isTimePos;
@property(readonly)BOOL isBianPos;

@end

@interface EEPosSet : NSObject

- (instancetype)initByLunarDate:(EELunarDate*)date gua64:(EE64Gua*)gua;

@property(readonly)NSMutableSet *AllPos;

@property(readonly)NSMutableArray *yaoPos;
@property(readonly)NSMutableArray *yao6Pos;
@property(readonly)NSMutableSet *yaoBianPos;
@property(readonly)NSMutableSet *yaoDongPos;

@property(readonly)EESignPos *dayPos;
@property(readonly)EESignPos *monthPos;

@end
