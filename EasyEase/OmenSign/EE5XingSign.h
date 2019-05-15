//
//  EE5XingSign.h
//  EasyEase
//
//  Created by lizhenghao on 2018/11/5.
//  Copyright © 2018 lizhenghao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EESignPos,EE5X_SWMJSign;
@interface EE5XingSign : NSObject

@property(readonly)EESignPos *gong;
@property(readonly)EESignPos *shou;

@end

@class EEPosSet;
@interface EE5XingSignSet : NSObject

- (instancetype)initByPosSet:(EEPosSet*)posSet;

@end

typedef enum {
    EE5X_SWMJ_ChangSheng,
    EE5X_SWMJ_MuYu,
    EE5X_SWMJ_GuanDai,
    EE5X_SWMJ_LinGuan,
    EE5X_SWMJ_DiWang,
    EE5X_SWMJ_Shuai,
    EE5X_SWMJ_Bing,
    EE5X_SWMJ_Si,
    EE5X_SWMJ_Mu,
    EE5X_SWMJ_Jue,
    EE5X_SWMJ_Tai,
    EE5X_SWMJ_Yang
}EE5X_SWMJ;

@interface EE5X_SWMJSign : NSObject

@property(readonly)EE5X_SWMJ type;
@property(readonly)EESignPos *timePos;
@property(readonly)EESignPos *yaoPos;
- (instancetype)initBytimePos:(EESignPos*)tp yaoPos:(EESignPos*)yp;

@end
