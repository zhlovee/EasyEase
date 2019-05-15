//
//  EETabbar.m
//  papaqi_ios
//
//  Created by lizhenghao on 2017/10/10.
//  Copyright © 2017年 iQIYI. All rights reserved.
//

#import "EETabbar.h"

@interface EETabbar()
@end

@implementation EETabbar

-(void)awakeFromNib
{
    [super awakeFromNib];
    
}

-(instancetype)placeAtVC:(UIViewController *)viewCtrl
{
    UIView *wrap = [UIView new];
    [viewCtrl.view addSubview:wrap];
    [wrap addSubview:self];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewCtrl.view);
        make.right.equalTo(viewCtrl.view);
        make.bottom.equalTo(viewCtrl.mas_bottomLayoutGuide);
        make.height.equalTo(@49);
    }];
    
    wrap.backgroundColor = UIColorFromRGB(0x212121);
    [wrap mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewCtrl.view);
        make.right.equalTo(viewCtrl.view);
        make.bottom.equalTo(viewCtrl.view);
        make.top.equalTo(self);
    }];
    
    return self;
}

@end
