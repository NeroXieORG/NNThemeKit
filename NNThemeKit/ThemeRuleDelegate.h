//
//  ThemeRuleImpl.h
//  NNThemeKit
//
//  Created by NeroXie on 2025/11/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ThemeRuleDelegate <NSObject>

@optional

/// 获取 theme 的配置数据，默认在主工程中的 theme_config.json 中，可参考
- (NSData *)getThemeData;

/// 原始颜色不可用状态下的颜色，默认为 0.2
/// - Parameter originalColor: 原始颜色
- (UIColor *)disableColorFromColor:(UIColor *)originalColor;

/// 原始颜色高亮状态下的字体颜色
/// - Parameter originalColor: 原始颜色
- (UIColor *)highLightedColorFromColor:(UIColor *)originalColor;

/// 校验某个颜色是否为深色
/// - Parameter color: 指定颜色
- (BOOL)checkIsDarkColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
