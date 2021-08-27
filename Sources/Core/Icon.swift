//
//  File.swift
//  
//
//  Created by Mason Phillips on 8/23/21.
//

import UIKit

public struct FontAwesomeConfig {
    private init() {}
    
    public static let fontAspectRatio: CGFloat = 1.28571429
    public static let usesProFonts   : Bool    = false
}

public extension UIFont {
    class func fontAwesome(ofSize fontSize: CGFloat, style: FAIcon.Style) -> UIFont {
        loadFontAwesome(ofStyle: style)
        return UIFont(name: style.fontName, size: fontSize)!
    }
    
    class func loadFontAwesome(ofStyle style: FAIcon.Style) {
        if UIFont.fontNames(forFamilyName: style.fontFamilyName).contains(style.fontName) {
            return
        }

        FontLoader.loadFont(style.fontFilename)
    }
}

private class FontLoader {
    class func loadFont(_ name: String) {
        guard
            let fontURL = URL.fontURL(for: name) as CFURL?
            else { return }

        var error: Unmanaged<CFError>?
        if !CTFontManagerRegisterFontsForURL(fontURL, .process, &error) {
            let errorDescription: CFString = CFErrorCopyDescription(error!.takeUnretainedValue())
            guard let nsError = error?.takeUnretainedValue() as AnyObject as? NSError else { return }
            NSException(name: NSExceptionName.internalInconsistencyException, reason: errorDescription as String, userInfo: [NSUnderlyingErrorKey: nsError]).raise()
        }
    }
}

extension URL {
    static func fontURL(for fontName: String) -> URL? {
        let bundle = Bundle.module

        if let fontURL = bundle.url(forResource: fontName, withExtension: "otf") {
            return fontURL
        }

        return nil
    }
}
