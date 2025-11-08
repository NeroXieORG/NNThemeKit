//
//  UIColor+Theme.swift
//  ApplicationModule
//
//  Created by NeroXie on 2022/4/23.
//

import UIKit

@objc public extension UIColor {
    
    /// Gets the font color of aplha is A1 based on the current color.
    var A1: UIColor { UIColor.theme.color { _ in self.textBasicColor.theme.color(with: Theme.A1) } }
    
    /// Gets the font color of aplha is A2 based on the current color.
    var A2: UIColor { UIColor.theme.color { _ in self.textBasicColor.theme.color(with: Theme.A2) } }
    
    /// Gets the font color of aplha is A3 based on the current color.
    var A3: UIColor { UIColor.theme.color { _ in self.textBasicColor.theme.color(with: Theme.A3) } }
    
    /// Gets the font color of aplha is A4 based on the current color.
    var A4: UIColor { UIColor.theme.color { _ in self.textBasicColor.theme.color(with: Theme.A4) } }
    
    /// Gets the font color of aplha is A5 based on the current color.
    var A5: UIColor { UIColor.theme.color { _ in self.textBasicColor.theme.color(with: Theme.A5) } }
    
    /// Gets the font color of aplha is A6 based on the current color.
    var A6: UIColor { UIColor.theme.color { _ in self.textBasicColor.theme.color(with: Theme.A6) } }
    
    /// Gets the font color of aplha is A7 based on the current color.
    var A7: UIColor { UIColor.theme.color { _ in self.textBasicColor.theme.color(with: Theme.A7) } }
    
    /// Gets the font color of aplha is A8 based on the current color.
    var A8: UIColor { UIColor.theme.color { _ in self.textBasicColor.theme.color(with: Theme.A8) } }
    
    /// Gets the font color of aplha is A9 based on the current color.
    var A9: UIColor { UIColor.theme.color { _ in self.textBasicColor.theme.color(with: Theme.A9) } }
    
    /// Gets the font color of aplha is A10 based on the current color.
    var A10: UIColor { UIColor.theme.color { _ in self.textBasicColor.theme.color(with: Theme.A10) } }
    
    private var textBasicColor: UIColor {
        theme.isDarkColor ? Theme.textBasicColorUnderDark : Theme.textBasicColorUnderLight
    }
}

public extension ThemeWrapper where Element: UIColor {
    
    /// 不可用状态下颜色
    var disabledColor: UIColor {
        ThemeIMP.shared.ruleDelegate?.disableColor?(from: base) ?? ThemeIMP.shared.disableColor(from: base)
    }
    
    /// 高亮状态下颜色
    var highlightedColor: UIColor {
        ThemeIMP.shared.ruleDelegate?.highlightedColor?(from: base) ?? ThemeIMP.shared.highlightedColor(from: base)
    }
    
    /// 当前颜色是否为深色
    var isDarkColor: Bool {
        ThemeIMP.shared.ruleDelegate?.checkDarkColor?(with: base) ?? ThemeIMP.shared.checkDarkColor(with: base)
    }
    
    /// 把带透明度的颜色转换为等效的不透明 RGB 颜色
    var RGBColor: UIColor {
        var r: CGFloat = 0.0, g: CGFloat = 0.0, b: CGFloat = 0.0, a: CGFloat = 0.0
        base.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        if a == 0.0 { return .clear }
        else if a == 1.0 { return base }
        
        let red = floor(r * a * 255.0 + 255 * (1.0 - a))
        let green = floor(g * a * 255.0 + 255 * (1.0 - a))
        let blue = floor(b * a * 255.0 + 255 * (1.0 - a))

        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: 1.0)
    }
    
    /// 将当前颜色转化为图片
    var image: UIImage? {
        let frame = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(frame.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(base.cgColor)
        context?.fill(frame)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    /// 给当前颜色添加一个前景色
    /// - Parameter foregroundColor: 前景色
    func color(with foregroundColor: UIColor) -> UIColor {
        var r1: CGFloat = 0.0, g1: CGFloat = 0.0, b1: CGFloat = 0.0, a1: CGFloat = 0.0
        var r2: CGFloat = 0.0, g2: CGFloat = 0.0, b2: CGFloat = 0.0, a2: CGFloat = 0.0
        foregroundColor.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        base.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        
        let alpha = 1.0 - (1.0 - a1) * (1.0 - a2)
        let red = (a1 * r1 + (1.0 - a1) * r2 * a2) / alpha
        let green = (a1 * g1 + (1.0 - a1) * g2 * a2) / alpha
        let blue = (a1 * b1 + (1.0 - a1) * b2 * a2) / alpha
        
        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }
    
    /// 当前颜色添加一个 alpha 通道
    func color(with opacity: CGFloat) -> UIColor {
        var r: CGFloat = 0.0, g: CGFloat = 0.0, b: CGFloat = 0.0, a: CGFloat = 0.0
        base.getRed(&r, green: &g, blue: &b, alpha: &a)
        return UIColor(red: r, green: g, blue: b, alpha: a * opacity)
    }
    
    /// 通过十六进制字符串生成 UIColor
    /// - Parameter hexString: 十六进制字符串, which support FFF FFFFFF FFFFFFFF 0xFFFFFF #FFFFFF
    static func color(from hexString: String) -> UIColor {
        var hex = hexString.replacingOccurrences(of: "#", with: "")
        hex = hex.replacingOccurrences(of: "0x", with: "")
        
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (r, g, b, a) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17, 255)
        case 6: // RGB (24-bit)
            (r, g, b, a) = (int >> 16, int >> 8 & 0xFF, int & 0xFF, 255)
        case 8: // RGBA (32-bit)
            (r, g, b, a) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (r, g, b, a) = (0, 0, 0, 0)
        }
        
        return UIColor(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    /// Creates a color object that uses the specified block to generate its color data dynamically.
    /// - Parameter dynamicProvider: A block that determines the appropriate color values based on the specified traits.
    /// - Returns: A color object whose color information is provided by the specified block.
    static func color(with dynamicProvider: @escaping (UITraitCollection?) -> UIColor) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { dynamicProvider($0) }
        } else {
            return dynamicProvider(nil)
        }
    }
}

// MARK: - 适配 OC

@available(swift, obsoleted: 3.0, message: "Only used in Objective-C")
@objc public extension UIColor {
    
    /// Gets the color of diabled state on the current color.
    var theme_disabledColor: UIColor { theme.disabledColor }
    
    /// Gets the color of highlighted state on the current color.
    var theme_highlightedColor: UIColor { theme.highlightedColor }
    
    /// The current color is a dark color.
    var theme_isDarkColor: Bool { theme.isDarkColor }
    
    /// RGBA to RGB
    var theme_RGBColor: UIColor { theme.RGBColor }
    
    /// Gets the image of the current color.
    var theme_image: UIImage? { theme.image }
    
    /// Adds a foreground color to the current color.
    /// - Parameter foregroundColor: A foreground color.
    /// - Returns: The color object after adding a foreground color.
    func theme_colorWithForegroundColor(_ foregroundColor: UIColor) -> UIColor {
        theme.color(with: foregroundColor)
    }
    
    /// Adds an opacity to the current color.
    /// - Parameter opacity: The value of opacity, 0 means completely transparent.
    /// - Returns: The color object after adding opacity.
    func theme_colorWithOpacity(_ opacity: CGFloat) -> UIColor {
        theme.color(with: opacity)
    }
    
    /// Gets a color from a hex string.
    /// - Parameter hexString: The string of hex, which support FFF FFFFFF FFFFFFFF 0xFFFFFF #FFFFFF
    /// - Returns: The color object.
    static func theme_colorFromHexString(_ hexString: String) -> UIColor {
        theme.color(from: hexString)
    }
    
    /// Creates a color object that uses the specified block to generate its color data dynamically.
    /// - Parameter dynamicProvider: A block that determines the appropriate color values based on the specified traits.
    /// - Returns: A color object whose color information is provided by the specified block.
    static func theme_colorWithDynamicProvider(_ dynamicProvider: @escaping (UITraitCollection?) -> UIColor) -> UIColor {
        theme.color(with: dynamicProvider)
    }
}
