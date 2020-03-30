//
//  ViewController.m
//  PZThemeExample
//
//  Created by paul on 2020/3/26.
//  Copyright © 2020 paul. All rights reserved.
//

#import "ViewController.h"
#import "PZObject.h"
#import "PZTheme.h"
#import "JumpView.h"
#import "UIViewController+PZTheme.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton * btnNext;

@end

@implementation ViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"自动模式"
                                                           image:[UIImage imageNamed:@"btm_nav_home_default"]
                                                   selectedImage:[UIImage imageNamed:@"btm_nav_home_default"]];
        
        self.tabBarItem = item;
    }
    return self;
}

//- (UIStatusBarStyle)preferredStatusBarStyle {
//    return UIStatusBarStyleDefault;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"自动模式";
    [self setupNavButton];
    
    self.pz.theme = PZThemeStyle_Auto;
    //handleTheme方法可多次执行，执行时机为当切换主题时，发出PZ_THEME_CHANGE_NOTIFICATION通知即可触发。
    [self.pz handleTheme:^(UIViewController *vc) {
        vc.view.backgroundColor = THEME_PICKER(UIColor.whiteColor,UIColor.darkGrayColor,vc.pz.theme);
    }];

    //customize方法仅在初始化时执行一次，JumpView颜色模式支持自动/暗黑/明亮可配
    JumpView *jumpView = [[JumpView new].pz customize:^(JumpView *view) {
        view.frame = CGRectMake(124, 150, 127, 300);
        view.nav = self.navigationController;
        view.pz.theme = self.pz.theme;
        [view setupSubviews];//设置完颜色模式再添加子控件
    }];
    [self.view addSubview:jumpView];
    
    //        vc.navigationController.navigationBar.tintColor = kThemePicker([UIColor blackColor],[UIColor whiteColor]);
    //        vc.navigationController.navigationBar.barTintColor = kThemePicker([UIColor whiteColor],[UIColor blackColor]);
    //        vc.navigationController.navigationBar.barStyle = kThemePicker(UIBarStyleDefault,UIBarStyleBlack);
    //        [vc.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],
    //                                                                        NSForegroundColorAttributeName:kThemePicker(UIColor.blackColor, UIColor.whiteColor)}];
    
}

//添加切换主题开关，此开关可以在iOS13以上系统中隐藏，使用系统自身的开关控制主题。
- (void)setupNavButton{
    if (@available(iOS 13.0, *)) {
        return;
    }
    UISwitch *swcLeft = [[UISwitch new].pz customize:^(UISwitch *swc) {
        swc.on = [PZTheme sharedInstance].theme == PZThemeStyle_Dark;
        [swc addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
    }];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:swcLeft];
}

- (IBAction)switchChange:(UISwitch*)swc {
    [PZTheme sharedInstance].theme = swc.on?PZThemeStyle_Dark:PZThemeStyle_Light;
}

@end
