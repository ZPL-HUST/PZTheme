//
//  PZTheme.h
//  Paulzhou
//
//  Created by paul on 2020/3/23.
//  Copyright © 2020 paul. All rights reserved.
//

#import <UIKit/UIKit.h>

#define PZ_THEME_CHANGE_NOTIFICATION    @"PZ_THEME_CHANGE_NOTIFICATION"

#define kThemePicker(light,dark)                ([PZTheme sharedInstance].theme==PZThemeStyle_Dark?dark:light)
#define kThemeObjectPicker(lightObj,darkObj)    ([PZTheme objectForLight:(lightObj) dark:(darkObj)])
#define kThemeColorPicker(lightColor,darkColor) ([PZTheme colorForLight:(lightColor) dark:(darkColor)])
#define kThemeImagePicker(imgName)              ([PZTheme imageNamed:imgName])

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, PZThemeStyle)
{
    PZThemeStyle_Light,
    PZThemeStyle_Dark,
};

@interface PZTheme : NSObject

@property (nonatomic,assign) PZThemeStyle theme;

+ (PZTheme *)sharedInstance;

+ (id)objectForLight:(id)light dark:(id)dark;

+ (UIColor *)colorForLight:(UIColor *)light dark:(UIColor *)dark;

+ (UIImage *)imageNamed:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
