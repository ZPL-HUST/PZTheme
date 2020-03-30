//
//  DarkViewController.m
//  PZThemeExample
//
//  Created by paul on 2020/3/30.
//  Copyright © 2020 paul. All rights reserved.
//

#import "DarkViewController.h"
#import "PZObject.h"
#import "PZTheme.h"
#import "JumpView.h"

@interface DarkViewController ()

@end

@implementation DarkViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"暗黑模式"
                                                           image:[UIImage imageNamed:@"btm_nav_transaction_default"]
                                                   selectedImage:[UIImage imageNamed:@"btm_nav_transaction_default"]];
        
        self.tabBarItem = item;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"暗黑模式";
    self.pz.theme = PZThemeStyle_Dark;
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
