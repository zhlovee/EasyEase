//
//  EEWatchPeriod.h
//  EasyEase
//
//  Created by lizhenghao on 2019/7/30.
//  Copyright © 2019 lizhenghao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EEWatchPeriod : UIView

@end


typedef void (^CMRenderRectIndexCallback) (CGRect rect,NSUInteger idxCol, NSUInteger idxRow);

@interface UIView (CutView)


//备注：proportion format 的格式：比如 1：2：3纵向，就是把height分成6份每一份高度比为1：2：3
#pragma 把指定的rect进行分割按照比例或者平均分割
+(void)mp_cutRect:(CGRect)rect colProportion:(nullable NSString*)colPor rowProportion:(nullable NSString*)rowPor renderCallback:(CMRenderRectIndexCallback)block;
+(void)mp_cutRect:(CGRect)rect colCount:(NSUInteger)cols rowCount:(NSUInteger)rows renderCallback:(CMRenderRectIndexCallback)block;
+(void)mp_cutRectByVertical:(CGRect)rect rowProportion:(NSString*)rowPor renderCallback:(CMRenderRectIndexCallback)block;
+(void)mp_cutRectByHorizontal:(CGRect)rect colProportion:(NSString*)colPor renderCallback:(CMRenderRectIndexCallback)block;

+(void)mp_cutRect:(CGRect)rect colPAry:(nullable NSArray*)cols rowPAry:(nullable NSArray*)rows renderCallback:(CMRenderRectIndexCallback)block;

-(void)mp_setRandomBg;

@end


NS_ASSUME_NONNULL_END


