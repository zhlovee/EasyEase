//
//  EENavigationBar.m
//  papaqi_ios
//
//  Created by lizhenghao on 2017/10/12.
//  Copyright © 2017年 iQIYI. All rights reserved.
//

#import "EENavigationBar.h"

@interface EENavigationBar()
@end

@implementation EENavigationBar

-(void)awakeFromNib
{
    [super awakeFromNib];
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn addTarget:self action:@selector(handleNaviBack:) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.frame = CGRectMake(0, 0, 44, 44);
    [closeBtn setBackgroundColor:[UIColor clearColor]];
    [closeBtn setImage:[UIImage imageNamed:@"back_icon"] forState:UIControlStateNormal];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:closeBtn];
    self.backBtn = closeBtn;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0) {
//        closeBtn.translatesAutoresizingMaskIntoConstraints = NO;
//        closeBtn.contentEdgeInsets = UIEdgeInsetsMake(0, fixedSpace, 0, 0);
        self.barItem.leftBarButtonItem = backItem;
    } else
    {
        CGFloat fixedSpace = 0;
        if ([UIScreen mainScreen].bounds.size.width > 370) fixedSpace = -20;
        else fixedSpace = -16;
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        space.width = fixedSpace;
        self.barItem.leftBarButtonItems = @[space, backItem];
    }
    [self setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIColorFromRGB(0xffffff),NSForegroundColorAttributeName, nil]];
}

-(void)setBarTitle:(NSString *)barTitle
{
    self.barItem.title = barTitle;
}

-(NSString *)barTitle
{
    return self.barItem.title;
}

- (IBAction)handleNaviBack:(id)sender {
    [RootViewController.navigationController popViewControllerAnimated:YES];
}

- (void)replaceBackTarget:(id) target andSeletor:(SEL) seletor
{
    if (!target || NULL == seletor) {
        return;
    }
    NSSet *allTarget = [self.backBtn allTargets];
    for (id tg in allTarget) {
        [self.backBtn removeTarget:tg action:NULL forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self.backBtn addTarget:target action:seletor forControlEvents:UIControlEventTouchUpInside];
}

-(instancetype)placeAtVC:(UIViewController*)vc;
{
    UIView *wrap = [UIView new];
    [vc.view addSubview:wrap];
    [wrap addSubview:self];
    wrap.backgroundColor = UIColorFromRGB(0x212121);
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vc.mas_topLayoutGuide);
        make.left.equalTo(vc.view);
        make.right.equalTo(vc.view);
        make.height.equalTo(@44);
    }];
    
    [wrap mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vc.view.mas_top);
        make.left.equalTo(vc.view.mas_left);
        make.right.equalTo(vc.view.mas_right);
        make.bottom.equalTo(self);
    }];
    return self;
}

-(instancetype)setTransparentStyle
{
    [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.shadowImage = [UIImage new];////UIImageNamed:@"transparent.png"
//    self.navigationController.navigationBar.translucent = YES;
//    self.navigationController.view.backgroundColor = [UIColor clearColor];
    return self;
}

//-(instancetype)setBackBlueStyle
//{
//    self.translucent = NO;
//    self.barTintColor = AppTintColor;
//    [self setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:AppTitleColor,NSForegroundColorAttributeName, nil]];
//    CALayer *ly = [CALayer layer];
//    ly.frame = CGRectMake(0, 43, PPQScreenWidth, 1);
//    ly.backgroundColor = [UIColor whiteColor].CGColor;
//    ly.opacity = 0.05;
//    [self.layer addSublayer:ly];
//
//    return self;
//}

- (void)setNavAndStatusBarColor:(UIColor *)color
{
    UIView *wrapView = self.superview;
    if (wrapView)
    {
        [wrapView setBackgroundColor:color];
    }
}

@end
