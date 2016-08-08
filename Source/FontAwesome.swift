// FontAwesome.swift
//
// Copyright (c) 2014-2015 Thi Doan
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

// MARK: - Public

// MARK: UIFont

private let fontAwesomeFontName = "FontAwesome"
private let fontAwesomeLoaded = { name -> Bool in
    if UIFont.fontNames(forFamilyName: name).isEmpty {
        FontLoader.load(name: name)
    }
    return true
}(fontAwesomeFontName)

extension UIFont {
    /**
     Get a UIFont object of FontAwesome.
     
     - parameter fontSize: The preferred font size.
     - returns: A UIFont object of FontAwesome.
     */
    public static func fontAwesome(of fontSize: CGFloat) -> UIFont {
        _ = fontAwesomeLoaded
        return UIFont(name: fontAwesomeFontName, size: fontSize)!
    }
}

// MARK: String

extension String {
    /**
     Get a FontAwesome icon string with the given icon name.
     
     - parameter name: The preferred icon name.
     - returns: A string that will appear as icon with FontAwesome.
     */
    public static func fontAwesomeIcon(with name: Icon) -> String {
        return name.unicode
    }
    
    /**
     Get a FontAwesome icon string with the given CSS icon code. Icon code can be found here: http://fontawesome.io/icons/
     
     - parameter code: The preferred icon name.
     - returns: A string that will appear as icon with FontAwesome. It returns an empty string for wrong icon name.
     */
    public static func fontAwesomeIcon(with name: String) -> String {
        guard let name = Icon(rawValue: name) else { return "" }
        return self.fontAwesomeIcon(with: name)
    }
}

// MARK: UIImage

extension UIImage {
    /**
     Get a FontAwesome image with the given icon name, size, text color, and background color.
     
     - parameters:
       - name: The preferred icon name.
       - size: The image size.
       - textColor: The text color. Default is UILabel's default.
       - backgroundColor: The background color. Default is `.clear`.
     */
    public static func fontAwesomeIcon(with name: Icon, size: CGSize, textColor: UIColor? = nil, backgroundColor: UIColor = .clear) -> UIImage {
        // Taken from FontAwesome.io's Fixed Width Icon CSS
        let aspectRatio: CGFloat = 1.28571429
        let fontSize = min(size.width / aspectRatio, size.height)
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        label.font = UIFont.fontAwesome(of: fontSize)
        label.text = String.fontAwesomeIcon(with: name)
        label.textColor = textColor
        label.backgroundColor = backgroundColor
        label.textAlignment = .center
        UIGraphicsBeginImageContext(size)
        label.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    /**
     Get a FontAwesome image with the given icon name, size, text color, and background color.
     
     - parameters:
       - name: The preferred icon name.
       - size: The image size.
       - textColor: The text color. Default is UILabel's default.
       - backgroundColor: The background color. Default is `.clear`.
     */
    public static func fontAwesomeIcon(with name: String, size: CGSize, textColor: UIColor? = nil, backgroundColor: UIColor = .clear) -> UIImage {
        guard let name = Icon(rawValue: name) else {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            view.backgroundColor = backgroundColor
            UIGraphicsBeginImageContext(size)
            view.layer.render(in: UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            return image
        }
        return self.fontAwesomeIcon(with: name, size: size, textColor: textColor, backgroundColor: backgroundColor)
    }
}


// MARK: - Private
private final class FontLoader {
    static func load(name: String, ext: String = "otf") {
        let bundle = Bundle(for: self)
        let bundleIdentifier = bundle.bundleIdentifier ?? ""
        let fontURL: URL
        if bundleIdentifier.hasPrefix("org.cocoapods") {
            // If this framework is added using CocoaPods, resources is placed under a subdirectory
            fontURL = bundle.url(forResource: name, withExtension: ext, subdirectory: "FontAwesome.swift.bundle")!
        } else {
            fontURL = bundle.url(forResource: name, withExtension: ext)!
        }
        
        let data = try! Data(contentsOf: fontURL)
        
        let provider = CGDataProvider(data: data)!
        let font = CGFont(provider)
        
        var error: Unmanaged<CFError>?
        if !CTFontManagerRegisterGraphicsFont(font, &error) {
            guard let error = error?.takeUnretainedValue() else { return }
            let description = CFErrorCopyDescription(error) as String
            NSException(
                name: .internalInconsistencyException,
                reason: description,
                userInfo: [NSUnderlyingErrorKey: error as AnyObject as! NSError]).raise()
        }
    }
}
