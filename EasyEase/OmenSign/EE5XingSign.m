//
//  EE5XingSign.m
//  EasyEase
//
//  Created by lizhenghao on 2018/11/5.
//  Copyright © 2018 lizhenghao. All rights reserved.
//

#import "EE5XingSign.h"

#import "EESignPos.h"

@implementation EE5XingSign

- (instancetype)initByGong:(EESignPos *)gong shou:(EESignPos*)shou
{
    self = [super init];
    if (self) {
        _gong = gong;
        _shou = shou;
    }
    return self;
}

-(NSString *)description
{
    EEWQS wqs = [_shou.xing wqsBy:_gong.xing];
    if (_gong.isTimePos) {
        return [NSString stringWithFormat:@" %@ %@ |",_shou,EEWQSStr(wqs)];
    }else{
        if (_gong.isBianPos) {
            if (wqs == EEWQS_Xiang) {
                return [NSString stringWithFormat:@" %@ 回头生 %@ |",_shou,_gong];
            }else if (wqs == EEWQS_Si) {
                return [NSString stringWithFormat:@" %@ 回头克 %@ |",_shou,_gong];
            }
        }
        if (_gong.yao.state == EEYaoState_Dong) {
            return [NSString stringWithFormat:@" %@ %@ %@ |",_gong,EEWQSStr(wqs),_shou];
        }
        return [NSString stringWithFormat:@" %@ %@ %@ |",_shou,EEWQSStr(wqs),_gong];
    }
}

@end

@interface EE5XingSignSet ()

@property(nonatomic,strong)EEPosSet *posSet;
@property(nonatomic,strong)NSMutableArray *x5wxMonth;
@property(nonatomic,strong)NSMutableArray *x5wxDay;
@property(nonatomic,strong)NSMutableArray *x5wxChange;

@property(nonatomic,strong)NSMutableArray *x5wxKeJing;

@property(nonatomic,strong)NSMutableArray *swmjMonth;
@property(nonatomic,strong)NSMutableArray *swmjDay;

@end

@implementation EE5XingSignSet

- (instancetype)initByPosSet:(EEPosSet*)posSet
{
    self = [super init];
    if (self) {
        _posSet = posSet;
        _x5wxMonth = [NSMutableArray array];
        _x5wxDay = [NSMutableArray array];
        _x5wxChange = [NSMutableArray array];
        _x5wxKeJing = [NSMutableArray array];
        _swmjMonth = [NSMutableArray array];
        _swmjDay = [NSMutableArray array];
        
        EESignPos *dayPos = _posSet.dayPos, *monthPos = _posSet.monthPos;
        [_posSet.yaoPos enumerateObjectsUsingBlock:^(EESignPos*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            EE5XingSign *daySg = [[EE5XingSign alloc]initByGong:dayPos shou:obj];
            EE5XingSign *monthSg = [[EE5XingSign alloc]initByGong:monthPos shou:obj];
            [self->_x5wxDay addObject:daySg];
            [self->_x5wxMonth addObject:monthSg];
            
            EE5X_SWMJSign *daySwmj = [[EE5X_SWMJSign alloc]initBytimePos:dayPos yaoPos:obj];
            EE5X_SWMJSign *monthSwmj = [[EE5X_SWMJSign alloc]initBytimePos:monthPos yaoPos:obj];
            [self->_swmjMonth addObject:monthSwmj];
            [self->_swmjDay addObject:daySwmj];
        }];
        [_posSet.yaoDongPos enumerateObjectsUsingBlock:^(EESignPos*  _Nonnull obj, BOOL * _Nonnull stop) {
            [self->_posSet.yao6Pos enumerateObjectsUsingBlock:^(EESignPos*  _Nonnull obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
                if (obj != obj1) {
                    EE5XingSign *changeSg = [[EE5XingSign alloc]initByGong:obj shou:obj1];
                    [self->_x5wxKeJing addObject:changeSg];
                }
            }];
        }];
        [_posSet.yaoBianPos enumerateObjectsUsingBlock:^(EESignPos*  _Nonnull obj, BOOL * _Nonnull stop) {
            [self->_posSet.yao6Pos enumerateObjectsUsingBlock:^(EESignPos*  _Nonnull obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
                if (obj.type == obj1.type) {
                    EE5XingSign *changeSg = [[EE5XingSign alloc]initByGong:obj shou:obj1];
                    [self->_x5wxChange addObject:changeSg];
                }
            }];
        }];
    }
    return self;
}

-(NSString *)description
{
    NSMutableString *desc = [NSMutableString string];
    
    if (_x5wxMonth.count > 0) {
        [desc appendString:@"|五行旺相•月|"];
        for (EE5XingSign *sign in _x5wxMonth) {
            [desc appendString:sign.description];
        }
        [desc appendString:@"\n"];
    }
    if (_x5wxDay.count > 0){
        [desc appendString:@"|五行旺相•日|"];
        for (EE5XingSign *sign in _x5wxDay) {
            [desc appendString:sign.description];
        }
        [desc appendString:@"\n"];
    }
    if (_x5wxChange.count > 0) {
        [desc appendString:@"|五行旺相•动变|"];
        for (EE5XingSign *sign in _x5wxChange) {
            [desc appendString:sign.description];
        }
        [desc appendString:@"\n"];
    }
    if (_x5wxKeJing.count > 0) {
        [desc appendString:@"|五行旺相•克静|"];
        for (EE5XingSign *sign in _x5wxKeJing) {
            [desc appendString:sign.description];
        }
        [desc appendString:@"\n"];
    }
    [desc appendString:DESC_SP];
    if (_swmjMonth.count > 0) {
        [desc appendString:@"|生旺墓绝•月|"];
        for (EE5X_SWMJSign *sign in _swmjMonth) {
            [desc appendString:sign.description];
        }
        [desc appendString:@"\n"];
    }
    if (_swmjDay.count > 0) {
        [desc appendString:@"|生旺墓绝•日|"];
        for (EE5X_SWMJSign *sign in _swmjDay) {
            [desc appendString:sign.description];
        }
        [desc appendString:@"\n"];
    }
    [desc appendString:DESC_SP];
    
    return desc;
}


@end

@implementation EE5X_SWMJSign

- (instancetype)initBytimePos:(EESignPos*)tp yaoPos:(EESignPos*)yp
{
    self = [super init];
    if (self) {
        EE5XingT xt = tp.xing.type;
        NSArray *dzary = @[[EE12DiZhi byType:EE12DiZhi_Si],[EE12DiZhi byType:EE12DiZhi_Shen],[EE12DiZhi byType:EE12DiZhi_Hai],[EE12DiZhi byType:EE12DiZhi_Yin],[EE12DiZhi byType:EE12DiZhi_Yin]];
        EE12DiZhi *dz = [dzary objectAtIndex:xt];
        int ofs = yp.dizhi.type - dz.type;
        _type = CircleCalc(EE5X_SWMJ_ChangSheng, 12, ofs);
        
        _timePos = tp;
        _yaoPos = yp;
    }
    return self;
}

-(NSString *)description
{
    NSString *swmj = [NSString stringWithFormat:@"EE5X_SWMJ_%d",_type];
    swmj = NSLocalizedString(swmj, nil);
    NSString *str = [NSString stringWithFormat:@" %@ %@ |",_yaoPos,swmj];
    return str;
}

@end
