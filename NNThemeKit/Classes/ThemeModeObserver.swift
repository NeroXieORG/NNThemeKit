//
//  ThemeMode.swift
//  Example_ThemeManager
//
//  Created by NeroXie on 2021/6/22.
//

import Foundation

@objc public enum ThemeMode: Int, Equatable {
    
    case system = 0
    
    case light = 1
    
    case dark = 2
}

@available(iOS 13.0, *)
class ThemeModeObserver {
    
    static let shared = ThemeModeObserver()
    
    private var viewHashTable = NSHashTable<UIView>(options: .weakMemory)
    
    private(set) var currentMode: ThemeMode = .system
    
    private(set) var currentUserInterfaceStyle: UIUserInterfaceStyle = .unspecified
    
    private var themeObserveWindow: UIWindow?
    
    var isDarkMode: Bool {
        switch currentMode {
        case .light: return false
        case .dark: return true
        case .system: return currentUserInterfaceStyle == .dark
        }
    }
    
    var preferredStatusBarStyle: UIStatusBarStyle {
        switch currentMode {
        case .light: return .darkContent
        case .dark: return .lightContent
        case .system: return .default
        }
    }
    
    private init() {}
    
    func setup() {
        var themeMode = currentMode
        let rawValue = UserDefaults.standard.value(forKey: .themeModeKey)
        if let _rawValue = rawValue as? Int, let cacheMode = ThemeMode(rawValue: _rawValue) {
            themeMode = cacheMode
        }
        
        if ThemeIMP.shared.data.supportDarkMode {
            let selector = #selector(changeWindowsUserInterfaceStyle(with:))
            let name = UIWindow.didBecomeVisibleNotification
            NotificationCenter.default.addObserver(self, selector: selector, name: name, object: nil)
        } else {
            themeMode = .light
        }
        
        changeThemeMode(themeMode)
    }
    
    func changeThemeMode(_ themeMode: ThemeMode) {
        currentMode = themeMode
        UserDefaults.standard.setValue(themeMode.rawValue, forKey: .themeModeKey)
        UserDefaults.standard.synchronize()
        switch themeMode {
        case .light:
            updateAllWindowUserInterfaceStyle(.light)
            updateCurrentUserInterfaceStyle(.light)
        case .dark:
            updateAllWindowUserInterfaceStyle(.dark)
            updateCurrentUserInterfaceStyle(.dark)
        case .system:
            updateAllWindowUserInterfaceStyle(.unspecified)
            updateCurrentUserInterfaceStyle(UITraitCollection.current.userInterfaceStyle)
        }
    }
    
    func cacheThemeUIActions(with view: UIView) {
        guard !viewHashTable.contains(view) else { return }
        
        viewHashTable.add(view)
    }
    
    // MARK: - Private Method
    
    private func updateCurrentUserInterfaceStyle(_ style: UIUserInterfaceStyle) {
        currentUserInterfaceStyle = style
        ThemeIMP.shared.reloadThemeColors(with: isDarkMode)
        reloadThemeUIActions()
        NotificationCenter.default.post(name: Theme.changedThemeSuccessNotification, object: style)
    }
    
    private func updateAllWindowUserInterfaceStyle(_ userInterfaceStyle: UIUserInterfaceStyle) {
        for window in UIApplication.shared.windows {
            if let theWindow = themeObserveWindow, theWindow == window {
                continue
            }
            
            window.overrideUserInterfaceStyle = userInterfaceStyle
        }
    }
    
    fileprivate func traitCollectionDidChange(with style: UIUserInterfaceStyle) {
        guard currentMode == ThemeMode.system, style != currentUserInterfaceStyle else {
            return
        }
        
        updateCurrentUserInterfaceStyle(style)
    }
    
    @objc private func changeWindowsUserInterfaceStyle(with notification: NSNotification) {
        guard let window = notification.object as? UIWindow else { return }
        if window.traitCollection.userInterfaceStyle != currentUserInterfaceStyle {
            window.overrideUserInterfaceStyle = currentUserInterfaceStyle
        }
        
        if let delegateWindow = UIApplication.shared.delegate?.window, delegateWindow == window {
            themeObserveWindow = ThemeObserveWindow(frame: .zero)
            themeObserveWindow?.windowLevel = .normal + 1
            themeObserveWindow?.overrideUserInterfaceStyle = .unspecified
        }
    }
    
    private func reloadThemeUIActions() {
        print(#function)
        //        let start = CFAbsoluteTimeGetCurrent()
        viewHashTable.allObjects.forEach { $0.theme.reloadThemeUIActions() }
        //        let end = CFAbsoluteTimeGetCurrent()
        //        print("Time of reloading UI action：\((end-start) * 1000) 毫秒")
        //        if reloadAllThemeAction {
        //            viewHashTable.allObjects.forEach { $0.t.reloadThemeUIActions() }
        //        } else {
        //            viewHashTable.allObjects
        //            // .filter { $0.t.isDisplayedInScreen }
        //                .forEach { $0.t.reloadThemeUIActions() }
        //        }
    }
}

fileprivate extension String {
    
    @available(iOS 13.0, *)
    static var themeModeKey: String { "ThemeMode" }
}

@available(iOS 13.0, *)
fileprivate class ThemeObserveWindow: UIWindow {
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        guard traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) else {
            return
        }
        
        ThemeModeObserver.shared.traitCollectionDidChange(with: traitCollection.userInterfaceStyle)
    }
}
