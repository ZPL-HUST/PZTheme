//
//  UIViewController+PZTheme.m
//  PZThemeExample
//
//  Created by paul on 2020/4/2.
//  Copyright © 2020 paul. All rights reserved.
//

#import "UIViewController+PZTheme.h"
#import <objc/runtime.h>
#import "PZObject.h"

@implementation UIViewController (PZTheme)

+ (void)swizzleMethods:(Class)cls originalSelector:(SEL)origSelector swizzledSelector:(SEL)swizSelector
{
    Method origMethod = class_getInstanceMethod(cls, origSelector);
    Method swizMethod = class_getInstanceMethod(cls, swizSelector);
    
    BOOL didAddMethod = class_addMethod(cls, origSelector, method_getImplementation(swizMethod), method_getTypeEncoding(swizMethod));
    if (didAddMethod) {
        class_replaceMethod(cls, swizSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, swizMethod);
    }
}

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleMethods:self.class
                     originalSelector:NSSelectorFromString(@"viewWillAppear:")
                     swizzledSelector:@selector(sw_statusBar_viewWillAppear:)];
    });
}

- (void)sw_statusBar_viewWillAppear:(BOOL)animated {
    [self updateThemeNavigationBarStyle];
    [self sw_statusBar_viewWillAppear:animated];
}

- (void)updateThemeNavigationBarStyle {
    if (self.navigationController) {
        PZThemeStyle theme = ACTUAL_THEME(self.pz.theme);
        [self updateNavigationBarStyle:theme==PZThemeStyle_Dark];
    }
}

- (void)updateNavigationBarStyle:(BOOL)dark {
    if (dark) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;//文字白色
        [self.navigationController.navigationBar setTintColor:UIColor.whiteColor];
        [self.navigationController.navigationBar setBarTintColor:UIColor.blackColor];
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],
                                                               NSForegroundColorAttributeName:UIColor.whiteColor}];
    } else {
        if (@available(iOS 13.0, *)) {
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDarkContent;//文字是黑色
        } else {
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//文字黑色
        }
          
        [self.navigationController.navigationBar setTintColor:UIColor.blackColor];
        [self.navigationController.navigationBar setBarTintColor:UIColor.whiteColor];
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],
                                                               NSForegroundColorAttributeName:UIColor.blackColor}];
    }
}


@end
