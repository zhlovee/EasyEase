//
//  EEShenSha.m
//  EasyEase
//
//  Created by lizhenghao on 2018/11/25.
//  Copyright © 2018 lizhenghao. All rights reserved.
//

#import "EEShenSha.h"

@implementation EEShenSha

-(void)tryTaoHuaYunByDayDz:(EE12DiZhiT)dzDay yongShenDz:(EE12DiZhiT)dzYs
{
    if ([@[@(EE12DiZhi_Mao),@(EE12DiZhi_Wu),@(EE12DiZhi_You),@(EE12DiZhi_Zi)] containsObject:@(dzYs)]) {
        EE12DiZhiT t = CircleCalc(dzYs, 12, -1);
        
        EE12DiZhiT t2 = CircleCalc(dzDay, 12, 4);
        EE12DiZhiT t3 = CircleCalc(dzDay, 12, 8);
        BOOL taoHua = t == dzDay || t == t2 || t == t3;
        if (taoHua) {
            self.type |= EEShenSha_TaoHua;
        }
    }
}

-(void)tryTianYiGuiRenByDayTg:(EE10TianGanT)tgDay yongShenDz:(EE12DiZhi*)dzYs jsDz:(EE12DiZhi*)jsDz;
{
    EE12ShengXiao sxYs = (EE12ShengXiao)dzYs.type;
    EE12ShengXiao sxJs = -1;
    if (jsDz) {
        sxJs = (EE12ShengXiao)jsDz.type;
    }
//    甲戊并牛羊，乙己鼠猴乡，丙丁猪鸡位，壬癸蛇兔藏，庚辛逢虎马，此为贵人方。
    BOOL tyGR = NO, tySS = NO;
    switch (tgDay) {
        case EE10TianGan_Jia :
        case EE10TianGan_Wu :{
            tyGR = (sxYs == EE12ShengXiao_Niu || sxYs == EE12ShengXiao_Yang);
            tySS = (sxJs == EE12ShengXiao_Niu || sxJs == EE12ShengXiao_Yang);
            break;
        }
        case EE10TianGan_Yi :
        case EE10TianGan_Ji :{
            tyGR = (sxYs == EE12ShengXiao_Shu || sxYs == EE12ShengXiao_Hou);
            tySS = (sxJs == EE12ShengXiao_Shu || sxJs == EE12ShengXiao_Hou);
            break;
        }
        case EE10TianGan_Bing :
        case EE10TianGan_Ding :{
            tyGR = (sxYs == EE12ShengXiao_Zhu || sxYs == EE12ShengXiao_Ji);
            tySS = (sxJs == EE12ShengXiao_Zhu || sxJs == EE12ShengXiao_Ji);
            break;
        }
        case EE10TianGan_Ren :
        case EE10TianGan_Gui :{
            tyGR = (sxYs == EE12ShengXiao_Se || sxYs == EE12ShengXiao_Tu);
            tySS = (sxJs == EE12ShengXiao_Se || sxJs == EE12ShengXiao_Tu);
            break;
        }
        case EE10TianGan_Geng :
        case EE10TianGan_Xin :{
            tyGR = (sxYs == EE12ShengXiao_Hu || sxYs == EE12ShengXiao_Ma);
            tySS = (sxJs == EE12ShengXiao_Hu || sxJs == EE12ShengXiao_Ma);
            break;
            break;
        }
    }
    if (tyGR) {
        self.type |= EEShenSha_TYGR_GuiRen;
    }
    if (tySS) {
        self.type |= EEShenSha_TYGR_JiGuiRen;
    }
}

@end
