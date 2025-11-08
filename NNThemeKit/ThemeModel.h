//
//  ThemeModel.h
//  NNThemeKit
//
//  Created by NeroXie on 2025/11/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ThemeTextSize: NSObject

/// 字体大小
@property (nonatomic, assign) CGFloat f;
/// 字体间距
@property (nonatomic, assign) CGFloat p;
/// 单号高度
@property (nonatomic, assign) CGFloat h;

- (instancetype)initWithF:(CGFloat)f p:(CGFloat)p h:(CGFloat)h;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
@end

@interface ThemeAlphaModel: NSObject

@property (nonatomic, assign) CGFloat A1;
@property (nonatomic, assign) CGFloat A2;
@property (nonatomic, assign) CGFloat A3;
@property (nonatomic, assign) CGFloat A4;
@property (nonatomic, assign) CGFloat A5;
@property (nonatomic, assign) CGFloat A6;
@property (nonatomic, assign) CGFloat A7;
@property (nonatomic, assign) CGFloat A8;
@property (nonatomic, assign) CGFloat A9;
@property (nonatomic, assign) CGFloat A10;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end

@interface ThemeColorModel : NSObject

//@property (nonatomic, strong) NSString *textBasic;
@property (nonatomic, strong) NSString *M1;
@property (nonatomic, strong) NSString *M2;
@property (nonatomic, strong) NSString *M3;
@property (nonatomic, strong) NSString *M4;
@property (nonatomic, strong) NSString *M5;
@property (nonatomic, strong) NSString *BG1;
@property (nonatomic, strong) NSString *BG2;
@property (nonatomic, strong) NSString *BG3;
@property (nonatomic, strong) NSString *BG4;
@property (nonatomic, strong) NSString *BG5;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end

@interface ThemeTextModel : NSObject

@property (nonatomic, strong) ThemeTextSize *T1;
@property (nonatomic, strong) ThemeTextSize *T2;
@property (nonatomic, strong) ThemeTextSize *T3;
@property (nonatomic, strong) ThemeTextSize *T4;
@property (nonatomic, strong) ThemeTextSize *T5;
@property (nonatomic, strong) ThemeTextSize *T6;
@property (nonatomic, strong) ThemeTextSize *T7;
@property (nonatomic, strong) ThemeTextSize *T8;
@property (nonatomic, strong) ThemeTextSize *T9;
@property (nonatomic, strong) ThemeTextSize *T10;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end

@interface ThemePaddingModel : NSObject

@property (nonatomic, assign) CGFloat P1;
@property (nonatomic, assign) CGFloat P2;
@property (nonatomic, assign) CGFloat P3;
@property (nonatomic, assign) CGFloat P4;
@property (nonatomic, assign) CGFloat P5;
@property (nonatomic, assign) CGFloat P6;
@property (nonatomic, assign) CGFloat P7;
@property (nonatomic, assign) CGFloat P8;
@property (nonatomic, assign) CGFloat P9;
@property (nonatomic, assign) CGFloat P10;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end

@interface ThemeIconfontModel : NSObject

@property (nonatomic, assign) CGFloat IC1;
@property (nonatomic, assign) CGFloat IC2;
@property (nonatomic, assign) CGFloat IC3;
@property (nonatomic, assign) CGFloat IC4;
@property (nonatomic, assign) CGFloat IC5;
@property (nonatomic, assign) CGFloat IC6;
@property (nonatomic, assign) CGFloat IC7;
@property (nonatomic, assign) CGFloat IC8;
@property (nonatomic, assign) CGFloat IC9;
@property (nonatomic, assign) CGFloat IC10;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end

@interface ThemeCircleModel : NSObject

@property (nonatomic, assign) CGFloat C1;
@property (nonatomic, assign) CGFloat C1_1;
@property (nonatomic, assign) CGFloat C1_2;
@property (nonatomic, assign) CGFloat C1_3;
@property (nonatomic, assign) CGFloat C2;
@property (nonatomic, assign) CGFloat C2_1;
@property (nonatomic, assign) CGFloat C2_2;
@property (nonatomic, assign) CGFloat C2_3;
@property (nonatomic, assign) CGFloat C3;
@property (nonatomic, assign) CGFloat C3_1;
@property (nonatomic, assign) CGFloat C3_2;
@property (nonatomic, assign) CGFloat C3_3;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end

@interface ThemeImageModel : NSObject

@property (nonatomic, assign) CGFloat I1;
@property (nonatomic, assign) CGFloat I2;
@property (nonatomic, assign) CGFloat I3;
@property (nonatomic, assign) CGFloat I4;
@property (nonatomic, assign) CGFloat I5;
@property (nonatomic, assign) CGFloat I6;
@property (nonatomic, assign) CGFloat I7;
@property (nonatomic, assign) CGFloat I8;
@property (nonatomic, assign) CGFloat I9;
@property (nonatomic, assign) CGFloat I10;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end

@interface ThemeDataModel : NSObject

@property (nonatomic, assign) BOOL supportDarkMode;

@property (nonatomic, copy) NSString *textBasicColorUnderDark;
@property (nonatomic, copy) NSString *textBasicColorUnderLight;
@property (nonatomic, copy) NSString *contrastingColorUnderDark;
@property (nonatomic, copy) NSString *contrastingColorUnderLight;

@property (nonatomic, strong) ThemeColorModel *darkThemeColor;
@property (nonatomic, strong) ThemeColorModel *lightThemeColor;

@property (nonatomic, strong) ThemeAlphaModel *alpha;
@property (nonatomic, strong) ThemePaddingModel *padding;
@property (nonatomic, strong) ThemeTextModel *text;
@property (nonatomic, strong) ThemeIconfontModel *iconfont;
@property (nonatomic, strong) ThemeCircleModel *circle;
@property (nonatomic, strong) ThemeImageModel *image;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
