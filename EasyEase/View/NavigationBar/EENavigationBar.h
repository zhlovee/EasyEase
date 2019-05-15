//
//  EENavigationBar.h
//  papaqi_ios
//
//  Created by lizhenghao on 2017/10/12.
//  Copyright © 2017年 iQIYI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EENavigationBar : UINavigationBar

@property (weak, nonatomic) IBOutlet UINavigationItem *barItem;
@property(nonatomic, weak)UIButton* backBtn;

@property(nonatomic,readwrite)NSString *barTitle;

//设置透明背景样式
-(instancetype)setTransparentStyle;
//蓝黑色背景养生
//-(instancetype)setBackBlueStyle;
-(instancetype)placeAtVC:(UIViewController*)vc;

- (void)setNavAndStatusBarColor:(UIColor *)color;
/** 替换默认的导航返回响应事件 */
- (void)replaceBackTarget:(id) target andSeletor:(SEL) seletor;
@end
