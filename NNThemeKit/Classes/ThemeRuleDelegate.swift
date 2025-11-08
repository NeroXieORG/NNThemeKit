//
//  ThemeRuleImplementation.swift
//  ThemeManager
//
//  Created by NeroXie on 2022/5/2.
//

import UIKit

/**
 theme_config.json 定义：
 {
     "support_dark_mode": true,
     "text_basic_color_under_dark": "#FFFFFF",
     "text_basic_color_under_light": "#333333",
     "contrasting_color_under_dark": "#333333",
     "contrasting_color_under_light": "#FFFFFF",
     "light_theme_color": {
         "BG1": "#F6F7FA",
         "BG2": "#F0F4FE",
         "BG3": "#EDF3EE",
         "BG4": "#EDF3EE",
         "BG5": "#EDF3EE",
         "M1": "#1564FF",
         "M2": "#13C2C2",
         "M3": "#F1960D",
         "M4": "#F5222D",
         "M5": "#52C41A"
     },
     "dark_theme_color": {
         "BG1": "#242425",
         "BG2": "#232425",
         "BG3": "#232423",
         "BG4": "#232423",
         "BG5": "#232423",
         "M1": "#4383FF",
         "M2": "#13C2C2",
         "M3": "#F3AB3D",
         "M4": "#F74E56",
         "M5": "#74CF47"
     },
     "alpha": {
         "A1": 0.9,
         "A2": 0.8,
         "A3": 0.7,
         "A4": 0.6,
         "A5": 0.5,
         "A6": 0.4,
         "A7": 0.3,
         "A8": 0.2,
         "A9": 0.1,
         "A10": 0.05
     },
     "iconfont": {
         "IC1": 4.0,
         "IC2": 8.0,
     },
     "circle": {
         "C1": 8,
         "C1_1": 6,
         "C1_2": 4,
         "C1_3": 2,
     },
     "image": {
         "I1": 8,
         "I2": 16,
         "I3": 24,
         "I4": 32,
         "I5": 40,
         "I6": 48
         
     },
     "padding": {
         "P1": 4,
         "P2": 8,
         "P3": 12,
         "P4": 16,
         "P5": 20,
         "P6": 24,
         "P7": 28,
         "P8": 32,
         "P9": 36
     },
     "text": {
         "T1": { "f": 11, "p": 1, "h": 16 },
         "T2": { "f": 12, "p": 2, "h": 16 },
         "T3": { "f": 13, "p": 1, "h": 20 },
         "T4": { "f": 14, "p": 2, "h": 20 },
         "T5": { "f": 15, "p": 3, "h": 20 },
         "T6": { "f": 16, "p": 4, "h": 24 }
     }
 }
 */

@objc public protocol ThemeRuleDelegate: NSObjectProtocol {
    
    /// 获取 Theme 的配置数据，默认在主工程下需要存放一个 `theme_config.json` 文件，`theme_config.json` 命名规则如上
    @objc optional func getThemeData() -> Data
    
    /// 获取某个 UIColor 在不可用状态下的 UIColor
    /// - Parameter originalColor: UIColor 对象.
    @objc optional func disableColor(from originalColor: UIColor) -> UIColor
    
    /// 获取某个 Color 在高亮状态的下的 UIColor
    /// - Parameter originalColor: UIColor 对象.
    @objc optional func highlightedColor(from originalColor: UIColor) -> UIColor
    
    /// 返回某个 UIColor 是否为深色的判断，默认规则是和一个参照色作对比来判断是否为深色
    /// 默认实现 ThemeIMP.contrast(from color1: UIColor, color2: UIColor)
    /// - Parameter color: UIColor 对象.
    @objc optional func checkDarkColor(with color: UIColor) -> Bool
}


