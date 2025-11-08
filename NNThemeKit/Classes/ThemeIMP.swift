//
//  Theme.swift
//  Example_ThemeManager
//
//  Created by NeroXie on 2021/6/22.
//

import UIKit

final class ThemeIMP: NSObject {
    
    static let shared = ThemeIMP()
    
    private var isDarkColorMap = [UIColor: (isDarkUnderLight: Bool?, isDarkUnderDark: Bool?)]()
    
    weak var ruleDelegate: ThemeRuleDelegate? = nil;
    
//    private(set) var originalDataMap: [String: Any] = [:]
    
    private(set) var data: ThemeDataModel = ThemeDataModel()
    
    private(set) var currentThemeColor: ThemeColorModel = ThemeColorModel()
    
    private(set) var textBasicColorUnderLight = UIColor.clear
    
    private(set) var textBasicColorUnderDark = UIColor.clear
    
    private(set) var contrastingColorUnderLight = UIColor.white
    
    private(set) var contrastingColorUnderDark = UIColor.black
    
    private(set) var BG1 = UIColor.clear
    
    private(set) var BG2 = UIColor.clear
    
    private(set) var BG3 = UIColor.clear
    
    private(set) var BG4 = UIColor.clear
    
    private(set) var BG5 = UIColor.clear
    
    private(set) var M1 = UIColor.clear
    
    private(set) var M2 = UIColor.clear
    
    private(set) var M3 = UIColor.clear
    
    private(set) var M4 = UIColor.clear
    
    private(set) var M5 = UIColor.clear
    
    private override init() {
        super.init()
        
        let selector = #selector(didReceiveMemoryWarning)
        let notification = UIApplication.didReceiveMemoryWarningNotification
        NotificationCenter.default.addObserver(self, selector: selector, name: notification, object: nil)
    }
    
    func setup(with ruleDelegate: ThemeRuleDelegate? = nil) {
        self.ruleDelegate = ruleDelegate
        
        if readThemeData() == false {
            return
        }
        
        if #available(iOS 13.0, *) {
            ThemeModeObserver.shared.setup()
        } else {
            reloadThemeColors(with: false)
        }
    }
    
    func reloadThemeColors(with isDarkMode: Bool) {
        currentThemeColor = isDarkMode ? data.darkThemeColor : data.lightThemeColor
        
        textBasicColorUnderLight = UIColor.theme.color(from: data.textBasicColorUnderLight)
        textBasicColorUnderDark = UIColor.theme.color(from: data.textBasicColorUnderDark)
        contrastingColorUnderLight = UIColor.theme.color(from: data.contrastingColorUnderLight)
        contrastingColorUnderDark = UIColor.theme.color(from: data.contrastingColorUnderDark)
        
        BG1 = UIColor.theme.color { _ in UIColor.theme.color(from: self.currentThemeColor.BG1) }
        BG2 = UIColor.theme.color { _ in UIColor.theme.color(from: self.currentThemeColor.BG2) }
        BG3 = UIColor.theme.color { _ in UIColor.theme.color(from: self.currentThemeColor.BG3) }
        BG4 = UIColor.theme.color { _ in UIColor.theme.color(from: self.currentThemeColor.BG4) }
        BG5 = UIColor.theme.color { _ in UIColor.theme.color(from: self.currentThemeColor.BG5) }
        M1 = UIColor.theme.color { _ in UIColor.theme.color(from: self.currentThemeColor.M1) }
        M2 = UIColor.theme.color { _ in UIColor.theme.color(from: self.currentThemeColor.M2) }
        M3 = UIColor.theme.color { _ in UIColor.theme.color(from: self.currentThemeColor.M3) }
        M4 = UIColor.theme.color { _ in UIColor.theme.color(from: self.currentThemeColor.M4) }
        M5 = UIColor.theme.color { _ in UIColor.theme.color(from: self.currentThemeColor.M5) }
        
        NotificationCenter.default.post(name: Theme.reloadThemeColorsNotification, object: nil)
    }
    
    private func readThemeData() -> Bool {
        do {
            let themeData = ruleDelegate?.getThemeData?() ?? self.getThemeData()
            guard let _ = try JSONSerialization.jsonObject(with: themeData, options: .mutableContainers) as? [String: Any] else {
                assertionFailure("The content of theme data must be a dictionary.")
                return false
            }
            
            data = try JSONDecoder().decode(ThemeDataModel.self, from: themeData)
            currentThemeColor = data.lightThemeColor
            return true
        } catch {
            assertionFailure(error.localizedDescription)
            return false
        }
    }
    
    @objc private func didReceiveMemoryWarning() {
        isDarkColorMap = [:]
    }
}

extension ThemeIMP: ThemeRuleDelegate {
    
    func getThemeData() -> Data {
        let fileName = "theme_config.json"
        guard let path = Bundle.main.path(forResource: fileName, ofType: nil) else {
            assertionFailure("Please configure the `\(fileName)` under the main project.")
            return Data()
        }
        
        do {
            let url = URL(fileURLWithPath: path)
            let jsonData = try Data(contentsOf: url)
            return jsonData
        } catch {
            assertionFailure(error.localizedDescription)
            return Data()
        }
    }
    
    func disableColor(from originalColor: UIColor) -> UIColor {
        UIColor.theme.color { _ in originalColor.theme.color(with: 0.2) }
    }
    
    func highlightedColor(from originalColor: UIColor) -> UIColor {
        let basicColor = originalColor.theme.isDarkColor ? Theme.textBasicColorUnderDark : Theme.textBasicColorUnderLight
        return originalColor.theme.color(with: basicColor.theme.color(with: 0.1))
    }
    
    func checkDarkColor(with color: UIColor) -> Bool {
        let isDarkMode = Theme.isDarkMode
        // The cache is used to reduce repeated calculations.
        var meta = isDarkColorMap[color] ?? (nil, nil)
        if let value = (isDarkMode ? meta.isDarkUnderDark : meta.isDarkUnderLight) { return value }
        
        let color1 = isDarkMode ? contrastingColorUnderDark : contrastingColorUnderLight
        let C = contrast(from: color1, color2: color)
        // 普通文本的视觉呈现与背景至少要有 4.5:1 的对比度 确保绝大范围视力程度的人群都易于阅读
        // 举例：某个颜色和黑色对比，颜色对比度小于4.5，那该颜色在黑色环境下就是深色
        //      某个颜色和白色对比，颜色对比度大于4.5，那该颜色在白色环境下就是深色
        let isDarkColor = isDarkMode ? C < 4.5 : C > 4.5
        
        meta = isDarkMode ? (meta.isDarkUnderLight, isDarkColor) : (isDarkColor, meta.isDarkUnderDark)
        isDarkColorMap[color] = meta
        
        return isDarkColor
    }
    
    private func contrast(from color1: UIColor, color2: UIColor) -> Double {
        // Get the contrast of two colors.
        // https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html
        // 对比度计算方法 contrast = （L1 + 0.05）/（L2 + 0.05）其中：L指颜色的相对亮度，L1是相对亮度大的颜色，L2是相对亮度小的颜色
        // 相对亮度计算方法 L = 0.2126 * R + 0.7152 * G + 0.0722 * B
        func relativeBrightness(from color: UIColor) -> Double {
            // 对于每个颜色的红（R）、绿（G）和蓝（B）通道，首先将它们的值（范围为 0 到 255）转换为线性 RGB 值：
            // 如果通道值 ≤ 0.03928，线性值 = 通道值 / 12.92
            // 如果通道值 > 0.03928，线性值 = ((通道值 + 0.055) / 1.055) ^ 2.4
            var RsRGB: CGFloat = 0.0, GsRGB: CGFloat = 0.0, BsRGB: CGFloat = 0.0, a: CGFloat = 0.0
            color.getRed(&RsRGB, green: &GsRGB, blue: &BsRGB, alpha: &a)
            
            let R = RsRGB <= 0.03928 ? RsRGB / 12.92 : pow((RsRGB + 0.055) / 1.055, 2.4)
            let G = GsRGB <= 0.03928 ? GsRGB / 12.92 : pow((GsRGB + 0.055) / 1.055, 2.4)
            let B = BsRGB <= 0.03928 ? BsRGB / 12.92 : pow((BsRGB + 0.055) / 1.055, 2.4)
            let L = 0.2126 * R + 0.7152 * G + 0.0722 * B
            
            return L
        }
        
        let L1 = relativeBrightness(from: color1.theme.RGBColor)
        let L2 = relativeBrightness(from: color2.theme.RGBColor)
        let C = L1 > L2 ? (L1 + 0.05) / (L2 + 0.05) : (L2 + 0.05) / (L1 + 0.05)
        
        return C
    }
}
