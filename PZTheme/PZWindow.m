//
//  PZWindow.m
//  PZThemeExample
//
//  Created by paul on 2020/3/30.
//  Copyright © 2020 paul. All rights reserved.
//

#import "PZWindow.h"
#import "PZTheme.h"

@implementation PZWindow

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    
    if (@available(iOS 13.0, *)) {
        PZThemeStyle theme = UITraitCollection.currentTraitCollection.userInterfaceStyle==UIUserInterfaceStyleLight?PZThemeStyle_Light:PZThemeStyle_Dark;
        if ([PZTheme sharedInstance].theme != theme) {
            [PZTheme sharedInstance].theme = theme;
        }
    }
}

@end
