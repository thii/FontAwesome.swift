//
//  File.swift
//  
//
//  Created by Mason Phillips on 8/27/21.
//

import Foundation

extension FAIcon {
    var brands: [Self] {
        return Self.allCases.filter { $0.supportedStyles.contains(.brands) }
    }

    func isSupported(style: Self.Style) -> Bool {
        return self.supportedStyles.contains(style)
    }
}

extension FAIcon.Style {
    var fontName: String {
        switch self {
        case .solid  : return FontAwesomeConfig.usesProFonts ? "FontAwesome5Pro-Solid"   : "FontAwesome5Free-Solid"
        case .regular: return FontAwesomeConfig.usesProFonts ? "FontAwesome5Pro-Regular" : "FontAwesome5Free-Regular"
        case .light  : return FontAwesomeConfig.usesProFonts ? "FontAwesome5Pro-Light"   : "FontAwesome5Free-Regular"
        case .duotone: return FontAwesomeConfig.usesProFonts ? "FontAwesome5Pro-Duotone" : "FontAwesome5Free-Regular"
        case .brands : return "FontAwesome5Brands-Regular"
        }
    }
    
    var fontFilename: String {
        switch self {
        case .solid  : return FontAwesomeConfig.usesProFonts ? "Font Awesome 5 Pro-Solid-900"     : "Font Awesome 5 Free-Solid-900"
        case .regular: return FontAwesomeConfig.usesProFonts ? "Font Awesome 5 Pro-Regular-400"   : "Font Awesome 5 Free-Regular-400"
        case .light  : return FontAwesomeConfig.usesProFonts ? "Font Awesome 5 Pro-Light-300"     : "Font Awesome 5 Free-Regular-400"
        case .duotone: return FontAwesomeConfig.usesProFonts ? "Font Awesome 5 Duotone-Solid-900" : "Font Awesome 5 Free-Regular-400"
        case .brands : return ""
        }
    }
    
    var fontFamilyName: String {
        switch self {
        case .brands : return "Font Awesome 5 Brands"
        case .duotone: return "Font Awesome 5 Duotone"
        default:
            return FontAwesomeConfig.usesProFonts ? "Font Awesome 5 Pro" : "Font Awesome 5 Free"
        }
    }
}
