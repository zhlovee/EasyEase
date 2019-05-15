//
//  EE12DiZhi.m
//  EasyEase
//
//  Created by lizhenghao on 2018/10/27.
//  Copyright © 2018 lizhenghao. All rights reserved.
//

#import "EE12DiZhi.h"

@implementation EE12DiZhi

+(instancetype)byHour:(int)hour
{
    EE12DiZhiT t = CircleCalc(hour/2+hour%2, 12, 0);
    return [self byType:t];
}


+(instancetype)byMonth:(int)month
{
    EE12DiZhiT t = CircleCalcP(month, 1, 12, 2) - 1;
    return [self byType:t];
}

+(instancetype)byType:(EE12DiZhiT)t
{
    EE12DiZhi *dz = [super byType:t];
    dz->_type = t;
    return dz;
}

- (EEYY)yy
{
    return _type%2 ? EEYY_Sun : EEYY_Mon;
}

-(int)yue
{
    return CircleCalc(_type, 12, -2) + 1;
}
-(EE12ShengXiao)shengXiao
{
    return (EE12ShengXiao)self.type;
}
-(EE5Xing *)xing5
{
    switch (self.type) {
        case EE12DiZhi_Zi:
        case EE12DiZhi_Hai:{
            return [EE5Xing byType:EE5Xing_Shui];
        }
        case EE12DiZhi_Yin:
        case EE12DiZhi_Mao:{
            return [EE5Xing byType:EE5Xing_Mu];
        }
        case EE12DiZhi_Si:
        case EE12DiZhi_Wu:{
            return [EE5Xing byType:EE5Xing_Huo];
        }
        case EE12DiZhi_Shen:
        case EE12DiZhi_You:{
            return [EE5Xing byType:EE5Xing_Jin];
        }
        case EE12DiZhi_Xu:
        case EE12DiZhi_Wei:
        case EE12DiZhi_Chen:
        case EE12DiZhi_Chou:{
            return [EE5Xing byType:EE5Xing_Tu];
        }
        default:{
            return nil;
        }
    }
}

-(EE24JieQi)midJQ
{
    EE24JieQi jq = (self.yue-1)*2;
    return jq;
}
-(EE24JieQi)preJQ
{
    return CircleCalc(self.midJQ, 24, -2);
}
-(EE24JieQi)sufJQ
{
    return CircleCalc(self.midJQ, 24, 2);
}

@end
