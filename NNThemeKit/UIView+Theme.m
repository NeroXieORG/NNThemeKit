//
//  UIView+Theme.m
//  NNThemeKit
//
//  Created by NeroXie on 2025/11/7.
//

#import "UIView+Theme.h"
#import <objc/runtime.h>
#import "ThemeModeObserver.h"

@implementation UIView (Theme)

- (void)theme_defaultUIAction:(ThemeUIAction)action {
    [self theme_addUIActionWithIdentifier:@"default_theme_ui_action" action:action];
}

- (void)theme_addUIActionWithIdentifier:(ThemeUIActionIdentifier)identifier action:(ThemeUIAction)action {
    if (!action) return;
    
    if (@available(iOS 13.0, *)) {
        [self.theme_UIActionMap setValue:action forKey:identifier];
        [ThemeModeObserver.sharedInstance cacheThemeUIActionsWithView:self];
    }
    
    action();
}

- (void)theme_removeUIActionWithIdentifier:(ThemeUIActionIdentifier)identifier {
    if (@available(iOS 13.0, *)) {
        [self.theme_UIActionMap removeObjectForKey:identifier];
    }
}

- (void)theme_removeAllUIActions {
    if (@available(iOS 13.0, *)) {
        [self.theme_UIActionMap removeAllObjects];
    }
}

- (NSMutableDictionary<NSString *, ThemeUIAction> *)theme_UIActionMap {
    NSMutableDictionary *map = objc_getAssociatedObject(self, _cmd);
    if (!map) {
        map = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, _cmd, map, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return map;
}

// ThemeModeObserver 通过 respondsToSelector 调用
- (void)_theme_reloadUIActions {
    for (ThemeUIAction action in self.theme_UIActionMap.allValues) {
        action();
    }
}

@end
