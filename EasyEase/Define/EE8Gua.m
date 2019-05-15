//
//  EE8Gua.m
//  EasyEase
//
//  Created by lizhenghao on 2018/10/24.
//  Copyright © 2018 lizhenghao. All rights reserved.
//

#import "EE8Gua.h"
#import "EE12DiZhi.h"
#import "EE10TianGan.h"

NSString *EE8GuaString(EE8GuaT gua)
{
    NSString *key = [NSString stringWithFormat:@"EE8Gua_%@",OutputBinaryStr(gua,3)];
    return NSLocalizedString(key, nil);
}
EEYY EE8GuaYinYang(EE8GuaT gua)
{
    switch (gua) {
        case EE8Gua_Qian:
        case EE8Gua_Kan:
        case EE8Gua_Gen:
        case EE8Gua_Zhen:{
            return EEYY_Sun;
        }
        case EE8Gua_Xun:
        case EE8Gua_Li:
        case EE8Gua_Kun:
        case EE8Gua_Dui:{
            return EEYY_Mon;
        }
        default:{
            return EENotFound;
        }
    }
}

NSString *EE8XiangStr(EE8Xiang xiang)
{
    NSString *key = [NSString stringWithFormat:@"EE8Xiang_%@",OutputBinaryStr(xiang,3)];
    return NSLocalizedString(key, nil);
}

@implementation EE8Gua

- (instancetype)initByDiY:(EEYY)diY renY:(EEYY)renY tianY:(EEYY)tianY
{
    self = [super init];
    if (self) {
        _type = diY + (renY << 1) + (tianY << 2);
        [self setupWithType:_type];
    }
    return self;
}

- (instancetype)initByXtGuaXu:(NSInteger)gx
{
    if (gx< 0 || gx > 8) {
        return nil;
    }
    self = [super init];
    if (self) {
        EE8GuaT type = [[[self xtGuaXu]objectAtIndex:gx]intValue];
        [self setupWithType:type];
    }
    return self;
}

- (instancetype)initByType:(EE8GuaT)type
{
    self = [super init];
    if (self) {
        [self setupWithType:type];
    }
    return self;
}

-(void)setupWithType:(EE8GuaT)type
{
    _type = type;
    [self ding5Xing];
    [self setupTDRYao];
}

-(NSString *)description
{
    NSMutableString *desc = [NSMutableString stringWithFormat:@"> %@ | %@ \n",EE8GuaString(self.type),self.xing5];
    [desc appendFormat:@"%@\n",self.yTian];
    [desc appendFormat:@"%@\n",self.yRen];
    [desc appendFormat:@"%@\n",self.yDi];
    
    return [NSString stringWithString:desc];
}

-(void)setupTDRYao
{
    _yTian = [[EEYao alloc]initByType:self.ytTian];
    _yDi = [[EEYao alloc]initByType:self.ytDi];
    _yRen = [[EEYao alloc]initByType:self.ytRen];
}

-(EELocation)htLocation
{
    switch (self.type) {
        case EE8Gua_Qian:{
            return EELocation_WestNorth;
        }
        case EE8Gua_Dui:{
            return EELocation_West;
        }
        case EE8Gua_Kan:{
            return EELocation_North;
        }
        case EE8Gua_Zhen:{
            return EELocation_East;
        }
        case EE8Gua_Xun:{
            return EELocation_EastSouth;
        }
        case EE8Gua_Gen:{
            return EELocation_EastNorth;
        }
        case EE8Gua_Kun:{
            return EELocation_WestSouth;
        }
        case EE8Gua_Li:{
            return EELocation_South;
        }
        default:{
            return EENotFound;
        }
    }
}

-(NSArray *)xtGuaXu
{
    static NSArray *xtgx = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        xtgx = @[@(EE8Gua_Qian),@(EE8Gua_Dui),@(EE8Gua_Kan),@(EE8Gua_Zhen),@(EE8Gua_Xun),@(EE8Gua_Gen),@(EE8Gua_Kun),@(EE8Gua_Li)];
    });
    return xtgx;
}

-(void)ding5Xing
{
    switch (self.type) {
        case EE8Gua_Qian:
        case EE8Gua_Dui:{
            _xing5 = [EE5Xing byType:EE5Xing_Jin];
            break;
        }
        case EE8Gua_Kan:{
            _xing5 = [EE5Xing byType:EE5Xing_Shui];
            break;
        }
        case EE8Gua_Zhen:
        case EE8Gua_Xun:{
            _xing5 = [EE5Xing byType:EE5Xing_Mu];
            break;
        }
        case EE8Gua_Gen:
        case EE8Gua_Kun:{
            _xing5 = [EE5Xing byType:EE5Xing_Tu];
            break;
        }
        case EE8Gua_Li:{
            _xing5 = [EE5Xing byType:EE5Xing_Huo];
            break;
        }
        default:{
            _xing5 = nil;            
        }
    }
}

-(EEYY)ytTian
{
    return (_type&0b100)>>2;
}
-(EEYY)ytRen
{
    return (_type&0b010)>>1;
}
-(EEYY)ytDi
{
    return _type&0b001;
}

- (EE8GuaT)diDong
{
    EEYY y = !self.ytDi;
    EE8GuaT bg = _type | y;
    return bg;
}

- (EE8GuaT)renDong
{
    EEYY y = !self.ytRen << 1;
    EE8GuaT bg = _type | y;
    return bg;
}

- (EE8GuaT)tianDong
{
    EEYY y = !self.ytTian << 2;
    EE8GuaT bg = _type | y;
    return bg;
}

-(EE8Xiang)xiang
{
    return (EE8Xiang)_type;
}

@end

@implementation EE8GuaExt

-(instancetype)initByType:(EE8GuaT)type pos:(EE8Gua_Pos)pos
{
    self = [super initByType:type];
    if (self) {
        _pos = pos;
        [self anTGDZ];
        if (_pos == EE8GuaPos_Inner) {
            self.yDi.pos = EEYaoPos_Chu;
            self.yRen.pos = EEYaoPos_Er;
            self.yTian.pos = EEYaoPos_San;
        }else{
            self.yDi.pos = EEYaoPos_Si;
            self.yRen.pos = EEYaoPos_Wu;
            self.yTian.pos = EEYaoPos_Shang;
        }
    }
    return self;
}

-(NSString *)description
{
    NSMutableString *desc = [NSMutableString string];
    [desc appendFormat:@"%@\n",self.yTian];
    [desc appendFormat:@"%@\n",self.yRen];
    [desc appendFormat:@"%@",self.yDi];
    return [NSString stringWithString:desc];
}

-(void)anTGDZ
{
    //        装天干：
    switch (self.type) {
        //阳四卦--------------------------------------------------
        //乾金甲子外壬午，由下至上，甲子、甲寅、甲辰、壬午、壬申、壬戌
        case EE8Gua_Qian:{
            if (_pos == EE8GuaPos_Inner) {
                _tianGan10 = [EE10TianGan byType:EE10TianGan_Jia];
                self.yDi.dz12 = EE12DiZhi_Zi;
                self.yRen.dz12 = EE12DiZhi_Yin;
                self.yTian.dz12 = EE12DiZhi_Chen;
            }else{
                _tianGan10 = [EE10TianGan byType:EE10TianGan_Ren];
                self.yDi.dz12 = EE12DiZhi_Wu;
                self.yRen.dz12 = EE12DiZhi_Shen;
                self.yTian.dz12 = EE12DiZhi_Xu;
            }
            break;
        }
        //坎水戊寅外戊申，由下至上，戊寅、戊辰、戊午、戊申、戊戌、戊子
        case EE8Gua_Kan:{
            _tianGan10 = [EE10TianGan byType:EE10TianGan_Wu];
            if (_pos == EE8GuaPos_Inner) {
                self.yDi.dz12 = EE12DiZhi_Yin;
                self.yRen.dz12 = EE12DiZhi_Chen;
                self.yTian.dz12 = EE12DiZhi_Wu;
            }else{
                self.yDi.dz12 = EE12DiZhi_Shen;
                self.yRen.dz12 = EE12DiZhi_Xu;
                self.yTian.dz12 = EE12DiZhi_Zi;
            }
            break;
        }
        //震木庚子外庚午，由下至上，庚子、庚寅、庚辰、庚午、庚申、庚戌
        case EE8Gua_Zhen:{
            _tianGan10 = [EE10TianGan byType:EE10TianGan_Geng];
            if (_pos == EE8GuaPos_Inner) {
                self.yDi.dz12 = EE12DiZhi_Zi;
                self.yRen.dz12 = EE12DiZhi_Yin;
                self.yTian.dz12 = EE12DiZhi_Chen;
            }else{
                self.yDi.dz12 = EE12DiZhi_Wu;
                self.yRen.dz12 = EE12DiZhi_Shen;
                self.yTian.dz12 = EE12DiZhi_Xu;
            }
            break;
        }
        //艮土丙辰外丙戌，由下至上，丙辰、丙午、丙申、丙戌、丙子、丙寅
        case EE8Gua_Gen:{
            _tianGan10 = [EE10TianGan byType:EE10TianGan_Bing];
            if (_pos == EE8GuaPos_Inner) {
                self.yDi.dz12 = EE12DiZhi_Chen;
                self.yRen.dz12 = EE12DiZhi_Wu;
                self.yTian.dz12 = EE12DiZhi_Shen;
            }else{
                self.yDi.dz12 = EE12DiZhi_Xu;
                self.yRen.dz12 = EE12DiZhi_Zi;
                self.yTian.dz12 = EE12DiZhi_Yin;
            }
            break;
        }
        //阴四卦--------------------------------------------------
        //坤土乙未外癸丑，由下至上，乙未、乙巳、乙卯、癸丑、癸亥、癸酉
        case EE8Gua_Kun:{
            if (_pos == EE8GuaPos_Inner) {
                _tianGan10 = [EE10TianGan byType:EE10TianGan_Yi];
                self.yDi.dz12 = EE12DiZhi_Wei;
                self.yRen.dz12 = EE12DiZhi_Si;
                self.yTian.dz12 = EE12DiZhi_Mao;
            }else{
                _tianGan10 = [EE10TianGan byType:EE10TianGan_Gui];
                self.yDi.dz12 = EE12DiZhi_Chou;
                self.yRen.dz12 = EE12DiZhi_Hai;
                self.yTian.dz12 = EE12DiZhi_You;
            }
            break;
        }
            //巽木辛丑外辛未，由下至上，辛丑、辛亥、辛酉、辛未、辛巳、辛卯
        case EE8Gua_Xun:{
            _tianGan10 = [EE10TianGan byType:EE10TianGan_Xin];
            if (_pos == EE8GuaPos_Inner) {
                self.yDi.dz12 = EE12DiZhi_Chou;
                self.yRen.dz12 = EE12DiZhi_Hai;
                self.yTian.dz12 = EE12DiZhi_You;
            }else{
                self.yDi.dz12 = EE12DiZhi_Wei;
                self.yRen.dz12 = EE12DiZhi_Si;
                self.yTian.dz12 = EE12DiZhi_Mao;
            }
            break;
        }
            //离火己卯外己酉，由下至上，己卯、己丑、己亥、己酉、己未、己巳
        case EE8Gua_Li:{
            _tianGan10 = [EE10TianGan byType:EE10TianGan_Ji];
            if (_pos == EE8GuaPos_Inner) {
                self.yDi.dz12 = EE12DiZhi_Mao;
                self.yRen.dz12 = EE12DiZhi_Chou;
                self.yTian.dz12 = EE12DiZhi_Hai;
            }else{
                self.yDi.dz12 = EE12DiZhi_You;
                self.yRen.dz12 = EE12DiZhi_Wei;
                self.yTian.dz12 = EE12DiZhi_Si;
            }
            break;
        }
            //兑金丁巳外丁亥，由下至上，丁巳、丁卯、丁丑、丁亥、丁酉、丁未
        case EE8Gua_Dui:{
            _tianGan10 = [EE10TianGan byType:EE10TianGan_Ding];
            if (_pos == EE8GuaPos_Inner) {
                self.yDi.dz12 = EE12DiZhi_Si;
                self.yRen.dz12 = EE12DiZhi_Mao;
                self.yTian.dz12 = EE12DiZhi_Chou;
            }else{
                self.yDi.dz12 = EE12DiZhi_Hai;
                self.yRen.dz12 = EE12DiZhi_You;
                self.yTian.dz12 = EE12DiZhi_Wei;
            }
            break;
        }
    }
}

@end
