//
//  UIButton+Theme.swift
//  ThemeManager
//
//  Created by NeroXie on 2021/5/16.
//

import UIKit

public extension ThemeWrapper where Element: UIButton {
    
    /// Sets the background image to use for the specified button state.
    /// - Parameters:
    ///   - color: The color used to generate the image.
    ///   - state: The state that uses the specified image.
    func setBackgroundImage(with color: UIColor, for state: UIControl.State) {
        base.theme.addThemeUIAction(with: "background_image_\(state)") { [weak base] in
            base?.setBackgroundImage(color.theme.image, for: state)
        }
    }
}

@available(swift, obsoleted: 3.0, message: "Only used in Objective-C")
@objc public extension UIButton {
    
    /// Sets the background image to use for the specified button state.
    /// - Parameters:
    ///   - color: The color used to generate the image.
    ///   - state: The state that uses the specified image.
    func theme_setBackgroundImage(with color: UIColor, for state: UIControl.State) {
        theme.setBackgroundImage(with: color, for: state)
    }
}
