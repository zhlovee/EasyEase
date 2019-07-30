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
    [self switchTabBarViewControllerToVC:_historyVC];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    方法一：
//    读取本机设置的语言列表，获取第一个语言，该方法读取的语言为：国际通用语言Code+国际通用国家地区代码，
//    所以实际上想获取语言还需将国家地区代码剔除
//    代码：
    
    
    
//    NSArray  *languageList =  [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] ;// 本机设置的语言列表
//    NSLog(@"languageList : %@", languageList);
//    NSString *languageCode = [languageList  firstObject];// 当前设置的首选语言
//    NSString *countryCode = [NSString stringWithFormat:@"-%@", [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode]];
//    NSLog(@"languageCode : %@",  [NSString stringWithFormat:@"%@%@",languageCode,countryCode]);
    
    
    

    NSString *languageCode = [NSLocale preferredLanguages][0];// 返回的也是国际通用语言Code+国际通用国家地区代码
    NSString *countryCode = [NSString stringWithFormat:@"-%@", [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode]];
    if (languageCode) {
        languageCode = [languageCode stringByReplacingOccurrencesOfString:countryCode withString:@""];
    }
    NSLog(@"languageCode : %@", languageCode);
    
//    日志：
//    2018-02-09 10:45:01.959781+0800 Demo[9528:2408422] languageCode : zh-Hans
//
//    方法三：
//    直接也最简单，但是在iOS11上有个Bug，即在iPhone->通用->语言与地区  添加了简体中文、English，并将中文设置默认语言的情况下，该函数返回的必定是英文。

//    NSString *languageCode = [NSLocale  currentLocale].languageCode;// 当前设置的首选语言

    
    
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
