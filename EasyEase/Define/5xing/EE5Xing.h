//
//  EE5Xing.h
//  EasyEase
//
//  Created by lizhenghao on 2018/10/27.
//  Copyright © 2018 lizhenghao. All rights reserved.
//

#import "EETaiChi.h"

typedef enum {
    EE5Xing_Jin = 0,
    EE5Xing_Shui = 1,
    EE5Xing_Mu = 2,
    EE5Xing_Huo = 3,
    EE5Xing_Tu = 4,
}EE5XingT;

typedef enum {
    EELocation_West = EE5Xing_Jin,
    EELocation_North = EE5Xing_Shui,
    EELocation_East = EE5Xing_Mu,
    EELocation_South = EE5Xing_Huo,
    EELocation_Center = EE5Xing_Tu,
    EELocation_WestNorth,
    EELocation_EastNorth,
    EELocation_EastSouth,
    EELocation_WestSouth,
}EELocation;

typedef enum {
    EEWQS_Wang,
    EEWQS_Xiang,
    EEWQS_Xiu,
    EEWQS_Qiu,
    EEWQS_Si
}EEWQS;

extern NSString *EEWQSStr(EEWQS wqs);
extern NSString *EEWJSStr(EEWQS wqs);

@interface EE5Xing : EEObject

+(instancetype)byType:(EE5XingT)x5;
@property(readonly)EE5XingT type;
@property(readonly)EELocation location;

-(EE5XingT)shWo;
-(EE5XingT)keWo;
-(EE5XingT)woSh;
-(EE5XingT)woKe;

//五行旺相休囚死
-(EEWQS)wqsBy:(EE5Xing *)xing5;

@end
