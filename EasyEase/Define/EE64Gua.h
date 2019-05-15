//
//  EE64Gua.h
//  EasyEase
//
//  Created by lizhenghao on 2018/10/24.
//  Copyright © 2018 lizhenghao. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EE8Gua.h"

typedef enum {
    EE8Gong_Qian  = EE8Gua_Qian,
    EE8Gong_Zhen  = EE8Gua_Zhen,
    EE8Gong_Kan  = EE8Gua_Kan,
    EE8Gong_Gen  = EE8Gua_Gen,
    EE8Gong_Kun  = EE8Gua_Kun,
    EE8Gong_Xun  = EE8Gua_Xun,
    EE8Gong_Li  = EE8Gua_Li,
    EE8Gong_Dui  = EE8Gua_Dui
}EE8Gong;

typedef enum {
    EEJF16GuaBian_0_ChunShi,
    EEJF16GuaBian_1_Shi,
    EEJF16GuaBian_2_Shi,
    EEJF16GuaBian_3_Shi,
    EEJF16GuaBian_4_Shi,
    EEJF16GuaBian_5_Shi,
    EEJF16GuaBian_6_YouHun,
    EEJF16GuaBian_7_WaiJie,
    EEJF16GuaBian_8_NeiJie,
    EEJF16GuaBian_9_GuiHun,
    EEJF16GuaBian_10_JueMing,
    EEJF16GuaBian_11_XueMai,
    EEJF16GuaBian_12_JiRou,
    EEJF16GuaBian_13_HaiGu,
    EEJF16GuaBian_14_GuanGuo,
    EEJF16GuaBian_15_ZhongMu,
}EEJF16GuaBian;

typedef enum {
    EEJF8GuaBian_0_ChunShi = EEJF16GuaBian_0_ChunShi,
    EEJF8GuaBian_1_1Shi = EEJF16GuaBian_1_Shi,
    EEJF8GuaBian_2_2Shi = EEJF16GuaBian_2_Shi,
    EEJF8GuaBian_3_3Shi = EEJF16GuaBian_3_Shi,
    EEJF8GuaBian_4_4Shi = EEJF16GuaBian_4_Shi,
    EEJF8GuaBian_5_5Shi = EEJF16GuaBian_5_Shi,
    EEJF8GuaBian_6_YouHun = EEJF16GuaBian_6_YouHun,
    EEJF8GuaBian_7_GuiHun = EEJF16GuaBian_9_GuiHun,
}EEJF8GuaBian;

typedef enum {
    //乾宫——————————————————————————————————————————————————
    EE64Gua_Qian    = (EE8Xiang_Tian<<3)+EE8Xiang_Tian,
    
    EE64Gua_Gou     = (EE8Xiang_Tian<<3)+EE8Xiang_Feng,
    EE64Gua_Dun     = (EE8Xiang_Tian<<3)+EE8Xiang_Shan,
    EE64Gua_Pi      = (EE8Xiang_Tian<<3)+EE8Xiang_Di,
    EE64Gua_Guan    = (EE8Xiang_Feng<<3)+EE8Xiang_Di,
    EE64Gua_Bo      = (EE8Xiang_Shan<<3)+EE8Xiang_Di,
    
    EE64Gua_Jin     = (EE8Xiang_Huo<<3)+EE8Xiang_Di,
    EE64Gua_DaYou   = (EE8Xiang_Huo<<3)+EE8Xiang_Tian,
    
    //震宫——————————————————————————————————————————————————
    EE64Gua_Zhen    = (EE8Xiang_Lei<<3)+EE8Xiang_Lei,
    
    EE64Gua_Yu      = (EE8Xiang_Lei<<3)+EE8Xiang_Di,
    EE64Gua_Jie3     = (EE8Xiang_Lei<<3)+EE8Xiang_Shui,
    EE64Gua_Heng    = (EE8Xiang_Lei<<3)+EE8Xiang_Feng,
    EE64Gua_Sheng   = (EE8Xiang_Di<<3)+EE8Xiang_Feng,
    EE64Gua_Jing    = (EE8Xiang_Shui<<3)+EE8Xiang_Feng,
    
    EE64Gua_DaGuo   = (EE8Xiang_Ze<<3)+EE8Xiang_Feng,
    EE64Gua_Sui     = (EE8Xiang_Ze<<3)+EE8Xiang_Lei,

    //坎宫——————————————————————————————————————————————————
    EE64Gua_Kan     = (EE8Xiang_Shui<<3)+EE8Xiang_Shui,
    
    EE64Gua_Jie     = (EE8Xiang_Shui<<3)+EE8Xiang_Ze,
    EE64Gua_Zhun     = (EE8Xiang_Shui<<3)+EE8Xiang_Lei,
    EE64Gua_JiJi    = (EE8Xiang_Shui<<3)+EE8Xiang_Huo,
    EE64Gua_Ge      = (EE8Xiang_Ze<<3)+EE8Xiang_Huo,
    EE64Gua_Feng    = (EE8Xiang_Lei<<3)+EE8Xiang_Huo,
    
    EE64Gua_MingYi  = (EE8Xiang_Di<<3)+EE8Xiang_Huo,
    EE64Gua_Shi     = (EE8Xiang_Di<<3)+EE8Xiang_Shui,

    //艮宫——————————————————————————————————————————————————
    EE64Gua_Gen     = (EE8Xiang_Shan<<3)+EE8Xiang_Shan,
   
    EE64Gua_Bi4      = (EE8Xiang_Shan<<3)+EE8Xiang_Huo,
    EE64Gua_DaXu    = (EE8Xiang_Shan<<3)+EE8Xiang_Tian,
    EE64Gua_Sun     = (EE8Xiang_Shan<<3)+EE8Xiang_Ze,
    EE64Gua_Kui     = (EE8Xiang_Huo<<3)+EE8Xiang_Ze,
    EE64Gua_LvZ      = (EE8Xiang_Tian<<3)+EE8Xiang_Ze,
    
    EE64Gua_ZhongFu = (EE8Xiang_Feng<<3)+EE8Xiang_Ze,
    EE64Gua_Jian    = (EE8Xiang_Feng<<3)+EE8Xiang_Shan,

    //坤宫——————————————————————————————————————————————————
    EE64Gua_Kun         = (EE8Xiang_Di<<3)+EE8Xiang_Di,
    
    EE64Gua_Fu          = (EE8Xiang_Di<<3)+EE8Xiang_Lei,
    EE64Gua_Lin         = (EE8Xiang_Di<<3)+EE8Xiang_Ze,
    EE64Gua_Tai         = (EE8Xiang_Di<<3)+EE8Xiang_Tian,
    EE64Gua_DaZhuang    = (EE8Xiang_Lei<<3)+EE8Xiang_Tian,
    EE64Gua_Guai        = (EE8Xiang_Ze<<3)+EE8Xiang_Tian,
    
    EE64Gua_Xu          = (EE8Xiang_Shui<<3)+EE8Xiang_Tian,
    EE64Gua_Bi3          = (EE8Xiang_Shui<<3)+EE8Xiang_Di,

    //巽宫——————————————————————————————————————————————————
    EE64Gua_Xun         = (EE8Xiang_Feng<<3)+EE8Xiang_Feng,
    
    EE64Gua_XiaoXu      = (EE8Xiang_Feng<<3)+EE8Xiang_Tian,
    EE64Gua_JiaRen     = (EE8Xiang_Feng<<3)+EE8Xiang_Huo,
    EE64Gua_Yi4     = (EE8Xiang_Feng<<3)+EE8Xiang_Lei,
    EE64Gua_WuWang     = (EE8Xiang_Tian<<3)+EE8Xiang_Lei,
    EE64Gua_ShiHe     = (EE8Xiang_Huo<<3)+EE8Xiang_Lei,
    
    EE64Gua_Yi2     = (EE8Xiang_Shan<<3)+EE8Xiang_Lei,
    EE64Gua_Gu     = (EE8Xiang_Shan<<3)+EE8Xiang_Feng,
    
    //离宫——————————————————————————————————————————————————
    EE64Gua_Li     = (EE8Xiang_Huo<<3)+EE8Xiang_Huo,
    
    EE64Gua_LvL     = (EE8Xiang_Huo<<3)+EE8Xiang_Shan,
    EE64Gua_Ding     = (EE8Xiang_Huo<<3)+EE8Xiang_Feng,
    EE64Gua_WeiJi     = (EE8Xiang_Huo<<3)+EE8Xiang_Shui,
    EE64Gua_Meng     = (EE8Xiang_Shan<<3)+EE8Xiang_Shui,
    EE64Gua_Huan     = (EE8Xiang_Feng<<3)+EE8Xiang_Shui,
    
    EE64Gua_Song     = (EE8Xiang_Tian<<3)+EE8Xiang_Shui,
    EE64Gua_TongRen     = (EE8Xiang_Tian<<3)+EE8Xiang_Huo,
    
    //兑宫——————————————————————————————————————————————————
    EE64Gua_Dui     = (EE8Xiang_Ze<<3)+EE8Xiang_Ze,
    
    EE64Gua_Kun4     = (EE8Xiang_Ze<<3)+EE8Xiang_Shui,
    EE64Gua_Cui     = (EE8Xiang_Ze<<3)+EE8Xiang_Di,
    EE64Gua_Xian     = (EE8Xiang_Ze<<3)+EE8Xiang_Shan,
    EE64Gua_Jian3     = (EE8Xiang_Shui<<3)+EE8Xiang_Shan,
    EE64Gua_Qian1     = (EE8Xiang_Di<<3)+EE8Xiang_Shan,
    
    EE64Gua_XiaoGuo     = (EE8Xiang_Lei<<3)+EE8Xiang_Shan,
    EE64Gua_GuiMei     = (EE8Xiang_Lei<<3)+EE8Xiang_Ze,
}EE64GuaT;

@class EELunarDate;

/**
 天道，人伦，万物类象c
 */
@interface EE64Gua : NSObject

- (instancetype)initByOuter:(EE8GuaT)outer inner:(EE8GuaT)inner;
- (instancetype)initByType:(EE64GuaT)type;

@property(readonly)EE64GuaT type;

@property(readonly)EE8Gua *zhuGong;
@property(readonly)EE8Gong zhuGongT;

@property(readonly)EEJF8GuaBian jf8GuaBian;

@property(readonly)EE8GuaExt *guaOuter;
@property(readonly)EE8GuaExt *guaInner;

@property(readonly)NSArray<EEYao*> *yao6;

@property(readonly)NSInteger shi;
@property(readonly)NSInteger ying;

@property(readonly)EEYao *fuShenYao;
@property(readonly)EEYao *yongShenYao;
@property(readonly)EEYao *jiShenYao;

//0~5
@property(nonatomic,assign)EE6Qin omenShen;

-(void)an6ShenFor:(EE10TianGan*)tianGan;
-(EE64Gua*)mutexGua;

#pragma mark -----------------------卦变--------------------------
//判断是不是变卦
@property(readonly)BOOL bian;
//某一位置的yao动 0~5
-(void)yaoDongBy:(int)yao;
//gua^dys
-(void)bianGuaByDys:(int)dys;
@property(readonly)EE64Gua *bianGua;
@property(readonly)NSArray *bianYaos;

@end


