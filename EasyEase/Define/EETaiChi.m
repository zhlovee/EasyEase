//
//  EETaiChi.m
//  EasyEase
//
//  Created by lizhenghao on 2018/10/24.
//  Copyright © 2018 lizhenghao. All rights reserved.
//

#import "EETaiChi.h"

NSString *OutputBinaryStr(int val, int len)
{
    NSMutableString *str = [NSMutableString string];
    
    for (int i = len-1; i>=0; i--) {
        BOOL f = (val&(1<<i))>>i;
        [str appendFormat:@"%d",f];
    }
    return [NSString stringWithString:str];
}

int CircleCalc(int val, int len, int inc)
{
    int ret = (val + inc)%len;
    if (ret < 0) {
        return len + ret;
    }else{
        return ret;
    }
}
int CircleCalcP(int val, int st, int len, int inc)
{
    int ret = CircleCalc(val - st, len, inc) + st;
    return ret;
}

@implementation EEObject{
    NSString *_srcKey;
    int _t;
}

static NSMutableDictionary *unlimited = nil;

+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        unlimited = [NSMutableDictionary dictionary];
    });
}

+(instancetype)byType:(int)type
{
    NSString *key = [NSString stringWithFormat:@"%@_%d",NSStringFromClass(self),type];
    EEObject *ins = [unlimited objectForKey:key];
    if (!ins) {
        ins = [self.class new];
        ins->_srcKey = key;
        ins->_t = type;
        [unlimited setObject:ins forKey:key];
    }
    return ins;
}

-(NSString *)description
{
    if (_srcKey.length > 0) {
        return NSLocalizedString(_srcKey, nil);
    }else{
        return [super description];
    }
}
- (BOOL)isEqual:(id)other
{
    if (other == self) {
        return YES;
    } else if (![other isKindOfClass:self.class]) {
        return NO;
    } else {
        EEObject *ot = (EEObject*)other;
        return _t == ot->_t;
    }
}

@end

@implementation EETaiChi

-(NSString*)description
{
    return @"太极";
}

@end
