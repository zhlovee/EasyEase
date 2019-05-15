//
//  UIView+EEUIKit.m
//  EasyEase
//
//  Created by lizhenghao on 2019/1/23.
//  Copyright © 2019 lizhenghao. All rights reserved.
//

#import "UIView+EEUIKit.h"

@implementation UIView (EEUIKit)

+(instancetype)defaultNibView;
{
    NSArray *ary = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:self options:nil];
    if (ary.count > 0) {
        return ary[0];
    }else{
        return nil;
    }
}

@end
