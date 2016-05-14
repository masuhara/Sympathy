//
//  Sympathy.h
//  Sympathy
//
//  Created by Masuhara on 2016/05/14.
//  Copyright © 2016年 net.maushara. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface Sympathy : NSObject

+ (instancetype)sharedPlugin;

@property (nonatomic, strong, readonly) NSBundle* bundle;
@end