//
//  ThemeWrapper.swift
//  NNThemeKit
//
//  Created by NeroXie on 2025/11/8.
//

import Foundation

public struct ThemeWrapper<Element> {
    
    public let base: Element
    
    public init(_ base: Element) {
        self.base = base
    }
}

public protocol ThemeWrapperCompatible {}

public extension ThemeWrapperCompatible {
    
    static var theme: ThemeWrapper<Self>.Type {
        get { ThemeWrapper<Self>.self }
        set {}
    }
    
    var theme: ThemeWrapper<Self> {
        get { ThemeWrapper(self) }
        set {}
    }
}

extension UIView: ThemeWrapperCompatible {}

extension UIColor: ThemeWrapperCompatible {}

extension String: ThemeWrapperCompatible {}
