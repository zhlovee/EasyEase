//
//  EEShenSha.h
//  EasyEase
//
//  Created by lizhenghao on 2018/11/25.
//  Copyright © 2018 lizhenghao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    EEShenSha_TYGR_GuiRen       = 1 << 0,
    EEShenSha_TYGR_JiGuiRen     = 1 << 1,
    
    EEShenSha_TaoHua            = 1 << 2,
}EEShenShaT;

//常用神煞
@interface EEShenSha : NSObject

@property(nonatomic,assign)EEShenShaT type;

//天乙贵人
-(void)tryTianYiGuiRenByDayTg:(EE10TianGanT)tgDay yongShenDz:(EE12DiZhi*)dzYs jsDz:(EE12DiZhi*)jsDz;

//桃花：
-(void)tryTaoHuaYunByDayDz:(EE12DiZhiT)dzDay yongShenDz:(EE12DiZhiT)dzYs;

@end

NS_ASSUME_NONNULL_END
