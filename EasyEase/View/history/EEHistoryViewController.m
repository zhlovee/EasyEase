//
//  EEHistoryViewController.m
//  EasyEase
//
//  Created by lizhenghao on 2019/1/29.
//  Copyright © 2019 lizhenghao. All rights reserved.
//

#import "EEHistoryViewController.h"
#import "EENavigationBar.h"

@interface EEHistoryViewController ()

@end

@implementation EEHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    EENavigationBar *bar = [[[EENavigationBar defaultNibView] setTransparentStyle] placeAtVC:self];
    bar.barItem.title = @"LIST";
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
