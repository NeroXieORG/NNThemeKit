//
//  Theme.h
//  NNThemeKit
//
//  Created by NeroXie on 2025/11/6.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ThemeRuleDelegate.h"
#import "ThemeModel.h"

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString * const ThemeReloadThemeColorsNotification;
FOUNDATION_EXPORT NSString * const ThemeChangedSuccessNotification;

typedef enum : NSUInteger {
    ThemeModeLight = 0,
    ThemeModeDark = 1,
    ThemeModeSystem = 2,
} ThemeMode;

@interface Theme : NSObject

#pragma mark - 使用

+ (void)setup;

+ (void)setupWithDelegate:(id<ThemeRuleDelegate>)delegate;

#pragma mark - 颜色定义
/**
 关于字体颜色的说明：
 NNThemeKit 的字体颜色是通过 Theme.M1.A1 这样的方式生成的，它的流程如下：
 1. 确定字体所在的图层的背景是是否为深色，根据是否背景为深色获取对应的字体基础色
 2. 通过字体基础色添加 alpha 通道获取到真正的渲染颜色
 
 使用如下：
 UIView *view = UIView.new;
 view.backgroundColor = Theme.BG2;
 
 UILabel *label = UILabel.new;
 label.textColor = Theme.BG2.A2;
 [view addSubview:label];
 */
/// Light 模式的下的基础颜色
+ (UIColor *)textBasicColorUnderLight;
/// Dark 模式的下的基础颜色
+ (UIColor *)textBasicColorUnderDark;
/**
 关于参照色的说明，在确定某个颜色是否为深色时，默认使用了参照色与某个颜色做对比，通过对比值判断是否为深色
 普通文本的视觉呈现与背景至少要有 4.5:1 的对比度 确保绝大范围视力程度的人群都易于阅读
 举例：1.某个颜色和黑色对比，颜色对比度小于4.5，那该颜色在黑色环境下就是深色
      2.某个颜色和白色对比，颜色对比度大于4.5，那该颜色在白色环境下就是深色
 */
/// Light 模式的下的参照色
+ (UIColor *)contrastingColorUnderLight;
/// Dark 模式的下的参照色
+ (UIColor *)contrastingColorUnderDark;

+ (UIColor *)M1;
+ (UIColor *)M2;
+ (UIColor *)M3;
+ (UIColor *)M4;
+ (UIColor *)M5;
+ (UIColor *)BG1;
+ (UIColor *)BG2;
+ (UIColor *)BG3;
+ (UIColor *)BG4;
+ (UIColor *)BG5;

#pragma mark - Alpha 定义

+ (CGFloat)A1;
+ (CGFloat)A2;
+ (CGFloat)A3;
+ (CGFloat)A4;
+ (CGFloat)A5;
+ (CGFloat)A6;
+ (CGFloat)A7;
+ (CGFloat)A8;
+ (CGFloat)A9;
+ (CGFloat)A10;

#pragma mark - 字体尺寸定义

+ (ThemeTextSize *)T1;
+ (ThemeTextSize *)T2;
+ (ThemeTextSize *)T3;
+ (ThemeTextSize *)T4;
+ (ThemeTextSize *)T5;
+ (ThemeTextSize *)T6;
+ (ThemeTextSize *)T7;
+ (ThemeTextSize *)T8;
+ (ThemeTextSize *)T9;
+ (ThemeTextSize *)T10;

#pragma mark - 边距定义

+ (CGFloat)P1;
+ (CGFloat)P2;
+ (CGFloat)P3;
+ (CGFloat)P4;
+ (CGFloat)P5;
+ (CGFloat)P6;
+ (CGFloat)P7;
+ (CGFloat)P8;
+ (CGFloat)P9;
+ (CGFloat)P10;

#pragma mark - Iconfont 尺寸定义

+ (CGFloat)IC1;
+ (CGFloat)IC2;
+ (CGFloat)IC3;
+ (CGFloat)IC4;
+ (CGFloat)IC5;
+ (CGFloat)IC6;
+ (CGFloat)IC7;
+ (CGFloat)IC8;
+ (CGFloat)IC9;
+ (CGFloat)IC10;

#pragma mark - 圆角定义
+ (CGFloat)C1;
+ (CGFloat)C1_1;
+ (CGFloat)C1_2;
+ (CGFloat)C1_3;
+ (CGFloat)C2;
+ (CGFloat)C2_1;
+ (CGFloat)C2_2;
+ (CGFloat)C2_3;
+ (CGFloat)C3;
+ (CGFloat)C3_1;
+ (CGFloat)C3_2;
+ (CGFloat)C3_3;

#pragma mark - 图片尺寸定义

+ (CGFloat)I1;
+ (CGFloat)I2;
+ (CGFloat)I3;
+ (CGFloat)I4;
+ (CGFloat)I5;
+ (CGFloat)I6;
+ (CGFloat)I7;
+ (CGFloat)I8;
+ (CGFloat)I9;
+ (CGFloat)I10;

#pragma mark - 其他

+ (UIColor *)disableColorFromColor:(UIColor *)originalColor;

+ (UIColor *)highLightedColorFromColor:(UIColor *)originalColor;

+ (BOOL)checkIsDarkColor:(UIColor *)color;

/// 修改 Theme 模式
/// - Parameter themeMode: 新的 Theme 模式
+ (void)changeThemeMode:(ThemeMode)themeMode;

/// 是否是暗黑模式
+ (BOOL)isDarkMode;

//+ (UIStatusBarStyle)preferredStatusBarStyle;

+ (UIUserInterfaceStyle)currentUserInterfaceStyle API_AVAILABLE(ios(12.0));

@end

NS_ASSUME_NONNULL_END
