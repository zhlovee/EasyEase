//
//  EERootViewController.m
//  EasyEase
//
//  Created by lizhenghao on 2018/12/1.
//  Copyright © 2018 lizhenghao. All rights reserved.
//

#import "EERootViewController.h"
#import "EETabbar.h"
#import "EEMineViewController.h"
#import "EEOmenViewController.h"
#import "EEHistoryViewController.h"

@interface EERootViewController ()

@property(nonatomic,strong) EEHistoryViewController *historyVC;
@property(nonatomic,strong) EEMineViewController *mineVC;
@property(nonatomic,strong) EEOmenViewController *omenVC;

@end

@implementation EERootViewController{
    EETabbar *_tab;
    UIViewController *_currentVC;
}

-(UIView *)tabbar
{
    return _tab;
}

+(instancetype)sharedVC
{
    static EERootViewController *sharedVC = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedVC = [[EERootViewController alloc]init];
    });
    return sharedVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _tab = [[EETabbar defaultNibView]placeAtVC:self];
    
    self.historyVC = [EEHistoryViewController new];
    self.mineVC = [EEMineViewController new];
    self.omenVC = [EEOmenViewController new];
    
    [_tab.btnLeft addTarget:self action:@selector(handleLeftTab:) forControlEvents:UIControlEventTouchUpInside];
    [_tab.btnMid addTarget:self action:@selector(handleMidTab:) forControlEvents:UIControlEventTouchUpInside];
    [_tab.btnRight addTarget:self action:@selector(handleRightTab:) forControlEvents:UIControlEventTouchUpInside];
    [self switchTabBarViewControllerToVC:_omenVC];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)switchTabBarViewControllerToVC:(UIViewController*)toVC
{
    if (_currentVC != toVC) {
        if (_currentVC) {
            [_currentVC.view removeFromSuperview];
            [_currentVC removeFromParentViewController];
        }
        
        [self addChildViewController:toVC];
        toVC.view.frame = self.view.bounds;
        [self.view insertSubview:toVC.view atIndex:0];
        [toVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        [toVC didMoveToParentViewController:self];
        _currentVC = toVC;
        [self setNeedsStatusBarAppearanceUpdate];
    }
}

-(void)handleLeftTab:(id)sd
{
    [self switchTabBarViewControllerToVC:_historyVC];
}
-(void)handleMidTab:(id)sd
{
    [self switchTabBarViewControllerToVC:_omenVC];
}
-(void)handleRightTab:(id)sd
{
    [self switchTabBarViewControllerToVC:_mineVC];
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
