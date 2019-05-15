//
//  EECalendar.m
//  EasyEase
//
//  Created by lizhenghao on 2018/10/28.
//  Copyright © 2018 lizhenghao. All rights reserved.
//

#import "EECalendar.h"

NSTimeInterval JiRiCalc(NSInteger y,EE24JieQi jq)
{
    int x = CircleCalc(jq, 24, 2);
    
//    NSLog(@"JieQiIdx:%d",x);
    NSTimeInterval base = 365.242 * (y - 1900) + 6.2 + (15.22 * x) - (1.9 * sinf(0.262 * x));// 计算积日
    //过滤时分秒,由于基准日为1900年1月0日，所以这里需要-1
    base = floor(base - 1) * 24 * 60 *60;
    return base;
}

@interface EELunarDate ()

@property(readonly)NSDate *baseTime1900;

@end

@implementation EELunarDate{
    NSDate *_curDate;
    BOOL _test;
}

+(void)verify24JieQi
{
//    24节气校验
    NSDateComponents *dc = [[NSDateComponents alloc]init];
    dc.year = 1900; dc.month = 1; dc.day = 1;
    NSDate *jzr = [[NSCalendar currentCalendar]dateFromComponents:dc];
//    jzr = [jzr dateByAddingTimeInterval:-9843];
//    NSTimeInterval ofs = JiRiCalc(1900, EE24JieQi_XiaoHan);
//    jzr = [jzr dateByAddingTimeInterval:-ofs];

    for (EE24JieQi i = 0; i < 24; i++) {
        NSTimeInterval ti = JiRiCalc(1900, i);
        NSDate *dd = [jzr dateByAddingTimeInterval:ti];
        NSString *key = [NSString stringWithFormat:@"EE24JieQi_%d",i];
        //        NSLog(@"%@",dd);
        NSLog(@"%@ ===>>>> %@",NSLocalizedString(key, nil),[[self timeFormatter]stringFromDate:dd]);
    }
//    1900
//    立春    2月4日 13:51:31    雨水    2月19日 10:01:14    惊蛰    3月6日 08:21:52
//    春分    3月21日 09:39:01    清明    4月5日 13:52:41    谷雨    4月20日 21:27:06
//    立夏    5月6日 07:55:12    小满    5月21日 21:16:55    芒种    6月6日 12:38:55
//    夏至    6月22日 05:39:45    小暑    7月7日 23:10:08    大暑    7月23日 16:36:07
//    立秋    8月8日 08:50:34    处暑    8月23日 23:19:49    白露    9月8日 11:16:38
//    秋分    9月23日 20:20:11    寒露    10月9日 02:13:09    霜降    10月24日 04:55:16
//    立冬    11月8日 04:39:44    小雪    11月23日 01:47:50    大雪    12月7日 20:55:50
//    冬至    12月22日 14:41:34    小寒    1月6日 02:03:57    大寒    1月20日 19:32:25
}

+(NSCalendar *)lunarCalendar
{
    static dispatch_once_t onceToken;
    static NSCalendar *lunarCalendar = nil;

    dispatch_once(&onceToken, ^{
        lunarCalendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    });
    return lunarCalendar;
}

+(NSDateFormatter*)timeFormatter
{
    static NSDateFormatter *fmt;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fmt = [[NSDateFormatter alloc]init];
        [fmt setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        fmt.timeZone = [NSTimeZone defaultTimeZone];
    });
    
    return fmt;
}


+(instancetype)curDate
{
    EELunarDate *de = [[EELunarDate alloc]initWithDate:[NSDate date]];
    return de;
}

+(instancetype)dateByYear:(int)year month:(int)month day:(int)day hour:(int)hour
{
    NSDateComponents * dc = [[NSDateComponents alloc] init];
    dc.year = year;
    dc.month = month;
    dc.day = day;
    dc.hour = hour;
//    dc.timeZone = [NSTimeZone defaultTimeZone];
    NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:dc];
    
    EELunarDate *de = [[EELunarDate alloc]initWithDate:date];
    return de;
}

- (instancetype)initByMonthDizhi:(EE12DiZhiT)mDz dayDizhi:(EE12DiZhiT)dDz
{
    self = [super init];
    if (self) {
        _test = YES;
        _monthDiZhi = [EE12DiZhi byType:mDz];
        _dayDiZhi = [EE12DiZhi byType:dDz];
    }
    return self;
}

- (instancetype)initWithDate:(NSDate*)date
{
    self = [super init];
    if (self) {
        _curDate = date;
        
        NSDateComponents *components  =  [[EELunarDate lunarCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour fromDate:date];
        NSInteger year = components.year;
        
        _lunarComp = components;
        
        //year
        _yearTianGan = [EE10TianGan byType:(EE10TianGanT)(year-1)%10];
        _yearDiZhi = [EE12DiZhi byType:(EE12DiZhiT)(year-1)%12];
        
        //month
        NSDateComponents *comp  =  [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:date];
        [self calcDizhiByYear:comp.year lunarComp:components];

        //day
        [self getDayHeavenlyStemsEarthlyBranches];
        
        //hour
        _hourDiZhi = [EE12DiZhi byHour:(int)components.hour];
        int ofs = _dayTianGan.type%5;
        EE10TianGanT t = CircleCalc(EE10TianGan_Jia, 10, ofs*2);
        t = CircleCalc(t, 10, _hourDiZhi.type);
        _hourTianGan = [EE10TianGan byType:t];
        
        //六甲寻空亡
        _yearEmpty = [self findLiuJiaKongWang:_yearTianGan.type dizhi:_yearDiZhi.type];
        _monthEmpty = [self findLiuJiaKongWang:_monthTianGan.type dizhi:_monthDiZhi.type];
        _dayEmpty = [self findLiuJiaKongWang:_dayTianGan.type dizhi:_dayDiZhi.type];
        _hourEmpty = [self findLiuJiaKongWang:_hourTianGan.type dizhi:_hourDiZhi.type];
        
    }
    return self;
}

-(NSDate*)baseTime1900
{
//    1900 年立春
    static NSDate *jzr = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        1900-02-04 13:51:31,35.689339882487161
//        jzr = [[EELunarDate timeFormatter]dateFromString:@"1900-02-04 13:51:31"];

//        //        (NSTimeInterval) ofs = 35.689339882487161
        NSDateComponents *dc = [[NSDateComponents alloc]init];
        dc.year = 1900; dc.month = 1; dc.day = 1;
        jzr = [[NSCalendar currentCalendar]dateFromComponents:dc];
//        NSDateComponents *dc = [[NSDateComponents alloc]init];
//        dc.year = 1900; dc.month = 1; dc.day = 6;
//        jzr = [[NSCalendar currentCalendar]dateFromComponents:dc];
//
//        NSTimeInterval ofs = JiRiCalc(1900, EE24JieQi_XiaoHan);
//        jzr = [jzr dateByAddingTimeInterval:-ofs];
    });

    return jzr;
}

-(NSTimeInterval)getJiriCalc:(NSInteger)yeary ee24:(int)jq
{
    return JiRiCalc(yeary, jq);
}

-(NSTimeInterval)getDayJiri:(NSTimeInterval)ti
{
    return ti/(24*60*60);
}

-(void)calcDizhiByYear:(NSInteger)year lunarComp:(NSDateComponents *)lunarComp
{
    EE12DiZhi *dizhi = [EE12DiZhi byMonth:(int)lunarComp.month];
    
    NSTimeInterval curOfs = [_curDate timeIntervalSinceDate:self.baseTime1900];
    
    NSInteger yearBegin = year, yearEnd = year;
    if (dizhi.midJQ == EE24JieQi_XiaoHan || dizhi.midJQ == EE24JieQi_DaXue) {
        NSTimeInterval ti1 = JiRiCalc(year, dizhi.midJQ) - curOfs;
        NSTimeInterval ti2 = JiRiCalc(year-1, dizhi.midJQ) - curOfs;
        yearBegin = fabs(ti1) < fabs(ti2) ? year : year - 1;
        
        ti1 = JiRiCalc(year, dizhi.sufJQ) - curOfs;
        ti2 = JiRiCalc(year+1, dizhi.sufJQ) - curOfs;
        yearEnd = fabs(ti1) < fabs(ti2) ? year : year + 1;
    }
    NSTimeInterval ofsBegin = JiRiCalc(yearBegin, dizhi.midJQ);
    NSTimeInterval ofsEnd = JiRiCalc(yearEnd, dizhi.sufJQ);
    
    int calcMonth = (int)lunarComp.month;
    if (curOfs < ofsBegin) {
        calcMonth = CircleCalcP(calcMonth, 1, 12, -1);
        _monthDiZhi = [EE12DiZhi byMonth:calcMonth];
    }
    else if (curOfs >= ofsEnd){
        calcMonth = CircleCalcP(calcMonth, 1, 12, 1);
        _monthDiZhi = [EE12DiZhi byMonth:calcMonth];
    }else{
        _monthDiZhi = [EE12DiZhi byMonth:calcMonth];
    }
    int ofs = _yearTianGan.type%5;
    EE10TianGanT t = EE10TianGan_Bing;
    //bing wu geng ren jia
    t = CircleCalc(t, 10, ofs*2);
    t = CircleCalc(t, 10, calcMonth-1);
    _monthTianGan = [EE10TianGan byType:t];
}


-(EE12DiZhiT)findLiuJiaKongWang:(EE10TianGanT)tg dizhi:(EE12DiZhiT)dz
{
    int ofs = 10 - tg;
    EE12DiZhiT target = CircleCalc(dz, 12, ofs);
    return target;
}

//推算这一天的 干支
-(void)getDayHeavenlyStemsEarthlyBranches
{
//    第一种算法，取2000年1月七日正好是甲子日，计算相差天数循环推算出当前的干支,我他妈就是个天才啊！！！
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDateComponents *c2000  =  [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour fromDate:_curDate];
    c2000.year = 2000;
    c2000.month = 1;
    c2000.day = 7;
    NSDate * d2000 = [calendar dateFromComponents:c2000];
    
    NSTimeInterval timeInterval = [_curDate timeIntervalSinceDate:d2000];
    //计算出天、小时、分钟
    int day = timeInterval/(60*60*24);
    
    _dayTianGan = [EE10TianGan byType:(EE10TianGanT)CircleCalc(day, 10, 0)];
    _dayDiZhi = [EE12DiZhi byType:(EE12DiZhiT)CircleCalc(day, 12, 0)];
    
//    另一种算法，看不懂就没采用
//    NSCalendar *car = [NSCalendar currentCalendar];
//
//    NSDateComponents *components  =  [car components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
//    //注意是到下标为1的结束，不包含下标为2的数据
//    NSString *yearStr = [NSString stringWithFormat:@"%@",@(components.year)];
//    NSInteger C = [[yearStr substringToIndex:2] integerValue];
//    //注意是从下标为2的开始的数据
//    NSInteger y = [[yearStr substringFromIndex:2] integerValue];
//    NSInteger m = components.month;
//    NSInteger d = components.day;
//    NSInteger i = m % 2 == 0 ? 6 : 0;
//    if((m == 1) || (m == 2))
//    {
//        m = m + 12;
//        NSInteger yearValue = [yearStr integerValue] - 1;
//        NSString * yearNewStr = [NSString stringWithFormat:@"%4ld",yearValue];
//        C = [[yearNewStr substringToIndex:1] integerValue];
//        y = [[yearNewStr substringFromIndex:2] integerValue];
//    }
//
//    NSInteger g = (4*C + C/4 + 5*y + y/4 + 3*(m + 1)/5 + d - 3)%10;
//    NSInteger z = (8*C + C/4 + 5*y + y/4 + 3*(m + 1)/5 + d + 7 + i)%12;
//    if((g < 0) || (z < 0))
//    {
//        NSAssert(NO, @"unknow date");
//    }else{
//        _dayTianGan = (EE10TianGanT)CircleCalc((int)g, 10, -1);
//        _dayDiZhi = (EE12DiZhiT)CircleCalc((int)z, 12, -1);
//    }
}

-(NSString *)description
{
    if (_test) {
        NSString *desc = [NSString stringWithFormat:@"| %@月 %@日 |",_monthDiZhi,_dayDiZhi];
        return desc;
    }
    NSMutableString *str = [[NSMutableString alloc]initWithString:@""];
    [str appendFormat:@"| %@%@年 %@%@月 %@%@日 %@%@时 |",_yearTianGan,_yearDiZhi,_monthTianGan,_monthDiZhi,_dayTianGan,_dayDiZhi,_hourTianGan,_hourDiZhi];
    
    [str appendFormat:@"\n| %@%@空 %@%@空 %@%@空 %@%@空 |",
     [EE12DiZhi byType:_yearEmpty],[EE12DiZhi byType:_yearEmpty+1],
     [EE12DiZhi byType:_monthEmpty],[EE12DiZhi byType:_monthEmpty+1],
     [EE12DiZhi byType:_dayEmpty],[EE12DiZhi byType:_dayEmpty+1],
     [EE12DiZhi byType:_hourEmpty],[EE12DiZhi byType:_hourEmpty+1]];
    
    return str;
}

@end



@implementation EECalendar

//+(void)load
//{
    //    https://www.cnblogs.com/silence-cnblogs/p/6368437.html
    
//    获取农历年月日
//
//    用 Calendar (NSCalendar) 获取农历年月日
//
//    与公历相似，更改 Calendar (NSCalendar) 的初始化即可，其他代码相同
//
//    let calendar: Calendar = Calendar(identifier: .chinese)
//    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierChinese];
//    结果
//
//
//
//    用 Calendar 和 DateComponents (NSCalendar 和 NSDateComponents) 获取农历年月日
//
//    同上节用 Calendar (NSCalendar) 获取农历年月日
//
//    用 DateFormatter (NSDateFormatter) 获取农历年月日
//
//    与公历相似，在初始化 DateFormatter (NSDateFormatter) 之后，给 calendar 属性赋值即可，其他代码相同
//
//    let formatter: DateFormatter = DateFormatter()
//    formatter.calendar = Calendar(identifier: .chinese)
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    formatter.calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierChinese];
//    结果
//
//
//
//    计算日期年份的生肖
//
//    自定义一个类 ChineseCalendar 来计算。十二生肖数组写在类外面。
//
//    十二生肖数组
//
//    private let Zodiacs: [String] = ["鼠", "牛", "虎", "兔", "龙", "蛇", "马", "羊", "猴", "鸡", "狗", "猪"]
//    ChineseCalendar 的类方法
//
//    static func zodiac(withYear year: Int) -> String {
//        let zodiacIndex: Int = (year - 1) % Zodiacs.count
//        return Zodiacs[zodiacIndex]
//    }
//
//    static func zodiac(withDate date: Date) -> String {
//        let calendar: Calendar = Calendar(identifier: .chinese)
//        return zodiac(withYear: calendar.component(.year, from: date))
//    }
//    测试
//
//    print("Chinese zodiac string:", ChineseCalendar.zodiac(withDate: date))
//    结果
//
//
//
//    计算日期年份的天干地支
//
//    在 ChineseCalendar 中用类方法计算。天干地支数组写在类外面。
//
//    天干地支数组
//
//    private let HeavenlyStems: [String] = ["甲", "乙", "丙", "丁", "戊", "己", "庚", "辛", "壬", "癸"]
//    private let EarthlyBranches: [String] = ["子", "丑", "寅", "卯", "辰", "巳", "午", "未", "申", "酉", "戌", "亥"]
//    ChineseCalendar 的类方法
//
//    static func era(withYear year: Int) -> String {
//        let heavenlyStemIndex: Int = (year - 1) % HeavenlyStems.count
//        let heavenlyStem: String = HeavenlyStems[heavenlyStemIndex]
//        let earthlyBrancheIndex: Int = (year - 1) % EarthlyBranches.count
//        let earthlyBranche: String = EarthlyBranches[earthlyBrancheIndex]
//        return heavenlyStem + earthlyBranche
//    }
//
//    static func era(withDate date: Date) -> String {
//        let calendar: Calendar = Calendar(identifier: .chinese)
//        return era(withYear: calendar.component(.year, from: date))
//    }
//    测试
//
//    print("Chinese era string:", ChineseCalendar.era(withDate: date))
//}

//农历转换函数
//- (NSString *)LunarForSolar:(NSDate *)solarDate
//{
//    ////天干名称
//    //
//    //NSArray *cTianGan= [NSArray arrayWithObjects:@"甲",@"乙",@"丙",@"丁",@"戊",@"己",@"庚",@"辛",@"壬",@"癸", nil];
//    //
//    ////地支名称
//    //
//    //NSArray *cDiZhi = [NSArray arrayWithObjects:@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥",nil];
//    //
//    ////属相名称
//    //
//    //NSArray *cShuXiang = [NSArray arrayWithObjects:@"鼠",@"牛",@"虎",@"兔",@"龙",@"蛇",@"马",@"羊",@"猴",@"鸡",@"狗",@"猪",nil];
//    
//    //农历日期名
//    
//    NSArray *cDayName = [NSArray arrayWithObjects:@"*",@"初一",@"初二",@"初三",@"初四",@"初五",@"初六",@"初七",@"初八",@"初九",@"初十",@"十一",@"十二",@"十三",@"十四",@"十五",@"十六",@"十七",@"十八",@"十九",@"二十",@"廿一",@"廿二",@"廿三",@"廿四",@"廿五",@"廿六",@"廿七",@"廿八",@"廿九",@"三十",nil];
//    
//    //农历月份名
//    
//    NSArray *cMonName = [NSArray arrayWithObjects:@"*",@"正",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"十",@"十一",@"腊",nil];
//    
//    //公历每月前面的天数const int wMonthAdd[12] = {0,31,59,90,120,151,181,212,243,273,304,334};
//    
//    //农历数据
//    
//    const int wNongliData[100] = {2635,333387,1701,1748,267701,694,2391,133423,1175,396438,3402,3749,331177,1453,694,201326,2350,465197,3221,3402,400202,2901,1386,267611,605,2349,137515,2709,464533,1738,2901,330421,1242,2651,199255,1323,529706,3733,1706,398762,2741,1206,267438,2647,1318,204070,3477,461653,1386,2413,330077,1197,2637,268877,3365,531109,2900,2922,398042,2395,1179,267415,2635,661067,1701,1748,398772,2742,2391,330031,1175,1611,200010,3749,527717,1452,2742,332397,2350,3222,268949,3402,3493,133973,1386,464219,605,2349,334123,2709,2890,267946,2773,592565,1210,2651,395863,1323,2707,265877};
//    
//    static int wCurYear,wCurMonth,wCurDay;static int nTheDate,nIsEnd,m,k,n,i,nBit;
//    
//    //取当前公历年、月、日
//    
//    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:solarDate];wCurYear = [components year];wCurMonth = [components month];wCurDay = [components day];
//    
//    //计算到初始时间1921年2月8日的天数：1921-2-8(正月初一)
//    
//    nTheDate = (wCurYear - 1921) * 365 + (wCurYear - 1921) / 4 + wCurDay + wMonthAdd[wCurMonth - 1] - 38;    if((!(wCurYear % 4)) && (wCurMonth > 2))        nTheDate = nTheDate + 1;        //计算农历天干、地支、月、日    nIsEnd = 0;    m = 0;    while(nIsEnd != 1)    {        if(wNongliData[m] < 4095)            k = 11;        else            k = 12;        n = k;        while(n>=0)        {    //获取wNongliData(m)的第n个二进制位的值nBit = wNongliData[m];for(i=1;iwNongliData[m] / 65536 + 1)
//    
//    wCurMonth = wCurMonth - 1;
//    
//    //生成农历天干、地支、属相
//    
//    NSString *szShuXiang = (NSString *)[cShuXiang objectAtIndex:((wCurYear - 4) % 60) % 12];
//    
//    NSString *szNongli = [NSString stringWithFormat:@"%@(%@%@)年",szShuXiang, (NSString *)[cTianGan objectAtIndex:((wCurYear - 4) % 60) % 10],(NSString *)[cDiZhi objectAtIndex:((wCurYear - 4) % 60) % 12]];
//    
//    //生成农历月、日
//    
//    NSString *szNongliDay;
//    
//    if (wCurMonth < 1){
//        
//        szNongliDay = [NSString stringWithFormat:@"闰%@",(NSString *)[cMonName objectAtIndex:-1 * wCurMonth]];
//        
//    }
//    
//    else{
//        
//        szNongliDay = (NSString *)[cMonName objectAtIndex:wCurMonth];
//        
//    }
//    
//    NSString *lunarDate = [NSString stringWithFormat:@"%@ %@月 %@",szNongli,szNongliDay,(NSString *)[cDayName objectAtIndex:wCurDay]];
//    
//    NSString *lunarDate1 = [NSString stringWithFormat:@"%@",(NSString *)[cDayName objectAtIndex:wCurDay]];
//    
//    return lunarDate1;
//}

@end
