//
//  EESignPos.m
//  EasyEase
//
//  Created by lizhenghao on 2018/11/4.
//  Copyright © 2018 lizhenghao. All rights reserved.
//

#import "EESignPos.h"

typedef enum {
    EETimePos_Month = EESignPos_Month,
    EETimePos_Day   = EESignPos_Day,
    EETimePos_Year  = EESignPos_Year,
    EETimePos_Hour  = EESignPos_Hour,
}EETimePosT;

@implementation EESignPos

- (instancetype)initYaoPosByYao:(EEYao*)yao;
{
    self = [super init];
    if (self) {
        _type = (EESignPosT)yao.pos;
        _dizhi = yao.dizhi12;
        _xing = yao.xing5;
        _yao = yao;
    }
    return self;
}

- (instancetype)initTimePosByType:(EETimePosT)t dizhi:(EE12DiZhi*)dz
{
    self = [super init];
    if (self) {
        _type = (EESignPosT)t;
        _dizhi = dz;
        _xing = _dizhi.xing5;
    }
    return self;
}

-(BOOL)isTimePos;
{
    return _type == EESignPos_Year || _type == EESignPos_Month || _type == EESignPos_Day || _type == EESignPos_Hour;
//    return _type == EESignPos_Month || _type == EESignPos_Day;
}
-(BOOL)isBianPos
{
    return _yao && _yao.state == EEYaoState_Bian;
}

-(NSString *)description
{
    NSString *ss = [NSString stringWithFormat:@"EESignPos_%@",@(_type)];
    NSMutableString *str = [NSMutableString stringWithString:NSLocalizedString(ss, nil)];
    if (_yao) {
        switch (_yao.state) {
            case EEYaoState_Bian:{
                [str appendString:@"变"];
                break;
            }
            case EEYaoState_Dong:{
                [str appendString:@"动"];
                break;
            }
            default:{
            }
        }
    }
    
    return str;
}

@end

@interface EEPosSet ()

@property(nonatomic,strong)NSMutableSet *set;
@property(nonatomic,strong)EELunarDate *date;
@property(nonatomic,strong)EE64Gua *gua;

@end

@implementation EEPosSet

- (instancetype)initByLunarDate:(EELunarDate*)date gua64:(EE64Gua*)gua
{
    self = [super init];
    if (self) {
        _AllPos = [NSMutableSet set];
        _yao6Pos = [NSMutableArray array];
        _yaoPos = [NSMutableArray array];
        _yaoBianPos = [NSMutableSet set];
        _yaoDongPos = [NSMutableSet set];
        _date = date;
        _gua = gua;
        
        
        for (EEYao *yao in gua.yao6) {
            EESignPos *p = [[EESignPos alloc]initYaoPosByYao:yao];
            [_yao6Pos addObject:p];
            [_yaoPos addObject:p];
            [_AllPos addObject:p];
            if (yao.state == EEYaoState_Dong) {
                [_yaoDongPos addObject:p];
            }
        }
        for (EEYao *yao in gua.bianYaos) {
            EESignPos *p = [[EESignPos alloc]initYaoPosByYao:yao];
            [_yaoBianPos addObject:p];
            [_yaoPos addObject:p];
            [_AllPos addObject:p];
        }
        
        _dayPos = [[EESignPos alloc]initTimePosByType:EETimePos_Day dizhi:_date.dayDiZhi];
        _monthPos = [[EESignPos alloc]initTimePosByType:EETimePos_Month dizhi:_date.monthDiZhi];
        [_AllPos addObject:_dayPos];
        [_AllPos addObject:_monthPos];
//        [_AllPos addObject:[[EESignPos alloc]initTimePosByType:EETimePos_Year dizhi:_date.yearDiZhi]];
//        [_AllPos addObject:[[EESignPos alloc]initTimePosByType:EETimePos_Hour dizhi:_date.hourDiZhi]];
        
    }
    return self;
}

@end
