//
//  EEOmenSign.m
//  EasyEase
//
//  Created by lizhenghao on 2018/10/30.
//  Copyright © 2018 lizhenghao. All rights reserved.
//

#import "EEOmenSign.h"
#import "EECalendar.h"
#import "EE64Gua.h"

#import "EEDzJuSign.h"
#import "EE5XingSign.h"
#import "EESignPos.h"
#import "EEShenSha.h"

@interface EEOmenSign ()

@property(nonatomic,strong)EEPosSet *posSet;
@property(nonatomic,strong)NSArray *dz2HeJuAry;
@property(nonatomic,strong)NSArray *dz2ChongJuAry;
@property(nonatomic,strong)NSArray *dz2HaiJuAry;
@property(nonatomic,strong)NSArray *dz3HeJuAry;
@property(nonatomic,strong)NSArray *dz3XingJuAry;

@property(nonatomic,strong)EE5XingSignSet *xing5SignSet;

@property(nonatomic,strong)NSArray *jinTuiShenAry;

@property(nonatomic,readonly)EEShenSha *shenSha;
@end

@implementation EEOmenSign

- (instancetype)initByLunarDate:(EELunarDate*)date gua64:(EE64Gua*)gua
{
    self = [super init];
    if (self) {
        _date = date;
        _gua = gua;
        [self sign];
    }
    return self;
}

-(void)sign
{
//    Set Yong Shen
    [self ySjSyScS];
//    Omen Sign 解卦
    self.posSet = [[EEPosSet alloc]initByLunarDate:_date gua64:_gua];
    
    [self dzHeChongHai];
}

-(void)dzHeChongHai
{
    self.xing5SignSet = [[EE5XingSignSet alloc]initByPosSet:_posSet];
    
    NSMutableSet *dzPool = [NSMutableSet set];
    __block NSMutableArray *hj2Ary = [NSMutableArray array];
    __block NSMutableArray *chong2Ary = [NSMutableArray array];
    __block NSMutableArray *hai2Ary = [NSMutableArray array];

    __block NSMutableArray *jinTuiAry = [NSMutableArray array];
    [_posSet.AllPos enumerateObjectsUsingBlock:^(EESignPos*  _Nonnull obj1, BOOL * _Nonnull stop) {
        [dzPool enumerateObjectsUsingBlock:^(EESignPos* _Nonnull obj2, BOOL * _Nonnull stop) {
            EEDzJuSign *js = [EEDzJuSign tryJuSignP1:obj1 p2:obj2];
            if (js) {
                switch (js.type) {
                    case EEJuSignT_2HeJu:{
                        [hj2Ary addObject:js];
                        break;
                    }
                    case EEJuSignT_2Hai:{
                        [hai2Ary addObject:js];
                        break;
                    }
                    case EEJuSignT_2Chong:{
                        [chong2Ary addObject:js];
                        break;
                    }
                    default:{
                        break;
                    }
                }
            }
            js = [EEDzJuSign tryJinTuiShenP1:obj1 p2:obj2];
            if (js) {
                [jinTuiAry addObject:js];
            }
        }];
        [dzPool addObject:obj1];
    }];
    _dz2HeJuAry = [NSArray arrayWithArray:hj2Ary];
    _dz2ChongJuAry = [NSArray arrayWithArray:chong2Ary];
    _dz2HaiJuAry = [NSArray arrayWithArray:hai2Ary];
    _jinTuiShenAry = [NSArray arrayWithArray:jinTuiAry];

//    3合,3刑
    _dz3HeJuAry = [NSArray arrayWithArray:[EEDzJuSign try3HeJuAryByPosSet:_posSet]];
    _dz3XingJuAry = [NSArray arrayWithArray:[EEDzJuSign try3XingJuByPosSet:_posSet]];
    
    _shenSha = [EEShenSha new];
    [_shenSha tryTaoHuaYunByDayDz:_date.dayDiZhi.type yongShenDz:_gua.yongShenYao.dizhi12.type];
    [_shenSha tryTianYiGuiRenByDayTg:_date.dayTianGan.type yongShenDz:_gua.yongShenYao.dizhi12 jsDz:_gua.jiShenYao.dizhi12];
}

//元神，忌神，用神，仇神
-(void)ySjSyScS
{
    [_gua an6ShenFor:_date.dayTianGan];
    _gua.omenShen = EE6Qin_QiCai;
}

-(NSString *)description
{
    NSString *sp = DESC_SP;
    NSMutableString *desc = [NSMutableString stringWithFormat:@"\n%@",sp];
    
    if (_shenSha.type & EEShenSha_TaoHua) {
        [desc appendString:@"|*****命中桃花*****\n"];
        [desc appendString:sp];
    }
    if (_shenSha.type & EEShenSha_TYGR_GuiRen) {
        [desc appendString:@"|*****天乙贵人*****\n"];
        [desc appendString:sp];
    }
    if (_shenSha.type & EEShenSha_TYGR_JiGuiRen) {
        [desc appendString:@"|*****犯忌贵人*****\n"];
        [desc appendString:sp];
    }
    [desc appendString:_date.description];
//    [desc appendFormat:@"\n>> 年%@ 月%@ 日%@ 时%@ <<",EEWJSStr(_yearWQS),EEWJSStr(_monthWQS),EEWJSStr(_dayWQS),EEWJSStr(_hourWQS)];
    [desc appendString:_gua.description];

    if (_gua.fuShenYao) {
        EESignPos *pos = [[EESignPos alloc]initYaoPosByYao:_gua.fuShenYao];
        [desc appendFormat:@"|飞伏神| %@ %@\n",pos,_gua.fuShenYao];
    }
    [desc appendString:_xing5SignSet.description];
    [desc appendString:@"|进退神"];
    if (_jinTuiShenAry.count) {
        for (EEDzJuSign *js in _jinTuiShenAry) {
            [desc appendString:js.description];
        }
    }
    [desc appendString:@"\n"];    
    [desc appendString:@"|二合局"];
    for (EEDzJuSign *js in _dz2HeJuAry) {
        [desc appendString:js.description];
    }
    [desc appendString:@"\n|二冲局"];
    for (EEDzJuSign *js in _dz2ChongJuAry) {
        [desc appendString:js.description];
    }
    [desc appendString:@"\n|二害局"];
    for (EEDzJuSign *js in _dz2HaiJuAry) {
        [desc appendString:js.description];
    }
    [desc appendString:@"\n|三合局"];
    for (EEDzJuSign *js in _dz3HeJuAry) {
        [desc appendString:js.description];
    }
    [desc appendString:@"\n|三刑局"];
    for (EEDzJuSign *js in _dz3XingJuAry) {
        [desc appendString:js.description];
    }
    [desc appendString:@"\n"];
    [desc appendString:DESC_SP];
    
    return desc;
}



@end
