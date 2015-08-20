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
import CoreText

private class FontLoader {
    class func loadFont(name: String) {
        let bundle = NSBundle(forClass: FontLoader.self)
        var fontURL = NSURL()
        let identifier = bundle.bundleIdentifier

        if identifier?.hasPrefix("org.cocoapods") == true {
            // If this framework is added using CocoaPods, resources is placed under a subdirectory
            fontURL = bundle.URLForResource(name, withExtension: "otf", subdirectory: "FontAwesome.swift.bundle")!
        } else {
            fontURL = bundle.URLForResource(name, withExtension: "otf")!
        }

        let data = NSData(contentsOfURL: fontURL)!

        let provider = CGDataProviderCreateWithCFData(data)
        let font = CGFontCreateWithDataProvider(provider)!

        var error: Unmanaged<CFError>?
        if !CTFontManagerRegisterGraphicsFont(font, &error) {
            let errorDescription: CFStringRef = CFErrorCopyDescription(error!.takeUnretainedValue())
            let nsError = error!.takeUnretainedValue() as AnyObject as! NSError
            NSException(name: NSInternalInconsistencyException, reason: errorDescription as String, userInfo: [NSUnderlyingErrorKey: nsError]).raise()
        }
    }
}

public extension UIFont {
    public class func fontAwesomeOfSize(fontSize: CGFloat) -> UIFont {
        struct Static {
            static var onceToken : dispatch_once_t = 0
        }

        let name = "FontAwesome"
        if (UIFont.fontNamesForFamilyName(name).count == 0) {
            dispatch_once(&Static.onceToken) {
                FontLoader.loadFont(name)
            }
        }

        return UIFont(name: name, size: fontSize)!
    }
}

public extension String {
    public static func fontAwesomeIconWithName(name: FontAwesome) -> String {
        return name.rawValue.substringToIndex(advance(name.rawValue.startIndex, 1))
    }
}

public extension UIImage {
    public static func fontAwesomeIconWithName(name: FontAwesome, textColor: UIColor, size: CGSize) -> UIImage {
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineBreakMode = NSLineBreakMode.ByWordWrapping
        paragraph.alignment = .Center
        let attributedString = NSAttributedString(string: String.fontAwesomeIconWithName(name) as String, attributes: [NSFontAttributeName: UIFont.fontAwesomeOfSize(max(size.width, size.height)), NSForegroundColorAttributeName: textColor, NSParagraphStyleAttributeName:paragraph])
        let size = attributedString.sizeWithMaxWidth(size.width)
        UIGraphicsBeginImageContextWithOptions(size, false , 0.0)
        attributedString.drawInRect(CGRectMake(0, 0, size.width, size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

private extension NSAttributedString {
    func sizeWithMaxWidth(maxWidth: CGFloat) -> CGSize {
        return self.boundingRectWithSize(CGSizeMake(maxWidth, 1000), options:(NSStringDrawingOptions.UsesLineFragmentOrigin), context: nil).size
    }
}

public extension String {
    public static func fontAwesomeIconWithCode(code: String) -> String? {
        
        if let raw = FontAwesomeIcons[code], icon = FontAwesome(rawValue: raw)  {
            return self.fontAwesomeIconWithName(icon)
        }
        
        return nil
    }
}


