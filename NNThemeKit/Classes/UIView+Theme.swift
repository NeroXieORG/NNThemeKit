//
//  UIView+Theme.swift
//  ThemeManager
//
//  Created by NeroXie on 2022/5/1.
//

import UIKit

public typealias ThemeUIAction = () -> Void

public extension ThemeWrapper where Element: UIView {
        
    /// The default acton of refreshing theme. It will be called immediately or current theme mode changed.
    func defaultThemeUIAction(_ action: @escaping ThemeUIAction) {
        addThemeUIAction(with: "default_theme_action", action: action)
    }
    
    /// Adds an action of refreshing theme. It will be called immediately or current theme mode changed.
    /// - Parameters:
    ///   - key: The name of refreshing action
    ///   - action: The block of refreshing
    func addThemeUIAction(with key: String, action: @escaping ThemeUIAction) {
        if #available(iOS 13.0, *) {
            base.themeUIActionMap[key] = action
            ThemeModeObserver.shared.cacheThemeUIActions(with: base)
        }
        
        action()
    }
    
    /// Deletes an action of refreshing theme.
    /// - Parameter key: The name of refreshing action
    func deleteThemeUIAction(with key: String) {
        if #available(iOS 13.0, *) { base.themeUIActionMap.removeValue(forKey: key) }
    }
    
    /// Deletes all theme actions in a view.
    func deleteThemeUIActions() {
        if #available(iOS 13.0, *) {
            base.themeUIActionMap.removeAll()
        }
    }
    
    internal func reloadThemeUIActions() {
        if #available(iOS 13.0, *) {
            base.themeUIActionMap.values.forEach { action in action() }
        }
    }
}

// MARK: - 适配 OC

@available(swift, obsoleted: 3.0, message: "Only used in Objective-C")
@objc public extension UIView {
    
    /// The default acton of refreshing theme. It will be called immediately or current theme mode changed.
    func theme_defaultThemeUIAction(_ action: @escaping ThemeUIAction) {
        theme.defaultThemeUIAction(action)
    }
    
    /// Adds an action of refreshing theme. It will be called immediately or current theme mode changed.
    /// - Parameters:
    ///   - key: The name of refreshing action
    ///   - action: The block of refreshing
    func theme_addThemeUIAction(with key: String, action: @escaping ThemeUIAction) {
        theme.addThemeUIAction(with: key, action: action)
    }
    
    /// Deletes an action of refreshing theme.
    /// - Parameter key: The name of refreshing action
    func theme_deleteThemeUIAction(with key: String) {
        theme.deleteThemeUIAction(with: key)
    }
    
    /// Deletes all theme actions in a view.
    func theme_deleteThemeUIActions() {
        theme.deleteThemeUIActions()
    }
}

// MARK: - Private

private var themeUIActionMapKey: Void?

extension UIView {
    
    fileprivate var themeUIActionMap: [String: ThemeUIAction] {
        set { objc_setAssociatedObject(self, &themeUIActionMapKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
        
        get {
            if let map = objc_getAssociatedObject(self, &themeUIActionMapKey) as? [String: ThemeUIAction] { return map }
            
            let newValue: [String: ThemeUIAction] = [:]
            self.themeUIActionMap = newValue
            
            return newValue
        }
    }
}
