//
//  UIViewController+PZTheme.h
//  PZThemeExample
//
//  Created by paul on 2020/4/2.
//  Copyright © 2020 paul. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (PZTheme)

- (void)updateThemeNavigationBarStyle;

- (void)updateNavigationBarStyle:(BOOL)dark;

@end

NS_ASSUME_NONNULL_END
