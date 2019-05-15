//
//  EETimeGenerater.m
//  EasyEase
//
//  Created by lizhenghao on 2018/11/1.
//  Copyright © 2018 lizhenghao. All rights reserved.
//

#import "EETimeGenerater.h"
#import "EE64Gua.h"
#import "EECalendar.h"
#import "EE8Gua.h"
#import "EEOmenSign.h"

@implementation EETimeGenerater

-(void)divine;
{
    //终身卦起卦法：
    
//    根据阳历日期生成农历日期
//    EELunarDate *date = [EELunarDate dateByYear:1941 month:1 day:23 hour:8];
    EELunarDate *date = [EELunarDate dateByYear:1990 month:2 day:10 hour:12];
    
//    年干（从1开始计算）+ 农历月份 + 农历日期
    int val = (int)(date.yearTianGan.type + 1 + date.lunarComp.month + date.lunarComp.day);
//    推算先天卦序
    int gx = CircleCalc(val, 8, 0);
//    起卦法对应0为第六爻，所以需要卦序倒推一个单位
    gx = CircleCalc(gx, 8, -1);
//    根据先天卦序位置生成上卦
    EE8Gua *shang = [[EE8Gua alloc]initByXtGuaXu:gx];
//    先天卦序总和加上小时地支时值（从1开始）
    int zol = val + date.hourDiZhi.type + 1;
//    同样的方法推算出先天卦序
    gx = CircleCalc(zol, 8, 0);
    gx = CircleCalc(gx, 8, -1);
//    生产下卦
    EE8Gua *xia = [[EE8Gua alloc]initByXtGuaXu:gx];
//    计算动爻位置
    int dy = CircleCalc(zol, 6, 0);
    dy = CircleCalc(dy, 6, -1);
    EE64Gua *gua = [[EE64Gua alloc]initByOuter:shang.type inner:xia.type];
    [gua yaoDongBy:dy];
    
    EEOmenSign *os = [[EEOmenSign alloc]initByLunarDate:date gua64:gua];
    NSLog(@"%@",os);
    //    NSLog(@"互卦");
    //    NSLog(@"%@",gua.mutexGua);

}

@end
