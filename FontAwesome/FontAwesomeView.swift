// FontAwesomeView.swift
//
// Copyright (c) 2014-present FontAwesome.swift contributors
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

#if canImport(UIKit)
import UIKit
#else
import AppKit
#endif

/// A view for FontAwesome icons.
@IBDesignable public class FontAwesomeView: View {

    @IBInspectable
    public var iconCode: String = "" {
        didSet {
            #if canImport(UIKit)
            self.iconView.text = String.fontAwesomeIcon(code: iconCode)
            #else
            self.iconView.iconCode = iconCode
            #endif
        }
    }

    @IBInspectable
    public var styleName: String = "Brands" {
        didSet {
            #if canImport(AppKit)
            self.iconView.styleName = styleName
            #endif
        }
    }

    private var iconView = Label()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }

    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupViews()
    }

    /// Add a label subview containing FontAwesome icon
    func setupViews() {
        #if canImport(UIKit)
        // Fits icon in the view
        self.iconView.textAlignment = NSTextAlignment.center
        self.iconView.text = String.fontAwesomeIcon(code: self.iconCode)
        self.iconView.textColor = self.tintColor
        #else
        self.iconView.iconCode = self.iconCode
        self.iconView.styleName = self.styleName
        #endif
        self.addSubview(iconView)

        #if canImport(AppKit)
        self.iconView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.iconView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.iconView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        #endif
    }

    #if canImport(UIKit)
    override public func tintColorDidChange() {
        self.iconView.textColor = self.tintColor
    }
    #endif

    #if canImport(UIKit)
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = true
        let size = bounds.size.width < bounds.size.height ? bounds.size.width : bounds.size.height
        let style = FontAwesomeStyle(rawValue: styleName.lowercased()) ?? .solid
        self.iconView.font = Font.fontAwesome(ofSize: size, style: style)
        self.iconView.frame = CGRect(origin: .zero, size: CGSize(width: bounds.size.width, height: bounds.size.height))
    }
    #else
    override open func layout() {
        self.iconView.needsLayout = true
        super.layout()
    }
    #endif

}

#if canImport(AppKit)
extension FontAwesomeView: FontAwesomeRepresentable { }
#endif
