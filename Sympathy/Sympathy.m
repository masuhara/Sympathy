//
//  Sympathy.m
//  Sympathy
//
//  Created by Masuhara on 2016/05/14.
//  Copyright © 2016年 net.maushara. All rights reserved.
//

#import "Sympathy.h"
#import "BaseWindow.h"

static Sympathy *sharedPlugin;

@implementation Sympathy {
    BaseWindow *timerWindow;
    NSTextView *textView;
    NSTimer *timer;
    float time;
}

#pragma mark - Initialization

+ (void)pluginDidLoad:(NSBundle *)plugin {
    NSArray *allowedLoaders = [plugin objectForInfoDictionaryKey:@"me.delisa.XcodePluginBase.AllowedLoaders"];
    if ([allowedLoaders containsObject:[[NSBundle mainBundle] bundleIdentifier]]) {
        sharedPlugin = [[self alloc] initWithBundle:plugin];
    }
}

+ (instancetype)sharedPlugin {
    return sharedPlugin;
}

- (id)initWithBundle:(NSBundle *)bundle {
    if (self = [super init]) {
        // reference to plugin's bundle, for resource access
        _bundle = bundle;
        // NSApp may be nil if the plugin is loaded from the xcodebuild command line tool
        if (NSApp && !NSApp.mainMenu) {
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(applicationDidFinishLaunching:)
                                                         name:NSApplicationDidFinishLaunchingNotification
                                                       object:nil];
        } else {
            [self initializeAndLog];
        }
    }
    return self;
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSApplicationDidFinishLaunchingNotification object:nil];
    [self initializeAndLog];
}

- (void)initializeAndLog {
    NSString *name = [self.bundle objectForInfoDictionaryKey:@"CFBundleName"];
    NSString *version = [self.bundle objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString *status = [self initialize] ? @"loaded successfully" : @"failed to load";
    NSLog(@"🔌 Plugin %@ %@ %@", name, version, status);
}

#pragma mark - Lifecycle


#pragma mark - Implementation

- (BOOL)initialize {
    // Create menu items, initialize UI, etc.
    // Sample Menu Item:
    NSMenuItem *menuItem = [[NSApp mainMenu] itemWithTitle:@"File"];
    if (menuItem) {
        [[menuItem submenu] addItem:[NSMenuItem separatorItem]];
        NSMenuItem *actionMenuItem = [[NSMenuItem alloc] initWithTitle:@"Start Sympathy" action:@selector(doMenuAction) keyEquivalent:@"s"];
        // Set keys to press same time
        // [actionMenuItem setKeyEquivalentModifierMask:NSAlphaShiftKeyMask | NSControlKeyMask];
        [actionMenuItem setKeyEquivalentModifierMask:NSControlKeyMask];
        [actionMenuItem setTarget:self];
        [[menuItem submenu] addItem:actionMenuItem];
        return YES;
    } else {
        return NO;
    }
}

// Sample Action, for menu item:
- (void)doMenuAction {
    if (!timer) {
        timer = [NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(updateTimer:) userInfo:nil repeats:YES];
        [timer fire];
    }
    
    if (!timerWindow) {
        timerWindow = [[BaseWindow alloc] initWithFrame:NSMakeRect(0, 0, 240, 80)];
        
        if (!textView) {
            textView = [[NSTextView alloc] initWithFrame:NSMakeRect(0, 0, 200, 60)];
            [timerWindow.contentView addSubview:textView];
        }
        
        NSWindowController *timerWindowController = [[NSWindowController alloc] initWithWindow:timerWindow];
        [timerWindowController showWindow:nil];
    }
}

- (void)updateTimer:(NSTimer *)timer {
    time = time + 0.01;
    [textView setString:[NSString stringWithFormat:@"%.2f", time]];
}

@end
