//
//  JumpView.h
//  PZThemeExample
//
//  Created by paul on 2020/3/30.
//  Copyright © 2020 paul. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JumpView : UIView

@property (nonatomic, strong) UINavigationController *nav;

- (void)setupSubviews;

@end

NS_ASSUME_NONNULL_END
