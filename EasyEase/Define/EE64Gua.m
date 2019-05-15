//
//  EE64Gua.m
//  EasyEase
//
//  Created by lizhenghao on 2018/10/24.
//  Copyright © 2018 lizhenghao. All rights reserved.
//

#import "EE64Gua.h"
#import "EE10TianGan.h"

NSString *EE64GuaStr(EE64GuaT t)
{
    NSString *key = [NSString stringWithFormat:@"EE64Gua_%@",OutputBinaryStr(t,6)];
    return NSLocalizedString(key, nil);
}
NSString *EE8GongStr(EE8Gong g)
{
    NSString *key = [NSString stringWithFormat:@"EE8Gong_%@",OutputBinaryStr(g,3)];
    return NSLocalizedString(key, nil);
}
NSString *EEJF16GuaBianStr(EEJF16GuaBian b)
{
    NSString *key = [NSString stringWithFormat:@"EEJF16GuaBian_%d",b];
    return NSLocalizedString(key, nil);
}
NSString *EEJF8GuaBianStr(EEJF8GuaBian b)
{
    NSString *key = [NSString stringWithFormat:@"EEJF16GuaBian_%d",b];
    return NSLocalizedString(key, nil);
}

@implementation EE64Gua

static NSDictionary *allGs = nil;
+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        
        NSArray *gQian = @[@(EE64Gua_Qian),@(EE64Gua_Gou),@(EE64Gua_Dun),@(EE64Gua_Pi),@(EE64Gua_Guan),@(EE64Gua_Bo),@(EE64Gua_Jin),@(EE64Gua_DaYou)];
        [dic setObject:gQian forKey:@(EE8Gong_Qian)];
        NSArray *gZhen = @[@(EE64Gua_Zhen),@(EE64Gua_Yu),@(EE64Gua_Jie3),@(EE64Gua_Heng),@(EE64Gua_Sheng),@(EE64Gua_Jing),@(EE64Gua_DaGuo),@(EE64Gua_Sui)];
        [dic setObject:gZhen forKey:@(EE8Gong_Zhen)];
        NSArray *gKan = @[@(EE64Gua_Kan),@(EE64Gua_Jie),@(EE64Gua_Zhun),@(EE64Gua_JiJi),@(EE64Gua_Ge),@(EE64Gua_Feng),@(EE64Gua_MingYi),@(EE64Gua_Shi)];
        [dic setObject:gKan forKey:@(EE8Gong_Kan)];
        NSArray *gGen = @[@(EE64Gua_Gen),@(EE64Gua_Bi4),@(EE64Gua_DaXu),@(EE64Gua_Sun),@(EE64Gua_Kui),@(EE64Gua_LvZ),@(EE64Gua_ZhongFu),@(EE64Gua_Jian)];
        [dic setObject:gGen forKey:@(EE8Gong_Gen)];
        NSArray *gKun = @[@(EE64Gua_Kun),@(EE64Gua_Fu),@(EE64Gua_Lin),@(EE64Gua_Tai),@(EE64Gua_DaZhuang),@(EE64Gua_Guai),@(EE64Gua_Xu),@(EE64Gua_Bi3)];
        [dic setObject:gKun forKey:@(EE8Gong_Kun)];
        NSArray *gXun = @[@(EE64Gua_Xun),@(EE64Gua_XiaoXu),@(EE64Gua_JiaRen),@(EE64Gua_Yi4),@(EE64Gua_WuWang),@(EE64Gua_ShiHe),@(EE64Gua_Yi2),@(EE64Gua_Gu)];
        [dic setObject:gXun forKey:@(EE8Gong_Xun)];
        NSArray *gLi = @[@(EE64Gua_Li),@(EE64Gua_LvL),@(EE64Gua_Ding),@(EE64Gua_WeiJi),@(EE64Gua_Meng),@(EE64Gua_Huan),@(EE64Gua_Song),@(EE64Gua_TongRen)];
        [dic setObject:gLi forKey:@(EE8Gong_Li)];
        NSArray *gDui = @[@(EE64Gua_Dui),@(EE64Gua_Kun4),@(EE64Gua_Cui),@(EE64Gua_Xian),@(EE64Gua_Jian3),@(EE64Gua_Qian1),@(EE64Gua_XiaoGuo),@(EE64Gua_GuiMei)];
        [dic setObject:gDui forKey:@(EE8Gong_Dui)];
        
        allGs = [NSDictionary dictionaryWithDictionary:dic];
    });
}

-(NSString *)description
{
    NSString *sp = DESC_SP;
    NSMutableString *desc = [NSMutableString string];
    if (_bian) {
        [desc appendFormat:@"%@",sp];
        [desc appendString:@"| 变卦 "];
    }else{
        [desc appendFormat:@"\n%@",sp];
    }
    
    [desc appendFormat:@"| %@ ",EE8GongStr(_zhuGongT)];
    if (!_bian) {
        [desc appendFormat:@"| %@ ",EEJF8GuaBianStr(_jf8GuaBian)];
    }
    [desc appendString:@"| \n"];
    [desc appendFormat:@"| 上%@ & 下%@ | %@%@•%@ |\n",_guaOuter.tianGan10,_guaInner.tianGan10,EE8XiangStr(_guaOuter.xiang),EE8XiangStr(_guaInner.xiang),EE64GuaStr(_type)];
    [desc appendString:sp];
    [desc appendFormat:@"%@\n",self.guaOuter];
    [desc appendString:DESC_MD];
    [desc appendFormat:@"%@\n",self.guaInner];
    
    if (_bianGua) {
        [desc appendString:_bianGua.description];
    }else{
        [desc appendString:sp];
    }

    return desc;
}

- (instancetype)initByType:(EE64GuaT)type
{
    self = [super init];
    if (self) {
        _type = type;
        EE8GuaT innerT = type & 0b000111;
        EE8GuaT outerT = (type & 0b111000) >> 3;
        [self installWithInnerT:innerT outerT:outerT];
    }
    return self;
}

- (instancetype)initByOuter:(EE8GuaT)outer inner:(EE8GuaT)inner 
{
    self = [super init];
    if (self) {
        _type = (outer<<3) + inner;
        [self installWithInnerT:inner outerT:outer];
    }
    return self;
}

-(void)installWithInnerT:(EE8GuaT)innerT outerT:(EE8GuaT)outerT
{
    _guaInner = [[EE8GuaExt alloc]initByType:innerT pos:EE8GuaPos_Inner];
    _guaOuter = [[EE8GuaExt alloc]initByType:outerT pos:EE8GuaPos_Outer];
    
    [self dingShiYing];
    if (!_bian) {
        [self dingZhuGong];
    }
    [self anLiuQin];
}

-(void)an6ShenFor:(EE10TianGan*)tianGan
{
    EE6Shen s6 = tianGan.shen6;
    _guaInner.yDi.shen6 = s6;
    _guaInner.yRen.shen6 = CircleCalc(s6, 6, 1);
    _guaInner.yTian.shen6 = CircleCalc(s6, 6, 2);
    
    _guaOuter.yDi.shen6 = CircleCalc(s6, 6, 3);
    _guaOuter.yRen.shen6 = CircleCalc(s6, 6, 4);
    _guaOuter.yTian.shen6 = CircleCalc(s6, 6, 5);
}

-(void)dingZhuGong
{
    __block EE8Gong gong = 0;
    __block EEJF8GuaBian bian = 0;
    [allGs enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSArray *obj, BOOL * _Nonnull stop) {
        for (int i = 0; i<obj.count; i++) {
            NSNumber *val = obj[i];
            if (val.integerValue == self.type) {
                gong = key.intValue;
                if (i == 7){
                    bian = EEJF8GuaBian_7_GuiHun;
                }else{
                    bian = i;
                }
                *stop = YES;
                break;
            }
        }
    }];
    _jf8GuaBian = bian;
    _zhuGongT = gong;
    _zhuGong = [[EE8Gua alloc]initByType:(EE8GuaT)gong];
}

-(void)dingShiYing
{
    //        定世应
    //       天人初天二，错卦天地三，地同人同四，地人都同五。
    NSInteger shi = 0;
    BOOL tTian = _guaInner.ytTian == _guaOuter.ytTian;
    BOOL tRen = _guaOuter.ytRen == _guaInner.ytRen;
    BOOL tDi = _guaOuter.ytDi == _guaInner.ytDi;
    
    if (tTian && tRen && !tDi) {
        shi = 1;
        _guaInner.yDi.shiying = EESY_Shi;
        _guaOuter.yDi.shiying = EESY_Ying;
    }else if (tTian && !tRen && !tDi){
        shi = 2;
        _guaInner.yRen.shiying = EESY_Shi;
        _guaOuter.yRen.shiying = EESY_Ying;
    }else if ((!tTian && !tRen && !tDi) || (tTian && !tRen & tDi)){
        shi = 3;
        _guaInner.yTian.shiying = EESY_Shi;
        _guaOuter.yTian.shiying = EESY_Ying;
    }else if ((!tTian && tRen && !tDi) || (!tTian && !tRen && tDi)){
        shi = 4;
        _guaInner.yDi.shiying = EESY_Ying;
        _guaOuter.yDi.shiying = EESY_Shi;
    }else if (!tTian && tRen && tDi){
        shi = 5;
        _guaInner.yRen.shiying = EESY_Ying;
        _guaOuter.yRen.shiying = EESY_Shi;
    }else {
        _guaInner.yTian.shiying = EESY_Ying;
        _guaOuter.yTian.shiying = EESY_Shi;
        shi = 6;
    }
    _ying = (shi+3)%6;
    _shi = shi;
}

-(EE64Gua*)mutexGua
{
    EE8GuaT ot = (_guaOuter.ytRen<<2) + (_guaOuter.ytDi<<1) + _guaInner.ytTian;
    EE8GuaT it = (_guaOuter.ytDi<<2) + (_guaInner.ytTian<<1) + _guaInner.ytRen;
    
    return [[EE64Gua alloc]initByOuter:ot inner:it];
}

-(void)setOmenShen:(EE6Qin)omenShen
{
    if (_omenShen != omenShen) {
        _omenShen = omenShen;
        NSArray<EEYao*> *yao6 = [self yao6];
        _yongShenYao = nil;
        for (EEYao *yao in yao6) {
            EEOmenShen os = CircleCalc(EEOmen_YongShen, 5, yao.qin - omenShen);
            yao.oShen = os;
            if (os == EEOmen_YongShen) {
                _yongShenYao = yao;
            }
            if (os == EEOmen_JiShen) {
                _jiShenYao = yao;
            }
        }
        if (!_yongShenYao) {
            NSArray<EEYao*> *yao6 = [[[EE64Gua alloc]initByOuter:_zhuGong.type inner:_zhuGong.type]yao6];
            for (EEYao *yao in yao6) {
                EEOmenShen os = CircleCalc(EEOmen_YongShen, 5, yao.qin - omenShen);
                if (os == EEOmen_YongShen) {
                    _fuShenYao = yao;
                    _yongShenYao = yao;
                }
            }
        }
    }

}

-(NSArray<EEYao *> *)yao6
{
    return @[_guaInner.yDi,_guaInner.yRen,_guaInner.yTian,_guaOuter.yDi,_guaOuter.yRen,_guaOuter.yTian];
}

-(void)anLiuQin
{
    EE5Xing *x5 = self.zhuGong.xing5;
    NSArray<EEYao*> *yao6 = [self yao6];
//    生我者为父母
//    克我者为官鬼
//    我生者为子孙
//    我克者为妻财
//    同我者为兄弟
    for (EEYao *yao in yao6) {
        if (yao.xing5 == x5) {
            yao.qin = EE6Qin_XiongDi;
        }else if ([x5 shWo] == yao.xing5.type){
            yao.qin = EE6Qin_FuMu;
        }else if ([x5 keWo] == yao.xing5.type){
            yao.qin = EE6Qin_GuanGui;
        }else if ([x5 woSh] == yao.xing5.type){
            yao.qin = EE6Qin_ZiSun;
        }else if ([x5 woKe] == yao.xing5.type){
            yao.qin = EE6Qin_QiCai;
        }
    }
}

#pragma mark -----------------变卦---------------------

-(void)yaoDongBy:(int)yao
{
    if (yao >= 0 && yao < 6) {
        [self bianGuaByDys:(1<<yao)];
    }
}

-(void)bianGuaByDys:(int)dys
{
    EE64GuaT bg = _type;
    for (int i = 0; i < 6; i ++) {
        BOOL dong = dys & (1 << i);
        if (dong) {
            EEYao *dy = [self.yao6 objectAtIndex:i];
            dy.state = EEYaoState_Dong;
            bg = bg^(1 << i);
        }
    }
    _bianGua = [[EE64Gua alloc]initBianGuaByType:bg zhuGong:_zhuGong bianYaoIdx:dys];
}

@synthesize bianYaos = _bianYaos;

-(NSArray *)bianYaos
{
    if (self.bian) {
        return _bianYaos;
    }else if (self.bianGua){
        return _bianGua.bianYaos;
    }else{
        return nil;
    }
}

- (instancetype)initBianGuaByType:(EE64GuaT)type zhuGong:(EE8Gua*)zhuGong bianYaoIdx:(int)dys
{
    self = [super init];
    if (self) {
        _type = type;
        _bian = YES;
        _zhuGong = zhuGong;
        _zhuGongT = (EE8Gong)zhuGong.type;
        EE8GuaT innerT = type & 0b000111;
        EE8GuaT outerT = (type & 0b111000) >> 3;
        [self installWithInnerT:innerT outerT:outerT];
        
        NSMutableArray *ary = [NSMutableArray array];
        for (int i = 0; i < 6; i ++) {
            BOOL dong = dys & (1 << i);
            if (dong) {
                EEYao *dy = [self.yao6 objectAtIndex:i];
                dy.state = EEYaoState_Bian;
                [ary addObject:dy];
            }
        }
        _bianYaos = [NSArray arrayWithArray:ary];
    }
    return self;
}


@end
