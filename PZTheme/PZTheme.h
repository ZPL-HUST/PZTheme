//
//  PZTheme.h
//  Paulzhou
//
//  Created by paul on 2020/3/23.
//  Copyright © 2020 paul. All rights reserved.
//

#import <UIKit/UIKit.h>

#define PZ_THEME_CHANGE_NOTIFICATION    @"PZ_THEME_CHANGE_NOTIFICATION"

#define ACTUAL_THEME(themeStyle)                (themeStyle==PZThemeStyle_Auto?[PZTheme sharedInstance].theme:themeStyle)

#define THEME_PICKER(light,dark,theme)          (ACTUAL_THEME(theme)==PZThemeStyle_Dark?dark:light)

typedef NS_ENUM(NSInteger, PZThemeStyle)
{
    PZThemeStyle_Auto = 0, //自动模式，仅用于设置单个VC，不用于设置全局
    PZThemeStyle_Light,
    PZThemeStyle_Dark,
};

@interface PZTheme : NSObject

@property (nonatomic,assign) PZThemeStyle theme;

+ (PZTheme *)sharedInstance;

@end
