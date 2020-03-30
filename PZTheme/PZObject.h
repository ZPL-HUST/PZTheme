//
//  PZObject.h
//  Paulzhou
//
//  Created by paul on 2019/5/23.
//  Copyright © 2019 paul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PZTheme.h"

@interface PZObject<__contravariant T> : NSObject

@property (nonatomic, assign) PZThemeStyle theme;

@property (nonatomic, weak) T element;

@property (nonatomic, copy) void(^handleThemeBlock)(T x);

- (instancetype)initWithElement:(T)object;

- (T)customize:(void(^)(T x))block;

- (void)handleTheme:(void(^)(T x))block;

@end


//////////////////////////////////
@interface NSObject (PZObject)

- (PZObject *)pz;

@end

