////
////  Theme.swift
////  Example_ThemeManager
////
////  Created by NeroXie on 2021/6/23.
////
//
//import UIKit
//
//@objc public extension T {
//    
//    // MARK: - Text basic color
//    
//    /// Text basic color under light mode.
//    static var textBasicColorUnderLight: UIColor { ThemeIMP.shared.textBasicColorUnderLight }
//    
//    /// Text basic color under dark mode.
//    static var textBasicColorUnderDark: UIColor { Theme.shared.textBasicColorUnderDark }
//    
//    /// contrasting color under light mode.
//    static var contrastingColorUnderLight: UIColor { Theme.shared.contrastingColorUnderLight }
//    
//    /// contrasting color under dark mode.
//    static var contrastingColorUnderDark: UIColor { Theme.shared.contrastingColorUnderDark }
//    
//    // MARK: - Background color
//    
//    static var BG1: UIColor { Theme.shared.BG1 }
//    
//    static var BG2: UIColor { Theme.shared.BG2 }
//    
//    static var BG3: UIColor { Theme.shared.BG3 }
//    
//    static var BG4: UIColor { Theme.shared.BG4 }
//    
//    static var BG5: UIColor { Theme.shared.BG5 }
//    
//    // MARK: - Main color
//    
//    static var M1: UIColor { Theme.shared.M1 }
//    
//    static var M2: UIColor { Theme.shared.M2 }
//    
//    static var M3: UIColor { Theme.shared.M3 }
//    
//    static var M4: UIColor { Theme.shared.M4 }
//    
//    static var M5: UIColor { Theme.shared.M5 }
//    
//    // MARK: - Alpha
//    
//    static var A1: CGFloat { Theme.shared.data.alpha.A1 }
//    
//    static var A2: CGFloat { Theme.shared.data.alpha.A2 }
//    
//    static var A3: CGFloat { Theme.shared.data.alpha.A3 }
//    
//    static var A4: CGFloat { Theme.shared.data.alpha.A4 }
//    
//    static var A5: CGFloat { Theme.shared.data.alpha.A5 }
//    
//    static var A6: CGFloat { Theme.shared.data.alpha.A6 }
//    
//    static var A7: CGFloat { Theme.shared.data.alpha.A7 }
//    
//    static var A8: CGFloat { Theme.shared.data.alpha.A8 }
//    
//    static var A9: CGFloat { Theme.shared.data.alpha.A9 }
//    
//    static var A10: CGFloat { Theme.shared.data.alpha.A10 }
//    
//    // MARK: - Padding
//    
//    static var P1: CGFloat { Theme.shared.data.padding.P1 }
//    
//    static var P2: CGFloat { Theme.shared.data.padding.P2 }
//    
//    static var P3: CGFloat { Theme.shared.data.padding.P3 }
//    
//    static var P4: CGFloat { Theme.shared.data.padding.P4 }
//    
//    static var P5: CGFloat { Theme.shared.data.padding.P5 }
//    
//    static var P6: CGFloat { Theme.shared.data.padding.P6 }
//    
//    static var P7: CGFloat { Theme.shared.data.padding.P7 }
//    
//    static var P8: CGFloat { Theme.shared.data.padding.P8 }
//    
//    static var P9: CGFloat { Theme.shared.data.padding.P9 }
//    
//    static var P10: CGFloat { Theme.shared.data.padding.P10 }
//    
//    // MARK: - Text size
//    
//    static var T1: ThemeTextSize { Theme.shared.data.text.T1 }
//    
//    static var T2: ThemeTextSize { Theme.shared.data.text.T2 }
//    
//    static var T3: ThemeTextSize { Theme.shared.data.text.T3 }
//    
//    static var T4: ThemeTextSize { Theme.shared.data.text.T4 }
//    
//    static var T5: ThemeTextSize { Theme.shared.data.text.T5 }
//    
//    static var T6: ThemeTextSize { Theme.shared.data.text.T6 }
//    
//    static var T7: ThemeTextSize { Theme.shared.data.text.T7 }
//    
//    static var T8: ThemeTextSize { Theme.shared.data.text.T8 }
//    
//    static var T9: ThemeTextSize { Theme.shared.data.text.T9 }
//    
//    static var T10: ThemeTextSize { Theme.shared.data.text.T10 }
//    
//    // MARK: - Iconfont size
//    
//    static var IC1: CGFloat { Theme.shared.data.iconfont.IC1 }
//    
//    static var IC2: CGFloat { Theme.shared.data.iconfont.IC2 }
//    
//    static var IC3: CGFloat { Theme.shared.data.iconfont.IC3 }
//    
//    static var IC4: CGFloat { Theme.shared.data.iconfont.IC4 }
//    
//    static var IC5: CGFloat { Theme.shared.data.iconfont.IC5 }
//    
//    static var IC6: CGFloat { Theme.shared.data.iconfont.IC6 }
//    
//    static var IC7: CGFloat { Theme.shared.data.iconfont.IC7 }
//    
//    static var IC8: CGFloat { Theme.shared.data.iconfont.IC8 }
//    
//    // MARK: - Circle size
//    
//    static var C1: CGFloat { Theme.shared.data.circle.C1 }
//    
//    static var C1_1: CGFloat { Theme.shared.data.circle.C1_1 }
//    
//    static var C1_2: CGFloat { Theme.shared.data.circle.C1_2 }
//    
//    static var C1_3: CGFloat { Theme.shared.data.circle.C1_3 }
//    
//    static var C2: CGFloat { Theme.shared.data.circle.C2 }
//    
//    static var C2_1: CGFloat { Theme.shared.data.circle.C2_1 }
//    
//    static var C2_2: CGFloat { Theme.shared.data.circle.C2_2 }
//    
//    static var C2_3: CGFloat { Theme.shared.data.circle.C2_3 }
//    
//    // MARK: - Image size
//    
//    static var I1: CGFloat { Theme.shared.data.image.I1 }
//    
//    static var I2: CGFloat { Theme.shared.data.image.I2 }
//    
//    static var I3: CGFloat { Theme.shared.data.image.I3 }
//    
//    static var I4: CGFloat { Theme.shared.data.image.I4 }
//    
//    static var I5: CGFloat { Theme.shared.data.image.I5 }
//    
//    static var I6: CGFloat { Theme.shared.data.image.I6 }
//    
//    static var I7: CGFloat { Theme.shared.data.image.I7 }
//    
//    static var I8: CGFloat { Theme.shared.data.image.I8 }
//    
//    // MARK: - Theme notification
//    
//    /// The notification of reloading theme colors.
//    static var reloadThemeColorsNotification: Notification.Name { .init("reloadThemeColors") }
//    
//    /// The notification of changing theme mode.
//    static var changedThemeSuccessNotification: Notification.Name { .init("changedThemeSuccess") }
//    
//    // MARK: -
//    
//    /// Current mode is dark mode
//    static var isDarkMode: Bool {
//        if #available(iOS 13.0, *) { return ThemeModeManager.shared.isDarkMode }
//        
//        return false
//    }
//    
//    static var preferredStatusBarStyle: UIStatusBarStyle {
//        if #available(iOS 13.0, *) { return ThemeModeManager.shared.preferredStatusBarStyle }
//        
//        return .default
//    }
//    
//    @available(iOS 12.0, *)
//    static var currentUserInterfaceStyle: UIUserInterfaceStyle {
//        if #available(iOS 13.0, *) { return ThemeModeManager.shared.currentUserInterfaceStyle }
//        
//        return .light
//    }
//    
//    /// The original data of the Theme.
//    static var originalThemeDataMap: [String: Any] { Theme.shared.originalDataMap }
//    
//    @objc (setupThemeWithThemeRuleImpl:)
//    /// Theme initialization function.
//    /// - Parameter themeRuleImpl: The implementor of the theme rule，default is `Theme` class.
//    static func setupTheme(with themeRuleImpl: ThemeRuleImplementation? = nil) {
//        Theme.shared.setup(with: themeRuleImpl)
//    }
//    
//    /// Updates theme mode.
//    /// - Parameter themeMode: The theme mode.
//    static func updateCurrentThemeMode(_ themeMode: ThemeMode) {
//        if #available(iOS 13.0, *) { ThemeModeManager.shared.updateCurrentThemeMode(themeMode) }
//    }
//    
////    @nonobjc
////    /// Find the value in theme data according to the key path.
////    /// - Parameter keyPath: The path of keys，using "." to split.
////    /// - Returns: The result value.
////    static func findThemeValue<Value>(for keyPath: String) -> Value? {
////        Theme.shared.findValue(for: keyPath)
////    }
////    
////    @available(swift, obsoleted: 3.0, message: "Only used in Objective-C")
////    /// Find the value in theme data according to the key path.
////    /// - Parameter keyPath: The path of keys，using "." to split.
////    /// - Returns: The result value.
////    static func findThemeValueForKeyPath(_ keypath: String) -> Any? {
////        self.findThemeValue(for: keypath)
////    }
//}
