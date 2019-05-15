//
//  EE10TianGan.m
//  EasyEase
//
//  Created by lizhenghao on 2018/10/27.
//  Copyright © 2018 lizhenghao. All rights reserved.
//

#import "EE10TianGan.h"

@implementation EE10TianGan

+ (instancetype)byType:(EE10TianGanT)t
{
    EE10TianGan *tg = [super byType:t];
    tg->_type = t;
    return tg;
}

- (EEYY)yy
{
    return _type%2 ? EEYY_Sun : EEYY_Mon;
}

-(EE6Shen)shen6
{
    switch (self.type) {
        case EE10TianGan_Jia:
        case EE10TianGan_Yi:{
            return EE6Shen_QingLong;
        }
        case EE10TianGan_Bing:
        case EE10TianGan_Ding:{
            return EE6Shen_ZhuQue;
        }
        case EE10TianGan_Wu:
            return EE6Shen_GouChen;
        case EE10TianGan_Ji:{
            return EE6Shen_TengSe;
        }
        case EE10TianGan_Geng:
        case EE10TianGan_Xin:{
            return EE6Shen_BaiHu;
        }
        case EE10TianGan_Ren:
        case EE10TianGan_Gui:{
            return EE6Shen_XuanWu;
        }
        default:{
            return EENotFound;
        }
    }
}

-(EE5Xing *)xing5
{
    switch (self.type) {
        case EE10TianGan_Jia:
        case EE10TianGan_Yi:{
            return [EE5Xing byType:EE5Xing_Mu];
        }
        case EE10TianGan_Bing:
        case EE10TianGan_Ding:{
            return [EE5Xing byType:EE5Xing_Huo];
        }
        case EE10TianGan_Wu:
        case EE10TianGan_Ji:{
            return [EE5Xing byType:EE5Xing_Tu];
        }
        case EE10TianGan_Geng:
        case EE10TianGan_Xin:{
            return [EE5Xing byType:EE5Xing_Jin];
        }
        case EE10TianGan_Ren:
        case EE10TianGan_Gui:{
            return [EE5Xing byType:EE5Xing_Shui];
        }
        default:{
            return nil;
        }
    }
}

@end
