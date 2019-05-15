//
//  EE12DiZhi.h
//  EasyEase
//
//  Created by lizhenghao on 2018/10/27.
//  Copyright © 2018 lizhenghao. All rights reserved.
//

#import "EETaiChi.h"

/**
 
 巳      午       未       申
 Si      Wu      Wei     Shen
 
 辰 Chen                    You 酉
 
 卯  Mao                     Xu 戌
 
 Yin     Chou    Zi      Hai
 寅       丑      子       亥
 
 二合局
 ----Shui-----
 |   |Tu |   |
 6   7   8   9
 5----Jin----10
 4----Huo----11
 3   2   1   12
 |   | Tu|    |
 ------Mu------
 
 三合局
 %4    $5    #6     @7
 @3                 %8
 #2                 $9
 $1    %12   @11   #10
 @Shui
 #Mu
 $Huo
 %Jin
 */

typedef enum {
    EE12DiZhi_Zi,
    EE12DiZhi_Chou,
    EE12DiZhi_Yin,
    EE12DiZhi_Mao,
    EE12DiZhi_Chen,
    EE12DiZhi_Si,
    EE12DiZhi_Wu,
    EE12DiZhi_Wei,
    EE12DiZhi_Shen,
    EE12DiZhi_You,
    EE12DiZhi_Xu,
    EE12DiZhi_Hai,
}EE12DiZhiT;

typedef enum {
    EE12Month_1  = EE12DiZhi_Yin,
    EE12Month_2  = EE12DiZhi_Mao,
    EE12Month_3  = EE12DiZhi_Chen,
    EE12Month_4  = EE12DiZhi_Si,
    EE12Month_5  = EE12DiZhi_Wu,
    EE12Month_6  = EE12DiZhi_Wei,
    EE12Month_7  = EE12DiZhi_Shen,
    EE12Month_8  = EE12DiZhi_You,
    EE12Month_9  = EE12DiZhi_Xu,
    EE12Month_10 = EE12DiZhi_Hai,
    EE12Month_11 = EE12DiZhi_Zi,
    EE12Month_12 = EE12DiZhi_Chou,
}EE12Month;

typedef enum {
    EE12ShengXiao_Shu   = EE12DiZhi_Zi,
    EE12ShengXiao_Niu   = EE12DiZhi_Chou,
    EE12ShengXiao_Hu    = EE12DiZhi_Yin,
    EE12ShengXiao_Tu    = EE12DiZhi_Mao,
    EE12ShengXiao_Long  = EE12DiZhi_Chen,
    EE12ShengXiao_Se    = EE12DiZhi_Si,
    EE12ShengXiao_Ma    = EE12DiZhi_Wu,
    EE12ShengXiao_Yang  = EE12DiZhi_Wei,
    EE12ShengXiao_Hou   = EE12DiZhi_Shen,
    EE12ShengXiao_Ji    = EE12DiZhi_You,
    EE12ShengXiao_Gou   = EE12DiZhi_Xu,
    EE12ShengXiao_Zhu   = EE12DiZhi_Hai
}EE12ShengXiao;

typedef enum {
    EE24JieQi_LiChun,//1
    EE24JieQi_ChunYu,
    EE24JieQi_JingZe,//2
    EE24JieQi_ChunFen,
    EE24JieQi_QingMing,//3
    EE24JieQi_GuYu,
    EE24JieQi_LiXia,//4
    EE24JieQi_XiaoMan,
    EE24JieQi_MangZhong,//5
    EE24JieQi_XiaZhi,
    EE24JieQi_XiaoShu,//6
    EE24JieQi_DaShu,
    EE24JieQi_LiQiu,//7
    EE24JieQi_ChuShu,
    EE24JieQi_BaiLu,//8
    EE24JieQi_QiuFen,
    EE24JieQi_HanLu,//9
    EE24JieQi_ShuangJiang,
    EE24JieQi_LiDong,//10
    EE24JieQi_XiaoXue,
    EE24JieQi_DaXue,//11
    EE24JieQi_DongZhi,
    EE24JieQi_XiaoHan,//12
    EE24JieQi_DaHan,
}EE24JieQi;

@class EE5Xing;
@interface EE12DiZhi : EEObject

+(instancetype)byHour:(int)hour;
+(instancetype)byMonth:(int)month;
+(instancetype)byType:(EE12DiZhiT)t;
@property(readonly)EE12DiZhiT type;
@property(readonly)EEYY yy;
@property(readonly)EE5Xing *xing5;
@property(readonly)EE12ShengXiao shengXiao;
@property(readonly)int yue;

@property(readonly)EE24JieQi preJQ;
@property(readonly)EE24JieQi midJQ;
@property(readonly)EE24JieQi sufJQ;

@end
