//
//  BaseWindow.m
//  Sympathy
//
//  Created by Masuhara on 2016/05/15.
//  Copyright © 2016年 net.maushara. All rights reserved.
//

#import "BaseWindow.h"

@implementation BaseWindow

- (id)initWithFrame:(NSRect)contentRect {
    self = [super initWithContentRect:contentRect styleMask:NSTitledWindowMask|NSResizableWindowMask|NSMiniaturizableWindowMask|NSClosableWindowMask backing:NSBackingStoreBuffered defer:NO];
    if (self) {
        self.title = @"Timer";
        self.opaque = NO;
        self.movableByWindowBackground = YES;
        self.backgroundColor = [NSColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        [self makeKeyAndOrderFront:nil];
        [self center];
    }
    
    return self;
}

@end
