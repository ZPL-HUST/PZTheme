//
//  PZTheme.m
//  Paulzhou
//
//  Created by paul on 2020/3/23.
//  Copyright © 2020 paul. All rights reserved.
//

#import "PZTheme.h"

@implementation PZTheme

+ (PZTheme *)sharedInstance
{
    static PZTheme *s_g_Instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_g_Instance = [[PZTheme alloc] init];
    });
    return s_g_Instance;
}

- (id)init {
    self = [super init];
    if(self) {
        if (@available(iOS 13.0, *)) {
            _theme = UITraitCollection.currentTraitCollection.userInterfaceStyle==UIUserInterfaceStyleLight?PZThemeStyle_Light:PZThemeStyle_Dark;
        } else {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            id obj = [userDefaults objectForKey:@"PZThemeValue"];
            if ([obj isKindOfClass:NSNumber.class]) {
                _theme = [obj intValue];
            } else {
                _theme = PZThemeStyle_Light;
            }
        }
    }
    return self;
}

- (void)setTheme:(PZThemeStyle)theme {
    _theme = theme;
    [[NSNotificationCenter defaultCenter] postNotificationName:PZ_THEME_CHANGE_NOTIFICATION object:nil];
    
    if (@available(iOS 13.0, *)) {
        
    } else {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:@(_theme) forKey:@"PZThemeValue"];
        [userDefaults synchronize];
    }
}

@end
