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

@interface ViewController ()

@property (nonatomic, strong) UIButton * btnNext;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //添加切换主题开关，此开关可以在iOS13以上系统中隐藏，使用系统自身的开关控制主题，此处为了便于测试未做隐藏。
    [self setupNavButton];
    
    //handleTheme方法
    //在iOS13以上系统中只会执行一次，通过苹果自身的UIColor和UIImage来支持样式切换，系统不支持自动切换的需要在traitCollectionDidChange收到切换
    //在iOS13以下系统中可多次执行，执行时机为当切换主题时，发出PZ_THEME_CHANGE_NOTIFICATION通知即可触发。
    [self.pz handleTheme:^(UIViewController *vc) {
        vc.title = kThemePicker(@"明亮模式",@"暗黑模式");
        vc.view.backgroundColor = kThemeColorPicker([UIColor whiteColor],[UIColor grayColor]);
        
        vc.navigationController.navigationBar.tintColor = kThemeColorPicker([UIColor blackColor],[UIColor whiteColor]);
        vc.navigationController.navigationBar.barTintColor = kThemeColorPicker([UIColor whiteColor],[UIColor blackColor]);
        vc.navigationController.navigationBar.barStyle = kThemePicker(UIBarStyleDefault,UIBarStyleBlack);
        [vc.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],
                                                                        NSForegroundColorAttributeName:kThemeColorPicker(UIColor.blackColor, UIColor.whiteColor)}];
    }];
    
    _btnNext = [[UIButton new].pz customize:^(UIButton *btn) {
        btn.frame = CGRectMake(100, 200, 127, 53);
        btn.titleLabel.font = [UIFont systemFontOfSize:20];
        [btn addTarget:self action:@selector(jumpNext:) forControlEvents:UIControlEventTouchUpInside];
    }];
    [self.view addSubview:_btnNext];
    
    [_btnNext.pz handleTheme:^(UIButton *btn) {
        [btn setBackgroundImage:kThemeImagePicker(@"bg") forState:UIControlStateNormal];
        [btn setTitle:kThemeObjectPicker(@"明亮模式",@"暗黑模式") forState:UIControlStateNormal];
        [btn setTitleColor:kThemeColorPicker([UIColor blackColor],[UIColor whiteColor]) forState:UIControlStateNormal];
    }];
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    if (@available(iOS 13.0, *)) {
        if ([self.traitCollection hasDifferentColorAppearanceComparedToTraitCollection:previousTraitCollection]) {
            self.title = kThemeObjectPicker(@"明亮模式",@"暗黑模式");
            [_btnNext setTitle:kThemeObjectPicker(@"明亮模式",@"暗黑模式") forState:UIControlStateNormal];
        }
    }
}

- (void)setupNavButton{
    UISwitch *swcLeft = [[UISwitch new].pz customize:^(UISwitch *swc) {
        swc.on = [PZTheme sharedInstance].theme == PZThemeStyle_Dark;
        [swc addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
    }];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:swcLeft];
}

- (IBAction)switchChange:(UISwitch*)swc {
    [PZTheme sharedInstance].theme = swc.on?PZThemeStyle_Dark:PZThemeStyle_Light;
}

- (IBAction)jumpNext:(UIButton*)btn {
    ViewController *vc = [ViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
