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
        _theme = PZThemeStyle_Light;//可以做本地存储
    }
    return self;
}

- (void)setTheme:(PZThemeStyle)theme {
    _theme = theme;
    if (@available(iOS 13.0, *)) {
        
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:PZ_THEME_CHANGE_NOTIFICATION object:nil];
    }
}

+ (id)objectForLight:(id)light dark:(id)dark {
    if (@available(iOS 13.0, *)) {
        return UITraitCollection.currentTraitCollection.userInterfaceStyle==UIUserInterfaceStyleLight?light:dark;
    }
    return kThemePicker(light,dark);
}

+(UIColor *)colorForLight:(UIColor *)light dark:(UIColor *)dark {
    if (@available(iOS 13.0, *)) {
        return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trainCollection) {
            return trainCollection.userInterfaceStyle==UIUserInterfaceStyleLight?light:dark;
        }];
    }
    return kThemePicker(light,dark);
}

+(UIImage *)imageNamed:(NSString *)name {
    if (@available(iOS 13.0, *)) {
        return [UIImage imageNamed:name];
    }
    UIImage *light = [UIImage imageNamed:name];
    UIImage *dark = [UIImage imageNamed:[NSString stringWithFormat:@"%@_dark",name]];
    return kThemePicker(light,dark);
}

@end
