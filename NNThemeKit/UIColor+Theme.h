//
//  UIColor+Theme.h
//  NNThemeKit
//
//  Created by NeroXie on 2025/11/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Theme)

- (UIColor *)A1;
- (UIColor *)A2;
- (UIColor *)A3;
- (UIColor *)A4;
- (UIColor *)A5;
- (UIColor *)A6;
- (UIColor *)A7;
- (UIColor *)A8;
- (UIColor *)A9;
- (UIColor *)A10;

- (UIColor *)theme_disabledColor;

- (UIColor *)theme_highLightedColor;

- (BOOL)theme_isDarkColor;

- (UIImage * _Nullable)theme_image;

/// 把带透明度的颜色转换为等效的不透明 RGB 颜色
- (UIColor *)theme_RGBColor;

- (UIColor *)theme_colorWithOpacity:(CGFloat)opacity;

- (UIColor *)theme_colorWithForegroundColor:(UIColor *)foregroundColor;

+ (UIColor *)theme_colorWithHexString:(NSString *)hexString;

+ (UIColor *)theme_colorWithDynamicProvider:(UIColor * (^)(UITraitCollection *traitCollection))dynamicProvider;

@end

NS_ASSUME_NONNULL_END
