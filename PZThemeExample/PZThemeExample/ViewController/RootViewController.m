//
//  RootViewController.m
//  PZThemeExample
//
//  Created by paul on 2020/3/30.
//  Copyright © 2020 paul. All rights reserved.
//

#import "RootViewController.h"
#import "PZObject.h"
#import "UIViewController+PZTheme.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (UIViewController *)viewControllerWithClass:(NSString *)classname
{
    return [[NSClassFromString(classname) alloc] init];
}

- (UINavigationController *)navigationControllerWithClass:(NSString *)classname
{
    return [[UINavigationController alloc] initWithRootViewController:[self viewControllerWithClass:classname]];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSArray *controllers = @[[self navigationControllerWithClass:@"ViewController"]
                                 ,[self navigationControllerWithClass:@"LightViewController"]
                                 ,[self navigationControllerWithClass:@"DarkViewController"]];
        self.viewControllers = controllers;
        
        [self initAppearance];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.pz handleTheme:^(UITabBarController *vc) {
        UINavigationController *nav=vc.selectedViewController;
        [nav.topViewController updateThemeNavigationBarStyle];
    }];
}

- (void)initAppearance {
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-500,0) forBarMetrics:UIBarMetricsDefault];
    
    // 定义TabBar样式
    [[UITabBar appearance] setTranslucent:NO];
    [[UITabBar appearance] setBarTintColor:UIColor.blackColor]; //TabBar 背景色
    [[UITabBar appearance] setTintColor:UIColor.redColor]; //TabBar 图片和文字选中颜色
    if (@available(iOS 10.0, *)) {
        [[UITabBar appearance] setUnselectedItemTintColor:UIColor.lightGrayColor]; //TabBar 图片和文字未选中颜色
    }
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} forState:UIControlStateNormal];
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
