//
//  EERandomGenerater.m
//  EasyEase
//
//  Created by lizhenghao on 2018/10/30.
//  Copyright © 2018 lizhenghao. All rights reserved.
//

#import "EERandomGenerater.h"
#import "EE64Gua.h"
#import "EECalendar.h"
#import "EEOmenSign.h"

@implementation EERandomGenerater

-(void)divine
{
    EE64GuaT t = 0;
    for (int i = 0; i < 6; i++) {
        short f = arc4random()%2;

        t = t^(f << i);
    }

//    EE64Gua *gua = [[EE64Gua alloc]initByType:t];
//    EELunarDate *date = [EELunarDate curDate];
    EELunarDate *date = [EELunarDate dateByYear:2018 month:11 day:26 hour:2];
//    EELunarDate *date = [[EELunarDate alloc]initByMonthDizhi:EE12DiZhi_Chou dayDizhi:EE12DiZhi_You];
//    NSLog(@"%@",date);

    EE64Gua *gua = [[EE64Gua alloc]initByType:0b110100];
//    [gua bianGuaByDys:0b100000];

    EEOmenSign *os = [[EEOmenSign alloc]initByLunarDate:date gua64:gua];
//    NSLog(@"本卦");
    NSLog(@"%@",os);
//    NSLog(@"互卦");
//    NSLog(@"%@",gua.mutexGua);
}

@end
