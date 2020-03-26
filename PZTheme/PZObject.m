//
//  PZObject.m
//  Paulzhou
//
//  Created by paul on 2019/5/23.
//  Copyright © 2019 paul. All rights reserved.
//

#import "PZObject.h"
#import "PZTheme.h"
#import <objc/runtime.h>

@implementation PZObject

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithElement:(id)object {
    self = [super init];
    if (self) {
        _element = object;
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    PZObject *copy = [[[self class] allocWithZone:zone] initWithElement:self.element];
    copy.handleThemeBlock = self.handleThemeBlock;
    return copy;
}

- (id)customize:(void(^)(id x))block {
    block(self.element);
    return self.element;
}

- (void)handleTheme:(void (^)(id))block {
    _handleThemeBlock = block;
    _handleThemeBlock(self.element);
 
    __weak typeof(self) weakSelf = self;
    [[NSNotificationCenter defaultCenter] addObserverForName:PZ_THEME_CHANGE_NOTIFICATION
                                                      object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
                                                          if (weakSelf.handleThemeBlock) {
                                                              weakSelf.handleThemeBlock(weakSelf.element);
                                                          }
                                                      }];
}

@end


//////////////////////////////////////////
@implementation NSObject (PZObject)

- (PZObject *)pz {
    PZObject *obj = objc_getAssociatedObject(self, @selector(pz));
    if (!obj) {
        obj = [[PZObject alloc] initWithElement:self];
        objc_setAssociatedObject(self, @selector(pz), obj, OBJC_ASSOCIATION_COPY_NONATOMIC);
        obj = objc_getAssociatedObject(self, @selector(pz));
    }
    return obj;
}

@end
