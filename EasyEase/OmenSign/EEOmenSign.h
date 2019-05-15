//
//  EEOmenSign.h
//  EasyEase
//
//  Created by lizhenghao on 2018/10/30.
//  Copyright © 2018 lizhenghao. All rights reserved.
//

#import <Foundation/Foundation.h>

//专门用来解卦占卜的类
@class EELunarDate,EE64Gua;
@interface EEOmenSign : NSObject

- (instancetype)initByLunarDate:(EELunarDate*)date gua64:(EE64Gua*)gua;

@property(readonly)EELunarDate *date;
@property(readonly)EE64Gua *gua;

@end
