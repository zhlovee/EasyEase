//
//  EERootViewController.h
//  EasyEase
//
//  Created by lizhenghao on 2018/12/1.
//  Copyright © 2018 lizhenghao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define RootViewController [EERootViewController sharedVC]

@interface EERootViewController : UIViewController

+ (instancetype)sharedVC;
@property(readonly)UIView *tabbar;

@end

NS_ASSUME_NONNULL_END
