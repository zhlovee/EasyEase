//
//  EE10TianGan.h
//  EasyEase
//
//  Created by lizhenghao on 2018/10/27.
//  Copyright © 2018 lizhenghao. All rights reserved.
//

#import "EETaiChi.h"

typedef enum {
    EE10TianGan_Jia,
    EE10TianGan_Yi,
    EE10TianGan_Bing,
    EE10TianGan_Ding,
    EE10TianGan_Wu,
    EE10TianGan_Ji,
    EE10TianGan_Geng,
    EE10TianGan_Xin,
    EE10TianGan_Ren,
    EE10TianGan_Gui,
}EE10TianGanT;

@class EE5Xing;
@interface EE10TianGan : EEObject

+(instancetype)byType:(EE10TianGanT)t;
@property(readonly)EE10TianGanT type;

@property(readonly)EE6Shen shen6;
@property(readonly)EE5Xing *xing5;

@property(readonly)EEYY yy;

@end
