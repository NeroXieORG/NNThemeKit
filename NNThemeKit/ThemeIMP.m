//
//  ThemeIMP.m
//  NNThemeKit
//
//  Created by NeroXie on 2025/11/6.
//

#import "ThemeIMP.h"
#import "ThemeModel.h"
#import "UIColor+Theme.h"
#import "ThemeModeObserver.h"
#import "ThemeRuleDelegate.h"

// 相对亮度计算方法 L = 0.2126 * R + 0.7152 * G + 0.0722 * B
NS_INLINE CGFloat color_relative_brightness(UIColor *color) {
    // 对于每个颜色的红（R）、绿（G）和蓝（B）通道，首先将它们的值（范围为 0 到 255）转换为线性 RGB 值：
    // 如果通道值 ≤ 0.03928，线性值 = 通道值 / 12.92
    // 如果通道值 > 0.03928，线性值 = ((通道值 + 0.055) / 1.055) ^ 2.4
    CGFloat RsRGB = 0, GsRGB = 0, BsRGB = 0, a = 0;
    [color getRed:&RsRGB green:&GsRGB blue:&BsRGB alpha:&a];
    
    CGFloat R = RsRGB <= 0.03928 ? RsRGB / 12.92 : pow((RsRGB + 0.055) / 1.055, 2.4);
    CGFloat G = GsRGB <= 0.03928 ? GsRGB / 12.92 : pow((GsRGB + 0.055) / 1.055, 2.4);
    CGFloat B = BsRGB <= 0.03928 ? BsRGB / 12.92 : pow((BsRGB + 0.055) / 1.055, 2.4);
    CGFloat L = 0.2126 * R + 0.7152 * G + 0.0722 * B;
    
    return L;
}

// Get the contrast of two colors.
// https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html
// 对比度计算方法 contrast = （L1 + 0.05）/（L2 + 0.05）其中：L指颜色的相对亮度，L1是相对亮度大的颜色，L2是相对亮度小的颜色
NS_INLINE CGFloat color_contrast(UIColor *color1, UIColor *color2) {
    // color 可以能是 RGBA，需要转化为 RGB
    CGFloat L1 = color_relative_brightness(color1.theme_RGBColor);
    CGFloat L2 = color_relative_brightness(color2.theme_RGBColor);
    CGFloat C = L1 > L2 ? (L1 + 0.05) / (L2 + 0.05) : (L2 + 0.05) / (L1 + 0.05);
    return C;
}

@interface ThemeIMP() <ThemeRuleDelegate>

@property (nonatomic, strong) NSMutableDictionary *colorIsDarkMap;

@property (nonatomic, strong) ThemeDataModel *data;
@property (nonatomic, strong) ThemeColorModel *currentThemeColor;
@property (nonatomic, strong) UIColor *textBasicColorUnderLight;
@property (nonatomic, strong) UIColor *textBasicColorUnderDark;
@property (nonatomic, strong) UIColor *contrastingColorUnderLight;
@property (nonatomic, strong) UIColor *contrastingColorUnderDark;

@property (nonatomic, strong) UIColor *BG1;
@property (nonatomic, strong) UIColor *BG2;
@property (nonatomic, strong) UIColor *BG3;
@property (nonatomic, strong) UIColor *BG4;
@property (nonatomic, strong) UIColor *BG5;

@property (nonatomic, strong) UIColor *M1;
@property (nonatomic, strong) UIColor *M2;
@property (nonatomic, strong) UIColor *M3;
@property (nonatomic, strong) UIColor *M4;
@property (nonatomic, strong) UIColor *M5;

@end

@implementation ThemeIMP

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
        _colorIsDarkMap = @{}.mutableCopy;
        [self _addNotification];
    }
    
    return self;
}

- (void)setup {
    if (![self _readThemeData]) return;
    
    if (@available(iOS 13.0, *)) {
        [ThemeModeObserver.sharedInstance setup];
    } else {
        [self _reloadThemeColors];
    }
}

#pragma mark - ThemeRuleDelegate

- (NSData *)getThemeData {
    if (_delegate && [_delegate respondsToSelector:@selector(getThemeData)]) {
        return [_delegate getThemeData];
    }
    
    NSString *fileName = @"theme_config.json";
    NSString *path = [NSBundle.mainBundle pathForResource:fileName ofType:nil];
    
    if (!path) {
        NSAssert(NO, ([NSString stringWithFormat:@"Please configure the `%@` under the main project.", fileName]));
        return nil;
    }
    
    NSError *error = nil;
    NSData *jsonData = [NSData dataWithContentsOfFile:path options:0 error:&error];
    
    if (error) {
        NSAssert(NO, error.localizedDescription);
        return nil;
    }
    
    return jsonData;
}

- (BOOL)checkIsDarkColor:(UIColor *)color {
    if (_delegate && [_delegate respondsToSelector:@selector(checkIsDarkColor:)]) {
        return [_delegate checkIsDarkColor:color];
    }
    
    BOOL isDarkMode = NO;
    if (@available(iOS 13.0, *)) {
        isDarkMode = ThemeModeObserver.sharedInstance.isDarkMode;
    }
    
    NSMutableArray *meta = self.colorIsDarkMap[color] ?: @[NSNull.null, NSNull.null].mutableCopy; // 0
    id value = isDarkMode ? meta[0] : meta[1];
    if ([value isKindOfClass:NSNumber.class]) {
        return [(NSNumber *)value boolValue];
    }
    
    UIColor *color1 = isDarkMode ? self.contrastingColorUnderDark : self.contrastingColorUnderLight;
    CGFloat C = color_contrast(color1, color);
    // 普通文本的视觉呈现与背景至少要有 4.5:1 的对比度 确保绝大范围视力程度的人群都易于阅读
    // 举例：某个颜色和黑色对比，颜色对比度小于4.5，那该颜色在黑色环境下就是深色
    //      某个颜色和白色对比，颜色对比度大于4.5，那该颜色在白色环境下就是深色
    BOOL isDarkColor = isDarkMode ? C < 4.5 : C > 4.5;
    
    if (isDarkMode) {
        meta[0] = @(isDarkColor);
    } else {
        meta[1] = @(isDarkColor);
    }
    
    self.colorIsDarkMap[color] = meta;
    
    return isDarkColor;
}

- (UIColor *)highLightedColorFromColor:(UIColor *)originalColor {
    if (_delegate && [_delegate respondsToSelector:@selector(highLightedColorFromColor:)]) {
        return [_delegate highLightedColorFromColor:originalColor];
    }
    
    UIColor *basicColor = originalColor.theme_isDarkColor ?
    self.textBasicColorUnderDark :
    self.textBasicColorUnderLight;
    
    return [originalColor theme_colorWithForegroundColor:[basicColor theme_colorWithOpacity:0.1]];
}

- (UIColor *)disableColorFromColor:(nonnull UIColor *)originalColor {
    if (_delegate && [_delegate respondsToSelector:@selector(disableColorFromColor:)]) {
        return [_delegate disableColorFromColor:originalColor];
    }
    
    return [UIColor theme_colorWithDynamicProvider:^UIColor * (UITraitCollection * traitCollection) {
        return [originalColor theme_colorWithOpacity:0.2];
    }];
}

#pragma mark - Notification

- (void)_addNotification {
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(didReceiveMemoryWarning)
                                               name:UIApplicationDidReceiveMemoryWarningNotification
                                             object:nil];
    
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(_reloadThemeColors)
                                               name:ThemeModeChangedNotification
                                             object:nil];
}

#pragma mark - Private Method

- (void)_reloadThemeColors {
    BOOL isDarkMode = NO;
    if (@available(iOS 13.0, *)) {
        isDarkMode = ThemeModeObserver.sharedInstance.isDarkMode;
    }
    
    _currentThemeColor = isDarkMode ? _data.darkThemeColor : _data.lightThemeColor;
    
    _textBasicColorUnderLight = [UIColor theme_colorWithHexString:_data.textBasicColorUnderLight];
    _textBasicColorUnderDark = [UIColor theme_colorWithHexString:_data.textBasicColorUnderDark];
    _contrastingColorUnderLight = [UIColor theme_colorWithHexString:_data.textBasicColorUnderLight];
    _contrastingColorUnderDark = [UIColor theme_colorWithHexString:_data.textBasicColorUnderDark];
    
    _BG1 = [UIColor theme_colorWithDynamicProvider:^UIColor * (UITraitCollection *traitCollection) {
        return [UIColor theme_colorWithHexString:self.currentThemeColor.BG1];
    }];
    _BG2 = [UIColor theme_colorWithDynamicProvider:^UIColor * (UITraitCollection *traitCollection) {
        return [UIColor theme_colorWithHexString:self.currentThemeColor.BG2];
    }];
    _BG3 = [UIColor theme_colorWithDynamicProvider:^UIColor * (UITraitCollection *traitCollection) {
        return [UIColor theme_colorWithHexString:self.currentThemeColor.BG3];
    }];
    _BG4 = [UIColor theme_colorWithDynamicProvider:^UIColor * (UITraitCollection *traitCollection) {
        return [UIColor theme_colorWithHexString:self.currentThemeColor.BG4];
    }];
    _BG5 = [UIColor theme_colorWithDynamicProvider:^UIColor * (UITraitCollection *traitCollection) {
        return [UIColor theme_colorWithHexString:self.currentThemeColor.BG5];
    }];
    
    _M1 = [UIColor theme_colorWithDynamicProvider:^UIColor * (UITraitCollection *traitCollection) {
        return [UIColor theme_colorWithHexString:self.currentThemeColor.M1];
    }];
    _M2 = [UIColor theme_colorWithDynamicProvider:^UIColor * (UITraitCollection *traitCollection) {
        return [UIColor theme_colorWithHexString:self.currentThemeColor.M2];
    }];
    _M3 = [UIColor theme_colorWithDynamicProvider:^UIColor * (UITraitCollection *traitCollection) {
        return [UIColor theme_colorWithHexString:self.currentThemeColor.M3];
    }];
    _M4 = [UIColor theme_colorWithDynamicProvider:^UIColor * (UITraitCollection *traitCollection) {
        return [UIColor theme_colorWithHexString:self.currentThemeColor.M4];
    }];
    _M5 = [UIColor theme_colorWithDynamicProvider:^UIColor * (UITraitCollection *traitCollection) {
        return [UIColor theme_colorWithHexString:self.currentThemeColor.M5];
    }];
    
    [NSNotificationCenter.defaultCenter postNotificationName:ThemeReloadThemeColorsNotification object:nil];
}

- (BOOL)_readThemeData {
    NSData *themeData = [self getThemeData];
    if (!themeData) {
        NSAssert(NO, @"Theme data is nil.");
        return NO;
    }
    
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:themeData
                                                    options:NSJSONReadingMutableContainers
                                                      error:&error];
    if (error) {
        NSAssert(NO, error.localizedDescription);
        return nil;
    }
    
    if (![jsonObject isKindOfClass:NSDictionary.class]) {
        NSAssert(NO, @"The content of theme data must be a dictionary.");
        return NO;
    }
    
    self.data = [[ThemeDataModel alloc] initWithDictionary:jsonObject];
    self.currentThemeColor = self.data.lightThemeColor;
    return YES;
}

@end
