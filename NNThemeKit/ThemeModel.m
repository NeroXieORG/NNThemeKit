//
//  ThemeModel.m
//  NNThemeKit
//
//  Created by NeroXie on 2025/11/6.
//

#import "ThemeModel.h"

@interface NSObject (SafeKVC)

@end

@implementation NSObject (SafeKVC)

- (void)safeSetValue:(id)value forKey:(NSString *)key {
    @try {
        [self setValue:value forKey:key];
    } @catch (NSException *exception) {
        NSLog(@"[SafeKVC] Skip key: %@ (%@)", key, exception.reason);
    }
}

@end

@implementation ThemeTextSize

- (instancetype)initWithF:(CGFloat)f p:(CGFloat)p h:(CGFloat)h {
    if (self = [super init]) {
        _f = f;
        _p = p;
        _h = h;
    }
    return self;
}
- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        _f = [dict[@"f"] doubleValue];
        _p = [dict[@"p"] doubleValue];
        _h = [dict[@"h"] doubleValue];
    }
    return self;
}

@end

@implementation ThemeAlphaModel

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        for (int i = 1; i <= 10; i++) {
            NSString *key = [NSString stringWithFormat:@"A%d", i];
            NSNumber *value = dict[key] ?: @(0.0);
            [self safeSetValue:@([value doubleValue]) forKey:key];
        }
    }
    return self;
}

@end

@implementation ThemeColorModel

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
//        _textBasic = dict[@"textBasic"] ?: @"";
        _BG1 = dict[@"BG1"] ?: @"";
        _BG2 = dict[@"BG2"] ?: @"";
        _BG3 = dict[@"BG3"] ?: @"";
        _BG4 = dict[@"BG4"] ?: @"";
        _BG5 = dict[@"BG5"] ?: @"";
        _M1 = dict[@"M1"] ?: @"";
        _M2 = dict[@"M2"] ?: @"";
        _M3 = dict[@"M3"] ?: @"";
        _M4 = dict[@"M4"] ?: @"";
        _M5 = dict[@"M5"] ?: @"";
    }
    return self;
}

@end

@implementation ThemeTextModel

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        for (int i = 1; i <= 10; i++) {
            NSString *key = [NSString stringWithFormat:@"T%d", i];
            ThemeTextSize *size = [[ThemeTextSize alloc] initWithDictionary:dict[key] ?: @{}];
            [self safeSetValue:size forKey:key];
        }
    }
    return self;
}

@end

@implementation ThemePaddingModel

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        for (int i = 1; i <= 10; i++) {
            NSString *key = [NSString stringWithFormat:@"P%d", i];
            NSNumber *value = dict[key] ?: @(0.0);
            [self safeSetValue:@([value doubleValue]) forKey:key];
        }
    }
    return self;
}

@end

@implementation ThemeIconfontModel

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        for (int i = 1; i <= 10; i++) {
            NSString *key = [NSString stringWithFormat:@"IC%d", i];
            NSNumber *value = dict[key] ?: @(0.0);
            [self safeSetValue:@([value doubleValue]) forKey:key];
        }
    }
    return self;
}

@end

@implementation ThemeCircleModel

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        NSArray *keys = @[@"C1", @"C1_1", @"C1_2", @"C1_3",
                          @"C2", @"C2_1", @"C2_2", @"C2_3",
                          @"C3", @"C3_1", @"C3_2", @"C3_3"];
        for (NSString *key in keys) {
            NSNumber *value = dict[key] ?: @(0.0);
            [self safeSetValue:@([value doubleValue]) forKey:key];
        }
    }
    return self;
}

@end

@implementation ThemeImageModel
- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        for (int i = 1; i <= 10; i++) {
            NSString *key = [NSString stringWithFormat:@"I%d", i];
            NSNumber *value = dict[key] ?: @(0.0);
            [self safeSetValue:@([value doubleValue]) forKey:key];
        }
    }
    return self;
}
@end

@implementation ThemeDataModel

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        _supportDarkMode = [dict[@"support_dark_mode"] boolValue];
        _textBasicColorUnderDark = dict[@"text_basic_color_under_dark"] ?: @"";
        _textBasicColorUnderLight = dict[@"text_basic_color_under_light"] ?: @"";
        _contrastingColorUnderDark = dict[@"contrasting_color_under_dark"] ?: @"";
        _contrastingColorUnderLight = dict[@"contrasting_color_under_light"] ?: @"";
        
        _darkThemeColor = [[ThemeColorModel alloc] initWithDictionary:dict[@"dark_theme_color"] ?: @{}];
        _lightThemeColor = [[ThemeColorModel alloc] initWithDictionary:dict[@"light_theme_color"] ?: @{}];
        _alpha = [[ThemeAlphaModel alloc] initWithDictionary:dict[@"alpha"] ?: @{}];
        _padding = [[ThemePaddingModel alloc] initWithDictionary:dict[@"padding"] ?: @{}];
        _text = [[ThemeTextModel alloc] initWithDictionary:dict[@"text"] ?: @{}];
        _iconfont = [[ThemeIconfontModel alloc] initWithDictionary:dict[@"iconfont"] ?: @{}];
        _circle = [[ThemeCircleModel alloc] initWithDictionary:dict[@"circle"] ?: @{}];
        _image = [[ThemeImageModel alloc] initWithDictionary:dict[@"image"] ?: @{}];
    }
    return self;
}

@end
