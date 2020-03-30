//
//  LightViewController.m
//  PZThemeExample
//
//  Created by paul on 2020/3/30.
//  Copyright © 2020 paul. All rights reserved.
//

#import "LightViewController.h"
#import "PZObject.h"
#import "PZTheme.h"
#import "JumpView.h"

@interface LightViewController ()

@end

@implementation LightViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"明亮模式"
                                                           image:[UIImage imageNamed:@"btm_nav_market_default"]
                                                   selectedImage:[UIImage imageNamed:@"btm_nav_market_default"]];
        self.tabBarItem = item;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"明亮模式";
    self.pz.theme = PZThemeStyle_Light;
    self.view.backgroundColor = THEME_PICKER(UIColor.whiteColor,UIColor.darkGrayColor,self.pz.theme);
    
    JumpView *jumpView = [[JumpView new].pz customize:^(JumpView *view) {
        view.frame = CGRectMake(124, 150, 127, 300);
        view.nav = self.navigationController;
        view.pz.theme = self.pz.theme;
        [view setupSubviews];
    }];
    [self.view addSubview:jumpView];
}

@end
