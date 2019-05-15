//
//  EE5Xing.m
//  EasyEase
//
//  Created by lizhenghao on 2018/10/27.
//  Copyright © 2018 lizhenghao. All rights reserved.
//

#import "EE5Xing.h"

NSString *EEWQSStr(EEWQS wqs)
{
    NSString *str = [NSString stringWithFormat:@"EEWQS_%@",@(wqs)];
    return NSLocalizedString(str, nil);
}
NSString *EEWJSStr(EEWQS wqs)
{
    NSString *str = [NSString stringWithFormat:@"EEWJS_%@",@(wqs)];
    return NSLocalizedString(str, nil);
}

@implementation EE5Xing

+(instancetype)byType:(EE5XingT)x5
{
    EE5Xing *ins = [super byType:x5];
    ins->_type = x5;
    return ins;
}

-(EELocation)location
{
    return (EELocation)self.type;
}

- (EE5XingT)shWo
{
    return CircleCalc(self.type, 5, -1);
}
- (EE5XingT)woSh
{
    return CircleCalc(self.type, 5, +1);
}
-(EE5XingT)keWo
{
    return CircleCalc(self.type, 5, -2);
}
-(EE5XingT)woKe
{
    return CircleCalc(self.type, 5, +2);
}

-(EEWQS)wqsBy:(EE5Xing *)xing5
{
    if (xing5 == self) {
        return EEWQS_Wang;
    }else if ([xing5 shWo] == self.type){
        return EEWQS_Xiu;
    }else if ([xing5 keWo] == self.type){
        return EEWQS_Qiu;
    }else if ([xing5 woSh] == self.type){
        return EEWQS_Xiang;
    }else if ([xing5 woKe] == self.type){
        return EEWQS_Si;
    }
    return EENotFound;
}

@end
