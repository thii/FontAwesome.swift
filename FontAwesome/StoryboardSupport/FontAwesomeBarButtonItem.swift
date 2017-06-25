// FontAwesomeBarButtonItem.swift
//
// Copyright (c) 2017 Maik639
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

@IBDesignable public class FontAwesomeBarButtonItem: UIBarButtonItem {
    
    @IBInspectable public var isFontAwesomeCSSCode: Bool = true
    @IBInspectable public var size: CGFloat = 25.0
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        useFontAwesome()
    }
    
    public override func prepareForInterfaceBuilder() {
        useFontAwesome()
    }
    
    private func useFontAwesome() {
        updateText {
            if let cssCode = title {
                title = String.fontAwesomeIcon(code: cssCode)
            }
        }
        updateFontAttributes { (state, font) in
            var attributes = titleTextAttributes(for: state) ?? [:]
            attributes[NSFontAttributeName] = font
            setTitleTextAttributes(attributes, for: state)
        }
    }
    
}

extension FontAwesomeBarButtonItem: FontAwesomeTextRepresentable {
    
    var isTextCSSCode: Bool {
        return isFontAwesomeCSSCode
    }
    
    var textSize: CGFloat {
        return size
    }
    
    static func supportedStates() -> [UIControlState] {
        return [.normal, .highlighted, .disabled]
    }
    
}
