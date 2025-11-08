//
//  UIView+Theme.h
//  NNThemeKit
//
//  Created by NeroXie on 2025/11/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NSString * ThemeUIActionIdentifier;

typedef void(^ThemeUIAction)(void);

@interface UIView (Theme)

- (void)theme_defaultUIAction:(ThemeUIAction)action;

- (void)theme_addUIActionWithIdentifier:(ThemeUIActionIdentifier)identifier action:(ThemeUIAction)action;

- (void)theme_removeUIActionWithIdentifier:(ThemeUIActionIdentifier)identifier;

- (void)theme_removeAllUIActions;

//- (NSMutableDictionary *)theme_UIActionMap;

@end

NS_ASSUME_NONNULL_END
