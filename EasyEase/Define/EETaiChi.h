//
//  EETaiChi.h
//  EasyEase
//
//  Created by lizhenghao on 2018/10/24.
//  Copyright © 2018 lizhenghao. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *OutputBinaryStr(int val, int len);

/**
 循环推算函数，你知道这个函数有多牛逼吗？？
 有多牛逼，我还是解释一下吧，可把我牛逼坏了。。
 
 循环推算，用计算机的方式实现了掐指一算的逻辑，遵循易学中到处都存在的物极必反的原理
 可以想象成一个圆 分成len份，推算从val增长inc份后的位置
 
 卧槽不行太膨胀了我
 
 @param val 起始位置
 @param len 区间数
 @param inc 增长值，正代表顺时针推算，负值代表逆时针推算
 @return 增长后的位置
 */
int CircleCalc(int val, int len, int inc);
int CircleCalcP(int val, int st, int len, int inc);

//元对象
@interface EEObject : NSObject

+(instancetype)byType:(int)type;

@end

@protocol EE_DefProtocol <NSObject>

@end

typedef enum {
    EEYY_Mon = 0,
    EEYY_Sun = 1,
}EEYY;


/**
 Tai Chi
 */
@protocol EETaiChiProtocol <EE_DefProtocol>

@end

@interface EETaiChi : NSObject<EETaiChiProtocol>

@end

///**
// 2 yi
// */
//@protocol EE2Yi <NSObject>
//
//@end
//@interface EE2Sun : NSObject<EE2Yi>
//
//@property(readonly)EE_SunYao *sYao;
//
//@end
//
//@interface EE2Moon : NSObject<EE2Yi>
//
//@property(readonly)EE_SunYao *mYao;
//
//@end


///**
// 4 xiang
// */
//@protocol EE4Xiang <NSObject>
//
//@end
//
//@interface EE4SaoSun : NSObject<EE4Xiang>
//
//@end
//
//@interface EE4TaiSun : NSObject<EE4Xiang>
//
//@end
//
//@interface EE4SaoMoon : NSObject<EE4Xiang>
//
//@end
//
//@interface EE4TaiMoon : NSObject<EE4Xiang>
//
//@end
