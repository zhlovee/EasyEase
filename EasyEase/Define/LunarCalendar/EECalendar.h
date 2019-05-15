//
//  EECalendar.h
//  EasyEase
//
//  Created by lizhenghao on 2018/10/28.
//  Copyright © 2018 lizhenghao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EE10TianGan.h"
#import "EE12DiZhi.h"

@interface EELunarDate : NSObject

+(instancetype)curDate;
+(instancetype)dateByYear:(int)year month:(int)month day:(int)day hour:(int)hour;
- (instancetype)initByMonthDizhi:(EE12DiZhiT)mDz dayDizhi:(EE12DiZhiT)dDz;

@property(readonly)NSDateComponents *lunarComp;

@property(readonly)EE10TianGan* yearTianGan;
@property(readonly)EE12DiZhi* yearDiZhi;
@property(readonly)EE12DiZhiT yearEmpty;

@property(readonly)EE10TianGan* monthTianGan;
@property(readonly)EE12DiZhi* monthDiZhi;
@property(readonly)EE12DiZhiT monthEmpty;

@property(readonly)EE10TianGan* dayTianGan;
@property(readonly)EE12DiZhi* dayDiZhi;
@property(readonly)EE12DiZhiT dayEmpty;

@property(readonly)EE10TianGan* hourTianGan;
@property(readonly)EE12DiZhi* hourDiZhi;
@property(readonly)EE12DiZhiT hourEmpty;

@end


@interface EECalendar : NSObject

@end

