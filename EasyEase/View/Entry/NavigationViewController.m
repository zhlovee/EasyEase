//
//  NavigationViewController.m
//  EasyEase
//
//  Created by lizhenghao on 2018/12/1.
//  Copyright © 2018 lizhenghao. All rights reserved.
//

#import "NavigationViewController.h"
#import "EERootViewController.h"

@interface NavigationViewController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@end

@implementation NavigationViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.navigationBarHidden = YES;
        [self pushViewController:RootViewController animated:NO];
        self.interactivePopGestureRecognizer.enabled = YES;
        self.interactivePopGestureRecognizer.delegate = self;
        
        self.delegate = self;
    }
    return self;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if(self.viewControllers.count > 1){
        return true;
    }
    return false;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated;
{
    if (!self.interactivePopGestureRecognizer.enabled) {
        self.interactivePopGestureRecognizer.enabled = YES;
    }
}

@end
