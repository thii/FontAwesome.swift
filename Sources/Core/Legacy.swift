//
//  File.swift
//  
//
//  Created by Mason Phillips on 8/27/21.
//

import Foundation

@available(*, deprecated, message: "Use FAIcon instead")
public typealias FontAwesome = FAIcon

public extension String {
    @available(*, deprecated, message: "Legacy API, use FAIcon.unicode instead")
    static func fontAwesomeIcon(name: FAIcon) -> String {
        return name.unicode
    }
    
    @available(*, deprecated, message: "Legacy API, use FAIcon.init(rawValue:) instead")
    static func fontAwesomeIcon(code: String) -> String? {
        guard let icon = self.fontAwesome(code: code) else { return nil }
        return icon.unicode
    }
    
    @available(*, deprecated, message: "Legacy API, use FAIcon.init(rawValue:) instead")
    static func fontAwesome(code: String) -> FAIcon? {
        return FAIcon(rawValue: code)
    }
}
