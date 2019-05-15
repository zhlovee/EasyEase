//
//  EEYao.h
//  EasyEase
//
//  Created by lizhenghao on 2018/10/26.
//  Copyright © 2018 lizhenghao. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EE12DiZhi.h"

typedef enum {
    EESY_Null = 0,
    EESY_Shi = 1,
    EESY_Ying = 2,
}EESY;

typedef enum {
    EE6Qin_GuanGui,
    EE6Qin_FuMu,
    EE6Qin_XiongDi,
    EE6Qin_ZiSun,
    EE6Qin_QiCai,
}EE6Qin;

typedef enum {
    EEYaoPos_Shang,
    EEYaoPos_Chu,
    EEYaoPos_Er,
    EEYaoPos_San,
    EEYaoPos_Si,
    EEYaoPos_Wu,
}EEYaoPos;

typedef enum {
    EEYaoState_Jing,
    EEYaoState_Dong,
    EEYaoState_Bian
}EEYaoState;

extern EE6Qin EE6QinShWo(EE6Qin qin);
extern EE6Qin EE6QinKeWo(EE6Qin qin);
extern EE6Qin EE6QinWoSh(EE6Qin qin);
extern EE6Qin EE6QinWoKe(EE6Qin qin);

@class EE12DiZhi,EE5Xing;
@interface EEYao : NSObject

- (instancetype)initByType:(EEYY)type;
@property(nonatomic,assign)EE12DiZhiT dz12;
@property(nonatomic,assign)EE6Qin qin;
@property(nonatomic,assign)EE6Shen shen6;
@property(nonatomic,assign)EEYaoState state;
@property(nonatomic,assign)EESY shiying;
@property(nonatomic,assign)EEOmenShen oShen;
@property(nonatomic,assign)EEYaoPos pos;

@property(readonly)EEYY type;
@property(readonly)EE5Xing *xing5;
@property(readonly)EE12DiZhi *dizhi12;

@end



