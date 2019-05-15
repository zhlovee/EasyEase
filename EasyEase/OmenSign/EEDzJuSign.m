//
//  EEDzJuSign.m
//  EasyEase
//
//  Created by lizhenghao on 2018/11/4.
//  Copyright © 2018 lizhenghao. All rights reserved.
//

#import "EEDzJuSign.h"
#import "EESignPos.h"

@implementation EEDzJuSign

+(NSArray *)try3XingJuByPosSet:(EEPosSet *)set
{
    //    3刑
    NSMutableArray *xing3Ary = [NSMutableArray array];
    
    NSMutableArray *wl_ary = [NSMutableArray array];
    __block int f_wl = 0b00;
    NSMutableArray *we_ary = [NSMutableArray array];
    __block int f_we = 0b000;
    NSMutableArray *ss_ary = [NSMutableArray array];
    __block int f_ss = 0b000;
    NSMutableDictionary *dx_map = [NSMutableDictionary dictionary];
    [set.AllPos enumerateObjectsUsingBlock:^(EESignPos * obj, BOOL * _Nonnull stop) {
        switch (obj.dizhi.type) {
//                wu li zhi xing
            case EE12DiZhi_Zi :{
                f_wl |= 0b01;
                [wl_ary addObject:obj];
                break;
            }
            case EE12DiZhi_Mao :{
                f_wl |= 0b10;
                [wl_ary addObject:obj];
                break;
            }
//                wu en zhi xing
            case EE12DiZhi_Yin :{
                f_we |= 0b001;
                [we_ary addObject:obj];
                break;
            }
            case EE12DiZhi_Si :{
                f_we |= 0b010;
                [we_ary addObject:obj];
                break;
            }
            case EE12DiZhi_Shen :{
                f_we |= 0b100;
                [we_ary addObject:obj];
                break;
            }
//                si si zhixing
            case EE12DiZhi_Chou :{
                f_ss |= 0b001;
                [ss_ary addObject:obj];
                break;
            }
            case EE12DiZhi_Wei :{
                f_ss |= 0b010;
                [ss_ary addObject:obj];
                break;
            }
            case EE12DiZhi_Xu :{
                f_ss |= 0b100;
                [ss_ary addObject:obj];
                break;
            }
            default:{
//               zixing
                NSMutableArray *ary = [dx_map objectForKey:@(obj.dizhi.type)];
                if (!ary) {
                    ary = [NSMutableArray array];
                    [dx_map setObject:ary forKey:@(obj.dizhi.type)];
                }
                [ary addObject:obj];
            }
        }
    }];
    if (f_wl == 0b11) {
        EEDzJuSign *js = [[EEDzJuSign alloc]init3XingJuAry:wl_ary typeStr:@"无礼之刑"];
        [xing3Ary addObject:js];
    }
    if (f_we == 0b111){
        EEDzJuSign *js = [[EEDzJuSign alloc]init3XingJuAry:we_ary typeStr:@"无恩之刑"];
        [xing3Ary addObject:js];
    }
    if (f_ss == 0b111) {
        EEDzJuSign *js = [[EEDzJuSign alloc]init3XingJuAry:ss_ary typeStr:@"恃世之刑"];
        [xing3Ary addObject:js];
    }
    [dx_map enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, NSArray *ary, BOOL * _Nonnull stop) {
        if (ary.count > 1) {
            EEDzJuSign *js = [[EEDzJuSign alloc]init3XingJuAry:ary typeStr:@"自刑"];
            [xing3Ary addObject:js];
        }
    }];

    return xing3Ary;
}

- (instancetype)init3XingJuAry:(NSArray<EESignPos*> *)ary typeStr:(NSString*)typeStr
{
    self = [super init];
    if (self) {
        _xingju3Ary = [NSArray arrayWithArray:ary];
        _type = EEJuSignT_3Xing;
        _xing3Str = typeStr;
    }
    return self;
}

+(NSArray *)try3HeJuAryByPosSet:(EEPosSet*)set
{
    NSMutableArray *hj3Ary = [NSMutableArray array];
    for (int i = 0; i < 4; i++) {
        EE12DiZhiT dzt = EE12DiZhi_Zi;
        __block int flag = 0b000;
        NSMutableArray *pzary = [NSMutableArray array];
        [set.AllPos enumerateObjectsUsingBlock:^(EESignPos * obj, BOOL * _Nonnull stop) {
            if (obj.dizhi.type == dzt) {
                flag |= 0b001;
                [pzary addObject:obj];
            }
            else if (obj.dizhi.type == CircleCalc(dzt, 12, 4)){
                flag |= 0b010;
                [pzary addObject:obj];
            }
            else if (obj.dizhi.type == CircleCalc(dzt, 12, 8)){
                flag |= 0b100;
                [pzary addObject:obj];
            }
        }];
        if (flag == 0b111) {
            EEDzJuSign *js = [[EEDzJuSign alloc]init3HeJuAry:pzary];
            [hj3Ary addObject:js];
        }
    }
    return hj3Ary;
}

- (instancetype)init3HeJuAry:(NSArray<EESignPos*> *)ary
{
    self = [super init];
    if (self) {
        _heju3Ary = [NSArray arrayWithArray:ary];
        static NSArray *xing5h3;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            xing5h3 = @[@(EE5Xing_Shui),@(EE5Xing_Jin),@(EE5Xing_Huo),@(EE5Xing_Mu)];
        });
        _type = EEJuSignT_3HeJu;
        if (ary.count > 0) {
            EESignPos *ps = ary[0];
            EE5XingT xt = [[xing5h3 objectAtIndex:ps.dizhi.type%4]intValue];
            _xing5 = [EE5Xing byType:xt];
        }
    }
    return self;
}

+(instancetype)tryJinTuiShenP1:(EESignPos*)p1 p2:(EESignPos*)p2
{
    if ( p1.type == p2.type && p1.xing == p2.xing) {
        EEDzJuSign *js = [EEDzJuSign new];
        if (p1.isBianPos) {
            js->_p1 = p2;js->_p2 = p1;
        }else{
            js->_p1 = p1;js->_p2 = p2;
        }
        js->_type = EEJuSignT_JinTuiShen;
        
        return js;
    }
    return nil;
}

+(instancetype)tryJuSignP1:(EESignPos*)p1 p2:(EESignPos*)p2
{
    if (p1.isTimePos && p2.isTimePos) {
        return nil;
    }
    
    EE12DiZhiT dz1 = p1.dizhi.type, dz2 = p2.dizhi.type;
    
    EE5Xing *x5 = [EEDzJuSign try2HeJuDz1:dz1 dz2:dz2];
    if (x5) {
        EESignPos *timePos = p1.isTimePos ? p1 : (p2.isTimePos ? p2 : nil);
        EE2HeJuType heju2Type = EE2HeJuType_None;
        if (timePos) {
            EESignPos *otherPos = timePos == p1 ? p2 : p1;
            heju2Type = otherPos.isBianPos ? EE2HeJuType_HeZhu : EE2HeJuType_HeQi;
        }else {
            EESignPos *bianPos = p1.isBianPos ? p1 : (p2.isBianPos ? p2 : nil);
            if (bianPos) {
                EESignPos *other = bianPos == p1 ? p2 : p1;
                if (other.isBianPos) {
                    heju2Type = EE2HeJuType_HeHao;
                }else if (other.type == bianPos.type) {
                    heju2Type = EE2HeJuType_HuaFu;
                }
            }
        }
        if (heju2Type != EE2HeJuType_None) {
            EEDzJuSign *hj2 = [EEDzJuSign new];
            hj2->_p1 = p1;
            hj2->_p2 = p2;
            hj2->_xing5 = x5;
            hj2->_type = EEJuSignT_2HeJu;
            hj2->_heJu2Type = heju2Type;
            return hj2;
        }
    }
    else if (CircleCalc(dz1, 12, 6) == dz2) {
        EEDzJuSign *chong = [EEDzJuSign new];
        chong->_p1 = p1;
        chong->_p2 = p2;
        chong->_type = EEJuSignT_2Chong;
        return chong;
    }
    else if ([self try2HaiJuDz1:dz1 dz2:dz2]) {
        EEDzJuSign *js = [EEDzJuSign new];
        js->_p1 = p1;
        js->_p2 = p2;
        js->_type = EEJuSignT_2Hai;
        return js;
    }
    
    
    return nil;
}

-(NSString *)description
{
    NSString *str = @"";
    if (_type == EEJuSignT_2HeJu) {
        NSString *key = [NSString stringWithFormat:@"EE2HeJuType_%d",_heJu2Type];
        NSString *hejuTxt = NSLocalizedString(key, nil);
        str = [NSString stringWithFormat:@"| %@&%@ %@ %@ ",_p1,_p2,hejuTxt,_xing5];
    }
    else if (_type == EEJuSignT_2Chong) {
        str = [NSString stringWithFormat:@"| %@冲%@ ",_p1,_p2];
    }
    else if (_type == EEJuSignT_2Hai) {
        str = [NSString stringWithFormat:@"| %@害%@ ",_p1,_p2];
    }
    else if (_type == EEJuSignT_3HeJu) {
        NSMutableArray *sary = [NSMutableArray array];
        for (EESignPos *ps in _heju3Ary) {
            [sary addObject:ps.description];
        }
        str = [NSString stringWithFormat:@"| %@ 合%@ ",[sary componentsJoinedByString:@"&"],_xing5];
    }
    else if (_type == EEJuSignT_3Xing){
        NSMutableArray *sary = [NSMutableArray array];
        for (EESignPos *ps in _xingju3Ary) {
            [sary addObject:ps.description];
        }
        str = [NSString stringWithFormat:@"| %@ %@ ",[sary componentsJoinedByString:@"x"],_xing3Str];
    }else if (_type == EEJuSignT_JinTuiShen){
        str = [NSString stringWithFormat:@"| %@:%@%@ 化 %@%@", _p1,_p1.dizhi,_p1.xing,_p2.dizhi,_p2.xing];
    }
    
    return str;
}

+(EE5Xing*)try2HeJuDz1:(EE12DiZhiT)t1 dz2:(EE12DiZhiT)t2
{
    static NSSet *setTu1, *setTu2, *setMu, *setHuo, *setJin, *setShui;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        setTu1 = [NSSet setWithObjects:@(EE12DiZhi_Zi),@(EE12DiZhi_Chou),nil];
        setTu2 = [NSSet setWithObjects:@(EE12DiZhi_Wu),@(EE12DiZhi_Wei),nil];
        setMu = [NSSet setWithObjects:@(EE12DiZhi_Yin),@(EE12DiZhi_Hai),nil];
        setHuo = [NSSet setWithObjects:@(EE12DiZhi_Mao),@(EE12DiZhi_Xu),nil];
        setJin = [NSSet setWithObjects:@(EE12DiZhi_Chen),@(EE12DiZhi_You),nil];
        setShui = [NSSet setWithObjects:@(EE12DiZhi_Si),@(EE12DiZhi_Shen),nil];
    });
    if (t1 == t2) {
        return nil;
    }
    
    if (([setTu1 containsObject:@(t1)] && [setTu1 containsObject:@(t2)]) || ([setTu2 containsObject:@(t1)] && [setTu2 containsObject:@(t2)])) {
        return [EE5Xing byType:EE5Xing_Tu];
    }else if ([setMu containsObject:@(t1)] && [setMu containsObject:@(t2)]){
        return [EE5Xing byType:EE5Xing_Mu];
    }else if ([setHuo containsObject:@(t1)] && [setHuo containsObject:@(t2)]){
        return [EE5Xing byType:EE5Xing_Huo];
    }else if ([setJin containsObject:@(t1)] && [setJin containsObject:@(t2)]){
        return [EE5Xing byType:EE5Xing_Jin];
    }else if ([setShui containsObject:@(t1)] && [setShui containsObject:@(t2)]){
        return [EE5Xing byType:EE5Xing_Shui];
    }
    return nil;
}
+(BOOL)try2HaiJuDz1:(EE12DiZhiT)t1 dz2:(EE12DiZhiT)t2
{
    static NSArray *haiAry;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        haiAry = @[@(EE12DiZhi_Chen),@(EE12DiZhi_Si),@(EE12DiZhi_Wu),@(EE12DiZhi_Wei),@(EE12DiZhi_Shen),@(EE12DiZhi_You),@(EE12DiZhi_Xu),@(EE12DiZhi_Hai),@(EE12DiZhi_Zi),@(EE12DiZhi_Chou),@(EE12DiZhi_Yin),@(EE12DiZhi_Mao)];
    });
    NSInteger idx1 = [haiAry indexOfObject:@(t1)];
    NSInteger idx2 = [haiAry indexOfObject:@(t2)];
    return idx1 + idx2 == 11;
}

@end
