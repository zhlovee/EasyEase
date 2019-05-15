//
//  EETabbar.h
//  papaqi_ios
//
//  Created by lizhenghao on 2017/10/10.
//  Copyright © 2017年 iQIYI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EETabbar : UIView

- (instancetype)placeAtVC:(UIViewController *)viewCtrl;

@property (weak, nonatomic) IBOutlet UIButton *btnLeft;
@property (weak, nonatomic) IBOutlet UIButton *btnMid;
@property (weak, nonatomic) IBOutlet UIButton *btnRight;

@end
