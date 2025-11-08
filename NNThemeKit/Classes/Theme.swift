//
//  T.swift
//  ThemeManager
//
//  Created by NeroXie on 2022/11/26.
//

import Foundation

@objcMembers
public final class Theme: NSObject {
    
    private override init() {
        super.init()
    }
    
    @inline(__always)
    private static var THEME_DATA: ThemeDataModel {
        ThemeIMP.shared.data
    }
}

public extension Theme {
    
    // MARK: - 字体基础色
    
    /// Text basic color under light mode.
    static var textBasicColorUnderLight: UIColor { ThemeIMP.shared.textBasicColorUnderLight }
    
    /// Text basic color under dark mode.
    static var textBasicColorUnderDark: UIColor { ThemeIMP.shared.textBasicColorUnderDark }
    
    /// contrasting color under light mode.
    static var contrastingColorUnderLight: UIColor { ThemeIMP.shared.contrastingColorUnderLight }
    
    /// contrasting color under dark mode.
    static var contrastingColorUnderDark: UIColor { ThemeIMP.shared.contrastingColorUnderDark }
    
    // MARK: - 背景色定义
    
    static var BG1: UIColor { ThemeIMP.shared.BG1 }
    static var BG2: UIColor { ThemeIMP.shared.BG2 }
    static var BG3: UIColor { ThemeIMP.shared.BG3 }
    static var BG4: UIColor { ThemeIMP.shared.BG4 }
    static var BG5: UIColor { ThemeIMP.shared.BG5 }
    
    // MARK: - 主题色定义
    
    static var M1: UIColor { ThemeIMP.shared.M1 }
    static var M2: UIColor { ThemeIMP.shared.M2 }
    static var M3: UIColor { ThemeIMP.shared.M3 }
    static var M4: UIColor { ThemeIMP.shared.M4 }
    static var M5: UIColor { ThemeIMP.shared.M5 }
    
    // MARK: - Alpha 定义
    
    static var A1: CGFloat { THEME_DATA.alpha.A1 }
    static var A2: CGFloat { THEME_DATA.alpha.A2 }
    static var A3: CGFloat { THEME_DATA.alpha.A3 }
    static var A4: CGFloat { THEME_DATA.alpha.A4 }
    static var A5: CGFloat { THEME_DATA.alpha.A5 }
    static var A6: CGFloat { THEME_DATA.alpha.A6 }
    static var A7: CGFloat { THEME_DATA.alpha.A7 }
    static var A8: CGFloat { THEME_DATA.alpha.A8 }
    static var A9: CGFloat { THEME_DATA.alpha.A9 }
    static var A10: CGFloat { THEME_DATA.alpha.A10 }
    
    // MARK: - 边距定义
    
    static var P1: CGFloat { THEME_DATA.padding.P1 }
    static var P2: CGFloat { THEME_DATA.padding.P2 }
    static var P3: CGFloat { THEME_DATA.padding.P3 }
    static var P4: CGFloat { THEME_DATA.padding.P4 }
    static var P5: CGFloat { THEME_DATA.padding.P5 }
    static var P6: CGFloat { THEME_DATA.padding.P6 }
    static var P7: CGFloat { THEME_DATA.padding.P7 }
    static var P8: CGFloat { THEME_DATA.padding.P8 }
    static var P9: CGFloat { THEME_DATA.padding.P9 }
    static var P10: CGFloat { THEME_DATA.padding.P10 }
    
    // MARK: - 字体尺寸定义
    
    static var T1: ThemeTextSize { THEME_DATA.text.T1 }
    static var T2: ThemeTextSize { THEME_DATA.text.T2 }
    static var T3: ThemeTextSize { THEME_DATA.text.T3 }
    static var T4: ThemeTextSize { THEME_DATA.text.T4 }
    static var T5: ThemeTextSize { THEME_DATA.text.T5 }
    static var T6: ThemeTextSize { THEME_DATA.text.T6 }
    static var T7: ThemeTextSize { THEME_DATA.text.T7 }
    static var T8: ThemeTextSize { THEME_DATA.text.T8 }
    static var T9: ThemeTextSize { THEME_DATA.text.T9 }
    static var T10: ThemeTextSize { THEME_DATA.text.T10 }
    
    // MARK: - Iconfont 定义
    
    static var IC1: CGFloat { THEME_DATA.iconfont.IC1 }
    static var IC2: CGFloat { THEME_DATA.iconfont.IC2 }
    static var IC3: CGFloat { THEME_DATA.iconfont.IC3 }
    static var IC4: CGFloat { THEME_DATA.iconfont.IC4 }
    static var IC5: CGFloat { THEME_DATA.iconfont.IC5 }
    static var IC6: CGFloat { THEME_DATA.iconfont.IC6 }
    static var IC7: CGFloat { THEME_DATA.iconfont.IC7 }
    static var IC8: CGFloat { THEME_DATA.iconfont.IC8 }
    static var IC9: CGFloat { THEME_DATA.iconfont.IC9 }
    static var IC10: CGFloat { THEME_DATA.iconfont.IC10 }
    
    // MARK: - 圆角定义
    
    static var C1: CGFloat { THEME_DATA.circle.C1 }
    static var C1_1: CGFloat { THEME_DATA.circle.C1_1 }
    static var C1_2: CGFloat { THEME_DATA.circle.C1_2 }
    static var C1_3: CGFloat { THEME_DATA.circle.C1_3 }
    static var C2: CGFloat { THEME_DATA.circle.C2 }
    static var C2_1: CGFloat { THEME_DATA.circle.C2_1 }
    static var C2_2: CGFloat { THEME_DATA.circle.C2_2 }
    static var C2_3: CGFloat { THEME_DATA.circle.C2_3 }
    static var C3: CGFloat { THEME_DATA.circle.C3 }
    static var C3_1: CGFloat { THEME_DATA.circle.C3_1 }
    static var C3_2: CGFloat { THEME_DATA.circle.C3_2 }
    static var C3_3: CGFloat { THEME_DATA.circle.C3_3 }
    
    // MARK: - 图片尺寸定义
    
    static var I1: CGFloat { THEME_DATA.image.I1 }
    static var I2: CGFloat { THEME_DATA.image.I2 }
    static var I3: CGFloat { THEME_DATA.image.I3 }
    static var I4: CGFloat { THEME_DATA.image.I4 }
    static var I5: CGFloat { THEME_DATA.image.I5 }
    static var I6: CGFloat { THEME_DATA.image.I6 }
    static var I7: CGFloat { THEME_DATA.image.I7 }
    static var I8: CGFloat { THEME_DATA.image.I8 }
    static var I9: CGFloat { THEME_DATA.image.I9 }
    static var I10: CGFloat { THEME_DATA.image.I10 }
    
    // MARK: - Theme notification
    
    /// 加载颜色的通知，再该通知下可以添加一些自定义的主题色或者背景色
    static var reloadThemeColorsNotification: Notification.Name { .init("reloadThemeColors") }
    
    /// Theme Mode 更新成功通知
    static var changedThemeSuccessNotification: Notification.Name { .init("changedThemeSuccess") }
    
    // MARK: - 其他
    
    /// 当前是否为暗黑模式
    static var isDarkMode: Bool {
        if #available(iOS 13.0, *) { return ThemeModeObserver.shared.isDarkMode }
        
        return false
    }
    
    static var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) { return ThemeModeObserver.shared.preferredStatusBarStyle }
        
        return .default
    }
    
    @available(iOS 12.0, *)
    static var currentUserInterfaceStyle: UIUserInterfaceStyle {
        if #available(iOS 13.0, *) { return ThemeModeObserver.shared.currentUserInterfaceStyle }
        
        return .light
    }
    
    /// 功能使用入口
    /// - Parameter ruleDelegate: Theme 规则代理对象
    static func setup(with ruleDelegate: ThemeRuleDelegate? = nil) {
        ThemeIMP.shared.setup(with: ruleDelegate)
    }
    
    /// 改变当前的 Theme Mode，如暗黑模式
    /// - Parameter themeMode: 新的 Theme Mode 值
    static func changeThemeMode(_ themeMode: ThemeMode) {
        if #available(iOS 13.0, *), THEME_DATA.supportDarkMode  {
            ThemeModeObserver.shared.changeThemeMode(themeMode)
        }
    }
}




