//
//  ThemeModeObserver.h
//  NNThemeKit
//
//  Created by NeroXie on 2025/11/6.
//

#import <Foundation/Foundation.h>
#import "Theme.h"

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString * const ThemeModeChangedNotification;

API_AVAILABLE(ios(13.0))
@interface ThemeModeObserver : NSObject

@property (nonatomic, assign, readonly) ThemeMode currentMode;

@property (nonatomic, assign, readonly) BOOL isDarkMode;

+ (instancetype)sharedInstance;

- (void)setup;

- (UIUserInterfaceStyle)currentUserInterfaceStyle;

- (void)changeThemeMode:(ThemeMode)themeMode;

- (void)cacheThemeUIActionsWithView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
