//
//  ThemeModels.swift
//  Example_ThemeManager
//
//  Created by NeroXie on 2021/6/22.
//

import UIKit

/// Text font size model
@objcMembers public class ThemeTextSize: NSObject, Decodable {
    
    /// Font size
    public var f: CGFloat = 0.0
    
    /// Font line spacing used when the font is displayed on multiple lines.
    public var p: CGFloat = 0.0
    
    /// Font line height
    public var h: CGFloat = 0.0
    
    public override init() {
        super.init()
    }
    
    @objc(initWithF:P:H:)
    public init(f: CGFloat = 0.0, p: CGFloat = 0.0, h: CGFloat = 0.0) {
        super.init()
        
        self.f = f
        self.p = p
        self.h = h
    }
    
    enum CodingKeys: String, CodingKey {
        case f, p, h
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        f = try values.decodeIfPresent(CGFloat.self, forKey: .f) ?? 0.0
        p = try values.decodeIfPresent(CGFloat.self, forKey: .p) ?? 0.0
        h = try values.decodeIfPresent(CGFloat.self, forKey: .h) ?? 0.0
    }
}

struct ThemeDataModel: Decodable {
    
    var supportDarkMode = false
    
    var textBasicColorUnderDark = ""
        
    var textBasicColorUnderLight = ""
    
    var contrastingColorUnderDark = ""
    
    var contrastingColorUnderLight = ""
    
    var darkThemeColor = ThemeColorModel()
    
    var lightThemeColor = ThemeColorModel()
    
    var alpha = ThemeAlphaModel()
    
    var padding = ThemePaddingModel()
    
    var text = ThemeTextModel()
    
    var iconfont = ThemeIconfontModel()
    
    var circle = ThemeCircleModel()
    
    var image = ThemeImageModel()
    
    public init() {}
    
    enum CodingKeys: String, CodingKey {
        case supportDarkMode = "support_dark_mode"
        case textBasicColorUnderDark = "text_basic_color_under_dark"
        case contrastingColorUnderDark = "contrasting_color_under_dark"
        case textBasicColorUnderLight = "text_basic_color_under_light"
        case contrastingColorUnderLight = "contrasting_color_under_light"
        case darkThemeColor = "dark_theme_color"
        case lightThemeColor = "light_theme_color"
        case alpha
        case padding
        case text
        case iconfont
        case circle
        case image
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        supportDarkMode = try values.decodeIfPresent(Bool.self, forKey: .supportDarkMode) ?? false
        textBasicColorUnderDark = try values.decodeIfPresent(String.self, forKey: .textBasicColorUnderDark) ?? ""
        textBasicColorUnderLight = try values.decodeIfPresent(String.self, forKey: .textBasicColorUnderLight) ?? ""
        contrastingColorUnderDark = try values.decodeIfPresent(String.self, forKey: .contrastingColorUnderDark) ?? ""
        contrastingColorUnderLight = try values.decodeIfPresent(String.self, forKey: .contrastingColorUnderLight) ?? ""
        darkThemeColor = try values.decodeIfPresent(ThemeColorModel.self, forKey: .darkThemeColor) ?? ThemeColorModel()
        lightThemeColor = try values.decodeIfPresent(ThemeColorModel.self, forKey: .lightThemeColor) ?? ThemeColorModel()
        alpha = try values.decodeIfPresent(ThemeAlphaModel.self, forKey: .alpha) ?? ThemeAlphaModel()
        padding = try values.decodeIfPresent(ThemePaddingModel.self, forKey: .padding) ?? ThemePaddingModel()
        text = try values.decodeIfPresent(ThemeTextModel.self, forKey: .text) ?? ThemeTextModel()
        iconfont = try values.decodeIfPresent(ThemeIconfontModel.self, forKey: .iconfont) ?? ThemeIconfontModel()
        circle = try values.decodeIfPresent(ThemeCircleModel.self, forKey: .circle) ?? ThemeCircleModel()
        image = try values.decodeIfPresent(ThemeImageModel.self, forKey: .image) ?? ThemeImageModel()
    }
}

struct ThemeAlphaModel: Decodable {
    
    var A1: CGFloat = 0.0
    var A2: CGFloat = 0.0
    var A3: CGFloat = 0.0
    var A4: CGFloat = 0.0
    var A5: CGFloat = 0.0
    var A6: CGFloat = 0.0
    var A7: CGFloat = 0.0
    var A8: CGFloat = 0.0
    var A9: CGFloat = 0.0
    var A10: CGFloat = 0.0
    
    init() {}
    
    enum CodingKeys: String, CodingKey {
        case A1, A2, A3, A4, A5, A6, A7, A8, A9, A10
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        A1 = try values.decodeIfPresent(CGFloat.self, forKey: .A1) ?? 0.0
        A2 = try values.decodeIfPresent(CGFloat.self, forKey: .A2) ?? 0.0
        A3 = try values.decodeIfPresent(CGFloat.self, forKey: .A3) ?? 0.0
        A4 = try values.decodeIfPresent(CGFloat.self, forKey: .A4) ?? 0.0
        A5 = try values.decodeIfPresent(CGFloat.self, forKey: .A5) ?? 0.0
        A6 = try values.decodeIfPresent(CGFloat.self, forKey: .A6) ?? 0.0
        A7 = try values.decodeIfPresent(CGFloat.self, forKey: .A7) ?? 0.0
        A8 = try values.decodeIfPresent(CGFloat.self, forKey: .A8) ?? 0.0
        A9 = try values.decodeIfPresent(CGFloat.self, forKey: .A9) ?? 0.0
        A10 = try values.decodeIfPresent(CGFloat.self, forKey: .A10) ?? 0.0
    }
}

struct ThemeColorModel: Decodable {
    
    var BG1: String = ""
    var BG2: String = ""
    var BG3: String = ""
    var BG4: String = ""
    var BG5: String = ""
    
    var M1: String = ""
    var M2: String = ""
    var M3: String = ""
    var M4: String = ""
    var M5: String = ""
    
    init() {}
    
    enum CodingKeys: String, CodingKey {
        case BG1, BG2, BG3, BG4, BG5, M1, M2, M3, M4, M5
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        BG1 = try values.decodeIfPresent(String.self, forKey: .BG1) ?? ""
        BG2 = try values.decodeIfPresent(String.self, forKey: .BG2) ?? ""
        BG3 = try values.decodeIfPresent(String.self, forKey: .BG3) ?? ""
        BG4 = try values.decodeIfPresent(String.self, forKey: .BG4) ?? ""
        BG5 = try values.decodeIfPresent(String.self, forKey: .BG5) ?? ""
        
        M1 = try values.decodeIfPresent(String.self, forKey: .M1) ?? ""
        M2 = try values.decodeIfPresent(String.self, forKey: .M2) ?? ""
        M3 = try values.decodeIfPresent(String.self, forKey: .M3) ?? ""
        M4 = try values.decodeIfPresent(String.self, forKey: .M4) ?? ""
        M5 = try values.decodeIfPresent(String.self, forKey: .M5) ?? ""
    }
}

struct ThemeTextModel: Decodable {
    
    var T1 = ThemeTextSize()
    var T2 = ThemeTextSize()
    var T3 = ThemeTextSize()
    var T4 = ThemeTextSize()
    var T5 = ThemeTextSize()
    var T6 = ThemeTextSize()
    var T7 = ThemeTextSize()
    var T8 = ThemeTextSize()
    var T9 = ThemeTextSize()
    var T10 = ThemeTextSize()
    
    init() {}
    
    enum CodingKeys: String, CodingKey {
        case T1, T2, T3, T4, T5, T6, T7, T8, T9, T10
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        T1 = try values.decodeIfPresent(ThemeTextSize.self, forKey: .T1) ?? ThemeTextSize()
        T2 = try values.decodeIfPresent(ThemeTextSize.self, forKey: .T2) ?? ThemeTextSize()
        T3 = try values.decodeIfPresent(ThemeTextSize.self, forKey: .T3) ?? ThemeTextSize()
        T4 = try values.decodeIfPresent(ThemeTextSize.self, forKey: .T4) ?? ThemeTextSize()
        T5 = try values.decodeIfPresent(ThemeTextSize.self, forKey: .T5) ?? ThemeTextSize()
        T6 = try values.decodeIfPresent(ThemeTextSize.self, forKey: .T6) ?? ThemeTextSize()
        T7 = try values.decodeIfPresent(ThemeTextSize.self, forKey: .T7) ?? ThemeTextSize()
        T8 = try values.decodeIfPresent(ThemeTextSize.self, forKey: .T8) ?? ThemeTextSize()
        T9 = try values.decodeIfPresent(ThemeTextSize.self, forKey: .T9) ?? ThemeTextSize()
        T10 = try values.decodeIfPresent(ThemeTextSize.self, forKey: .T10) ?? ThemeTextSize()
    }
}

struct ThemePaddingModel: Decodable {
    
    var P1: CGFloat = 0.0
    var P2: CGFloat = 0.0
    var P3: CGFloat = 0.0
    var P4: CGFloat = 0.0
    var P5: CGFloat = 0.0
    var P6: CGFloat = 0.0
    var P7: CGFloat = 0.0
    var P8: CGFloat = 0.0
    var P9: CGFloat = 0.0
    var P10: CGFloat = 0.0
    
    init() {}
    
    enum CodingKeys: String, CodingKey {
        case P1, P2, P3, P4, P5, P6, P7, P8, P9, P10
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        P1 = try values.decodeIfPresent(CGFloat.self, forKey: .P1) ?? 0.0
        P2 = try values.decodeIfPresent(CGFloat.self, forKey: .P2) ?? 0.0
        P3 = try values.decodeIfPresent(CGFloat.self, forKey: .P3) ?? 0.0
        P4 = try values.decodeIfPresent(CGFloat.self, forKey: .P4) ?? 0.0
        P5 = try values.decodeIfPresent(CGFloat.self, forKey: .P5) ?? 0.0
        P6 = try values.decodeIfPresent(CGFloat.self, forKey: .P6) ?? 0.0
        P7 = try values.decodeIfPresent(CGFloat.self, forKey: .P7) ?? 0.0
        P8 = try values.decodeIfPresent(CGFloat.self, forKey: .P8) ?? 0.0
        P9 = try values.decodeIfPresent(CGFloat.self, forKey: .P9) ?? 0.0
        P10 = try values.decodeIfPresent(CGFloat.self, forKey: .P10) ?? 0.0
    }
}

struct ThemeIconfontModel: Decodable {
    
    var IC1: CGFloat = 0.0
    var IC2: CGFloat = 0.0
    var IC3: CGFloat = 0.0
    var IC4: CGFloat = 0.0
    var IC5: CGFloat = 0.0
    var IC6: CGFloat = 0.0
    var IC7: CGFloat = 0.0
    var IC8: CGFloat = 0.0
    var IC9: CGFloat = 0.0
    var IC10: CGFloat = 0.0
    
    init() {}
    
    enum CodingKeys: String, CodingKey {
        case IC1, IC2, IC3, IC4, IC5, IC6, IC7, IC8, IC9, IC10
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        IC1 = try values.decodeIfPresent(CGFloat.self, forKey: .IC1) ?? 0.0
        IC2 = try values.decodeIfPresent(CGFloat.self, forKey: .IC2) ?? 0.0
        IC3 = try values.decodeIfPresent(CGFloat.self, forKey: .IC3) ?? 0.0
        IC4 = try values.decodeIfPresent(CGFloat.self, forKey: .IC4) ?? 0.0
        IC5 = try values.decodeIfPresent(CGFloat.self, forKey: .IC5) ?? 0.0
        IC6 = try values.decodeIfPresent(CGFloat.self, forKey: .IC6) ?? 0.0
        IC7 = try values.decodeIfPresent(CGFloat.self, forKey: .IC7) ?? 0.0
        IC8 = try values.decodeIfPresent(CGFloat.self, forKey: .IC8) ?? 0.0
        IC9 = try values.decodeIfPresent(CGFloat.self, forKey: .IC9) ?? 0.0
        IC10 = try values.decodeIfPresent(CGFloat.self, forKey: .IC10) ?? 0.0
    }
}

struct ThemeCircleModel: Decodable {
    
    var C1: CGFloat = 0.0
    var C1_1: CGFloat = 0.0
    var C1_2: CGFloat = 0.0
    var C1_3: CGFloat = 0.0
    var C2: CGFloat = 0.0
    var C2_1: CGFloat = 0.0
    var C2_2: CGFloat = 0.0
    var C2_3: CGFloat = 0.0
    var C3: CGFloat = 0.0
    var C3_1: CGFloat = 0.0
    var C3_2: CGFloat = 0.0
    var C3_3: CGFloat = 0.0
    
    init() {}
    
    enum CodingKeys: String, CodingKey {
        case C1, C1_1, C1_2, C1_3, C2, C2_1, C2_2, C2_3, C3, C3_1, C3_2, C3_3
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        C1 = try values.decodeIfPresent(CGFloat.self, forKey: .C1) ?? 0.0
        C1_1 = try values.decodeIfPresent(CGFloat.self, forKey: .C1_1) ?? 0.0
        C1_2 = try values.decodeIfPresent(CGFloat.self, forKey: .C1_2) ?? 0.0
        C1_3 = try values.decodeIfPresent(CGFloat.self, forKey: .C1_3) ?? 0.0
        C2 = try values.decodeIfPresent(CGFloat.self, forKey: .C2) ?? 0.0
        C2_1 = try values.decodeIfPresent(CGFloat.self, forKey: .C2_1) ?? 0.0
        C2_2 = try values.decodeIfPresent(CGFloat.self, forKey: .C2_2) ?? 0.0
        C2_3 = try values.decodeIfPresent(CGFloat.self, forKey: .C2_3) ?? 0.0
        C3 = try values.decodeIfPresent(CGFloat.self, forKey: .C3) ?? 0.0
        C3_1 = try values.decodeIfPresent(CGFloat.self, forKey: .C3_1) ?? 0.0
        C3_2 = try values.decodeIfPresent(CGFloat.self, forKey: .C3_2) ?? 0.0
        C3_3 = try values.decodeIfPresent(CGFloat.self, forKey: .C3_3) ?? 0.0
    }
}

struct ThemeImageModel: Decodable {
    
    var I1: CGFloat = 0.0
    var I2: CGFloat = 0.0
    var I3: CGFloat = 0.0
    var I4: CGFloat = 0.0
    var I5: CGFloat = 0.0
    var I6: CGFloat = 0.0
    var I7: CGFloat = 0.0
    var I8: CGFloat = 0.0
    var I9: CGFloat = 0.0
    var I10: CGFloat = 0.0
    
    init() {}
    
    enum CodingKeys: String, CodingKey {
        case I1, I2, I3, I4, I5, I6, I7, I8, I9, I10
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        I1 = try values.decodeIfPresent(CGFloat.self, forKey: .I1) ?? 0.0
        I2 = try values.decodeIfPresent(CGFloat.self, forKey: .I2) ?? 0.0
        I3 = try values.decodeIfPresent(CGFloat.self, forKey: .I3) ?? 0.0
        I4 = try values.decodeIfPresent(CGFloat.self, forKey: .I4) ?? 0.0
        I5 = try values.decodeIfPresent(CGFloat.self, forKey: .I5) ?? 0.0
        I6 = try values.decodeIfPresent(CGFloat.self, forKey: .I6) ?? 0.0
        I7 = try values.decodeIfPresent(CGFloat.self, forKey: .I7) ?? 0.0
        I8 = try values.decodeIfPresent(CGFloat.self, forKey: .I8) ?? 0.0
        I9 = try values.decodeIfPresent(CGFloat.self, forKey: .I9) ?? 0.0
        I10 = try values.decodeIfPresent(CGFloat.self, forKey: .I10) ?? 0.0
    }
}
