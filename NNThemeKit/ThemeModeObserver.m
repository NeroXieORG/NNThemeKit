//
//  ThemeModeObserver.m
//  NNThemeKit
//
//  Created by NeroXie on 2025/11/6.
//

#import "ThemeModeObserver.h"
#import "ThemeIMP.h"
#import "ThemeModel.h"
#import "UIView+Theme.h"

NSString * const ThemeModeChangedNotification = @"theme.modeChanged";

static NSString * const kThemeModeKey = @"ThemeMode";

API_AVAILABLE(ios(13.0))
@interface ThemeObserveWindow : UIWindow

@end

@interface ThemeModeObserver()

@property (nonatomic, strong) NSHashTable<UIView *> *viewHashTable;
@property (nonatomic, assign) ThemeMode currentMode;
@property (nonatomic, assign) UIUserInterfaceStyle currentUserInterfaceStyle;
@property (nonatomic, strong, nullable) UIWindow *themeObserveWindow;

@end

@implementation ThemeModeObserver

+ (instancetype)sharedInstance {
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [self new];
    });
    
    return _sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        _viewHashTable = [NSHashTable hashTableWithOptions:NSHashTableWeakMemory];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(_updateNewWindowUserInterfaceStyle:)
                                                     name:UIWindowDidBecomeVisibleNotification
                                                   object:nil];
    }
    return self;
}

- (void)setup {
    ThemeMode mode = ThemeModeLight;
    NSNumber *numberValue = [[NSUserDefaults standardUserDefaults] valueForKey:kThemeModeKey];
    if (numberValue) mode = [numberValue integerValue];
    [self changeThemeMode:mode];
}

- (BOOL)isDarkMode {
    switch (self.currentMode) {
        case ThemeModeLight:
            return NO;
        case ThemeModeDark:
            return YES;
        case ThemeModeSystem:
            return self.currentUserInterfaceStyle == UIUserInterfaceStyleDark;
    }
}

//- (UIStatusBarStyle)preferredStatusBarStyle {
//    switch (self.currentMode) {
//        case ThemeModeLight:
//            return UIStatusBarStyleDarkContent;
//        case ThemeModeDark:
//            return UIStatusBarStyleLightContent;
//        case ThemeModeSystem:
//        default:
//            return UIStatusBarStyleDefault;
//    }
//}

- (void)changeThemeMode:(ThemeMode)themeMode {
    NSLog(@"%s", __func__);
    // 不支持深色模式时只能支持为 Light Mode
    if (!ThemeIMP.sharedInstance.data.supportDarkMode && themeMode != ThemeModeLight) {
        themeMode = ThemeModeLight;
    }
    
    _currentMode = themeMode;
    
    [[NSUserDefaults standardUserDefaults] setInteger:themeMode forKey:kThemeModeKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    switch (themeMode) {
        case ThemeModeLight:
            [self _changeAllWindowsUserInterfaceStyle:UIUserInterfaceStyleLight];
            [self _changeCurrentUserInterfaceStyle:UIUserInterfaceStyleLight];
            break;
        case ThemeModeDark:
            [self _changeAllWindowsUserInterfaceStyle:UIUserInterfaceStyleDark];
            [self _changeCurrentUserInterfaceStyle:UIUserInterfaceStyleDark];
            break;
        case ThemeModeSystem:
            [self _changeAllWindowsUserInterfaceStyle:UIUserInterfaceStyleUnspecified];
            [self _changeCurrentUserInterfaceStyle:UITraitCollection.currentTraitCollection.userInterfaceStyle];
            break;
    }
}

- (void)cacheThemeUIActionsWithView:(UIView *)view {
    if (![self.viewHashTable containsObject:view]) {
        [self.viewHashTable addObject:view];
    }
}


#pragma mark - Private Method

- (void)_changeAllWindowsUserInterfaceStyle:(UIUserInterfaceStyle)userInterfaceStyle {
    NSLog(@"%s", __func__);
    for (UIWindow *window in UIApplication.sharedApplication.windows) {
        if (self.themeObserveWindow && window == self.themeObserveWindow) continue;
        window.overrideUserInterfaceStyle = userInterfaceStyle;
    }
}

- (void)_changeCurrentUserInterfaceStyle:(UIUserInterfaceStyle)style {
    NSLog(@"%s", __func__);
    
    _currentUserInterfaceStyle = style;
    
    [NSNotificationCenter.defaultCenter postNotificationName:ThemeModeChangedNotification object:nil];
    
    for (UIView *view in self.viewHashTable.allObjects) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        if (view && [view respondsToSelector:@selector(_theme_reloadUIActions)]) {
            [view performSelector:@selector(_theme_reloadUIActions)];
        }
#pragma clang diagnostic pop
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ThemeChangedSuccessNotification object:@(style)];
}

- (void)_updateNewWindowUserInterfaceStyle:(NSNotification *)notification {
    UIWindow *window = notification.object;
    if (![window isKindOfClass:[UIWindow class]]) return;
    
    if (window.traitCollection.userInterfaceStyle != self.currentUserInterfaceStyle) {
        window.overrideUserInterfaceStyle = self.currentUserInterfaceStyle;
    }
    
    if (UIApplication.sharedApplication.delegate.window == window) {
        self.themeObserveWindow = [[ThemeObserveWindow alloc] initWithFrame:CGRectZero];
        self.themeObserveWindow.windowLevel = UIWindowLevelNormal + 1;
        self.themeObserveWindow.overrideUserInterfaceStyle = UIUserInterfaceStyleUnspecified;
    }
}

@end

@implementation ThemeObserveWindow

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    if ([self.traitCollection hasDifferentColorAppearanceComparedToTraitCollection:previousTraitCollection]) {
        ThemeModeObserver *instance = ThemeModeObserver.sharedInstance;
        UIUserInterfaceStyle userInterfaceStyle = self.traitCollection.userInterfaceStyle;
        if (instance.currentMode == ThemeModeSystem && userInterfaceStyle != instance.currentUserInterfaceStyle) {
            [instance _changeCurrentUserInterfaceStyle:userInterfaceStyle];
        }
    }
}

@end
