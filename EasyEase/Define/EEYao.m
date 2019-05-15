//
//  EEYao.m
//  EasyEase
//
//  Created by lizhenghao on 2018/10/26.
//  Copyright © 2018 lizhenghao. All rights reserved.
//

#import "EEYao.h"
#import "EE12DiZhi.h"

NSString *EE6QinStr(EE6Qin qin)
{
    NSString *key = [NSString stringWithFormat:@"EE6Qin_%d",qin];
    return NSLocalizedString(key, nil);
}
NSString *EE6ShenStr(EE6Shen shen)
{
    NSString *key = [NSString stringWithFormat:@"EE6Shen_%d",shen];
    return NSLocalizedString(key, nil);
}
NSString *EEOmenShenStr(EEOmenShen shen)
{
    NSString *key = [NSString stringWithFormat:@"EEOmen_%dShen",shen];
    return NSLocalizedString(key, nil);
}

EE6Qin EE6QinShWo(EE6Qin qin)
{
    return CircleCalc(qin, 5, -1);
}
EE6Qin EE6QinKeWo(EE6Qin qin)
{
    return CircleCalc(qin, 5, -2);
}
EE6Qin EE6QinWoSh(EE6Qin qin)
{
    return CircleCalc(qin, 5, +1);
}
EE6Qin EE6QinWoKe(EE6Qin qin)
{
    return CircleCalc(qin, 5, +2);
}

@implementation EEYao{
    BOOL _shen6An;
    BOOL _omenAn;
    BOOL _qinAn;
}

- (instancetype)initByType:(EEYY)type
{
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

- (BOOL)isEqual:(id)other
{
    if (other == self) {
        return YES;
    } else if (![other isKindOfClass:self.class]) {
        return NO;
    } else {
        EEYao *ot = (EEYao*)other;
        return self.type == ot.type;
    }
}

-(void)setOShen:(EEOmenShen)oShen
{
    _oShen = oShen;
    _omenAn = YES;
}

-(void)setQin:(EE6Qin)qin
{
    _qin = qin;
    _qinAn = YES;
}

-(void)setShen6:(EE6Shen)shen6
{
    _shen6 = shen6;
    _shen6An = YES;
}

-(void)setDz12:(EE12DiZhiT)dz12
{
    _dz12 = dz12;
    _xing5 = self.dizhi12.xing5;
}

-(EE12DiZhi *)dizhi12
{
    return [EE12DiZhi byType:_dz12];
}

-(NSString *)description
{
    NSMutableString *desc = [NSMutableString string];
    if (_omenAn) {
        [desc appendFormat:@"| %@ ",EEOmenShenStr(self.oShen)];
    }
    if (_qinAn) {
        [desc appendFormat:@"| %@",EE6QinStr(self.qin)];
    }
    if (_shen6An) {
        [desc appendFormat:@" | %@",EE6ShenStr(self.shen6)];
    }
    [desc appendFormat:@" | %@",_type ? @"–––":@"– –"];
    if (self.dizhi12) {
        [desc appendFormat:@" | %@",self.dizhi12];
    }
    if (self.xing5) {
        [desc appendFormat:@" | %@",self.xing5.description];
    }
    if (self.shiying != EESY_Null) {
        [desc appendFormat:@" | %@",_shiying == EESY_Shi ? @"世" : @"应"];
    }
    if (self.state == EEYaoState_Dong) {
        [desc appendString:@" | 动"];
    }
    
    return [NSString stringWithString:desc];
}

@end
