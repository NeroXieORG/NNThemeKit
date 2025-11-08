//
//  UIColor+Theme.m
//  NNThemeKit
//
//  Created by NeroXie on 2025/11/5.
//

#import "UIColor+Theme.h"
#import "Theme.h"

#define COLOR_ALPHA_IMPLEMENTATION(ALPHA) \
- (UIColor *)ALPHA { \
/**/return [UIColor theme_colorWithDynamicProvider:^UIColor *(UITraitCollection *traitCollection) { \
/**//**/return [self.theme_textBasicColor theme_colorWithOpacity:Theme.ALPHA]; \
/**/}]; \
}

@implementation UIColor (Theme)

COLOR_ALPHA_IMPLEMENTATION(A1)

COLOR_ALPHA_IMPLEMENTATION(A2)

COLOR_ALPHA_IMPLEMENTATION(A3)

COLOR_ALPHA_IMPLEMENTATION(A4)

COLOR_ALPHA_IMPLEMENTATION(A5)

COLOR_ALPHA_IMPLEMENTATION(A6)

COLOR_ALPHA_IMPLEMENTATION(A7)

COLOR_ALPHA_IMPLEMENTATION(A8)

COLOR_ALPHA_IMPLEMENTATION(A9)

COLOR_ALPHA_IMPLEMENTATION(A10)

- (UIColor *)theme_disabledColor {
    return [Theme disableColorFromColor:self];
}

- (UIColor *)theme_highLightedColor {
    return [Theme highLightedColorFromColor:self];
}

- (BOOL)theme_isDarkColor {
    return [Theme checkIsDarkColor:self];
}

- (UIImage *)theme_image {
    CGRect frame = CGRectMake(0.0, 0.0, 1.0, 1.0);
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, self.CGColor);
    CGContextFillRect(context, frame);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIColor *)theme_RGBColor {
    CGFloat r = 0, g = 0, b = 0, a = 0;
    [self getRed:&r green:&g blue:&b alpha:&a];
    
    if (a == 0.0) return UIColor.clearColor;
    else if (a == 1.0) return self;
    
    CGFloat red   = floor(r * a * 255.0 + 255.0 * (1.0 - a));
    CGFloat green = floor(g * a * 255.0 + 255.0 * (1.0 - a));
    CGFloat blue  = floor(b * a * 255.0 + 255.0 * (1.0 - a));
    
    return [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:1.0];
}

- (UIColor *)theme_colorWithOpacity:(CGFloat)opacity {
    CGFloat r = 0.0, g = 0.0, b = 0.0, a = 0.0;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return [UIColor colorWithRed:r green:g blue:b alpha:a * opacity];
}

- (UIColor *)theme_colorWithForegroundColor:(UIColor *)foregroundColor {
    CGFloat r1 = 0, g1 = 0, b1 = 0, a1 = 0;
    CGFloat r2 = 0, g2 = 0, b2 = 0, a2 = 0;
    
    [foregroundColor getRed:&r1 green:&g1 blue:&b1 alpha:&a1];
    [self getRed:&r2 green:&g2 blue:&b2 alpha:&a2];
    
    // 混合算法：基于标准 alpha 混合公式
    CGFloat alpha = 1.0 - (1.0 - a1) * (1.0 - a2);
    CGFloat red   = (a1 * r1 + (1.0 - a1) * r2 * a2) / alpha;
    CGFloat green = (a1 * g1 + (1.0 - a1) * g2 * a2) / alpha;
    CGFloat blue  = (a1 * b1 + (1.0 - a1) * b2 * a2) / alpha;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *)theme_colorWithHexString:(NSString *)hexString {
    if (hexString.length == 0) return UIColor.clearColor;
    
    NSString *hex = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    hex = [hex stringByReplacingOccurrencesOfString:@"0x" withString:@""];
    
    unsigned int intValue = 0;
    [[NSScanner scannerWithString:hex] scanHexInt:&intValue];
    
    unsigned int a = 255, r = 0, g = 0, b = 0;
    
    switch (hex.length) {
        case 3: // RGB (12-bit)
            r = ((intValue >> 8) & 0xF) * 17;
            g = ((intValue >> 4) & 0xF) * 17;
            b = (intValue & 0xF) * 17;
            a = 255;
            break;
        case 6: // RGB (24-bit)
            r = (intValue >> 16) & 0xFF;
            g = (intValue >> 8) & 0xFF;
            b = intValue & 0xFF;
            a = 255;
            break;
        case 8: // RGBA (32-bit)
            r = (intValue >> 24) & 0xFF;
            g = (intValue >> 16) & 0xFF;
            b = (intValue >> 8) & 0xFF;
            a = intValue & 0xFF;
            break;
        default:
            r = g = b = a = 0;
            break;
    }
    
    return [UIColor colorWithRed:(CGFloat)r / 255.0
                           green:(CGFloat)g / 255.0
                            blue:(CGFloat)b / 255.0
                           alpha:(CGFloat)a / 255.0];
    
}

+ (UIColor *)theme_colorWithDynamicProvider:(UIColor * (^)(UITraitCollection *))dynamicProvider {
    if (@available(iOS 13.0, *)) {
        return [UIColor colorWithDynamicProvider:dynamicProvider];
    } else {
        return dynamicProvider(nil);
    }
}

#pragma mark - Private

- (UIColor *)theme_textBasicColor {
    return self.theme_isDarkColor ? Theme.textBasicColorUnderDark : Theme.textBasicColorUnderLight;
}

@end
