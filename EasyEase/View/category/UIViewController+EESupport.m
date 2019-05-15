//
//  UIViewController+EESupport.m
//  EasyEase
//
//  Created by lizhenghao on 2019/1/30.
//  Copyright © 2019 lizhenghao. All rights reserved.
//

#import "UIViewController+EESupport.h"

@implementation UIViewController (EESupport)

-(UIStatusBarStyle)preferredStatusBarStyle
{
    //default statusbar style
    return UIStatusBarStyleLightContent;
}
-(BOOL)prefersStatusBarHidden
{
    //default show status bar
    return NO;
}

@end
