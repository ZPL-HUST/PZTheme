//
//  JumpView.m
//  PZThemeExample
//
//  Created by paul on 2020/3/30.
//  Copyright © 2020 paul. All rights reserved.
//

#import "JumpView.h"
#import "PZObject.h"
#import "PZTheme.h"

@implementation JumpView

-(instancetype)init {
    self = [super init];
    if (self) {

    }
    return self;
}

- (IBAction)jumpNext:(UIButton*)btn {
    NSArray *arr = @[@"ViewController",@"LightViewController",@"DarkViewController"];
    UIViewController *vc = [NSClassFromString(arr[btn.tag]) new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.nav pushViewController:vc animated:YES];
}

- (void)setupSubviews {
    CGFloat top = 0;
    NSArray *arr = @[@"自动模式",@"明亮模式",@"暗黑模式"];
    
    PZThemeStyle theme = self.pz.theme;
    for (NSInteger i =0; i<3; i++) {
        UIButton *btn = [[UIButton new].pz customize:^(UIButton *button) {
            button.tag = i;
            button.frame = CGRectMake(0, top, 127, 53);
            button.titleLabel.font = [UIFont systemFontOfSize:20];
            [button setTitle:arr[i] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(jumpNext:) forControlEvents:UIControlEventTouchUpInside];
        }];
        [self addSubview:btn];
        
        [btn.pz handleTheme:^(UIButton *btn) {
            [btn setBackgroundImage:THEME_PICKER([UIImage imageNamed:@"bg"],[UIImage imageNamed:@"bg_dark"],theme) forState:UIControlStateNormal];
            [btn setTitleColor:THEME_PICKER([UIColor blackColor],[UIColor whiteColor],theme) forState:UIControlStateNormal];
        }];
        
        top+=100;
    }
}

@end
