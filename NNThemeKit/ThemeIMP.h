//
//  ThemeIMP.h
//  NNThemeKit
//
//  Created by NeroXie on 2025/11/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class ThemeDataModel;
@class ThemeColorModel;

@protocol ThemeRuleDelegate;

@interface ThemeIMP : NSObject

@property (nonatomic, weak) id<ThemeRuleDelegate> delegate;
@property (nonatomic, strong, readonly) ThemeDataModel *data;
@property (nonatomic, strong, readonly) ThemeColorModel *currentThemeColor;

@property (nonatomic, strong, readonly) UIColor *textBasicColorUnderLight;
@property (nonatomic, strong, readonly) UIColor *textBasicColorUnderDark;
@property (nonatomic, strong, readonly) UIColor *contrastingColorUnderLight;
@property (nonatomic, strong, readonly) UIColor *contrastingColorUnderDark;

@property (nonatomic, strong, readonly) UIColor *BG1;
@property (nonatomic, strong, readonly) UIColor *BG2;
@property (nonatomic, strong, readonly) UIColor *BG3;
@property (nonatomic, strong, readonly) UIColor *BG4;
@property (nonatomic, strong, readonly) UIColor *BG5;

@property (nonatomic, strong, readonly) UIColor *M1;
@property (nonatomic, strong, readonly) UIColor *M2;
@property (nonatomic, strong, readonly) UIColor *M3;
@property (nonatomic, strong, readonly) UIColor *M4;
@property (nonatomic, strong, readonly) UIColor *M5;

+ (instancetype)sharedInstance;

- (void)setup;

- (UIColor *)disableColorFromColor:(UIColor *)originalColor;

- (UIColor *)highLightedColorFromColor:(UIColor *)originalColor;

- (BOOL)checkIsDarkColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
