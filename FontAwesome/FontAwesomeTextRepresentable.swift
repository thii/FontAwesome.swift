// FontAwesomeTextRepresentable.swift
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
#endif

#if canImport(UIKit)
protocol FontAwesomeTextRepresentable: FontAwesomeStateRequirement {

    var textSize: CGFloat { get }
    var isTextCSSCode: Bool { get }
    var fontStyle: FontAwesomeStyle { get }

    func updateText(_ updateTextBlock: () -> Void)
    func updateFontAttributes(forStates stateBlock: (UIControl.State, UIFont) -> Void)

}

extension FontAwesomeTextRepresentable {

    public func updateText(_ updateTextBlock: () -> Void) {
        guard isTextCSSCode else {
            return
        }

        updateTextBlock()
    }

    public func updateFontAttributes(forStates stateBlock: (UIControl.State, UIFont) -> Void) {
        let states = type(of: self).supportedStates()
        let font = UIFont.fontAwesome(ofSize: textSize, style: fontStyle)

        for state in states {
            stateBlock(state, font)
        }
    }
}
#else
public protocol FontAwesomeTextRepresentable: FontAwesomeRepresentable {

    /// The font point size of the icon.
    ///
    /// When zero, the icon is sized to fit within the receiver's bounds. This property has a default value of `0`.
    var iconPointSize: CGFloat { get }
    /// The maximum size of the Font Awesome icon.
    ///
    /// This value is used along with `usesTypographicBounds` to compute a fitting font point size.
    var maxIconSize: NSSize { get }
    /// Whether to use the glyph's typographic bounds instead of the image bounds.
    ///
    /// When true, the icon will be typeset by the system. This includes various additional metrics, which results in a font point size
    /// that can be drawn wholly within `maxIconSize`.
    var usesTypographicBounds: Bool { get }
    var font: Font? { get set }

    /// Updates the receiver's Font Awesome font, if needed.
    func updateFontIfNeeded()
    /// Called when the receiver's Font Awesome font is updated as a result of invoking `updateFontIfNeeded()`.
    func didUpdateFont()

}

public extension FontAwesomeTextRepresentable {

    var icon: FontAwesome? {
        get { return FontAwesome(name: iconCode) }
        set {
            iconCode = newValue?.rawValue ?? ""
            // Forces `updateFontIfNeeded()` to call `didUpdateFont()`, which will
            // render the new icon.
            font = nil
        }
    }

    var usesTypographicBounds: Bool {
        return false
    }

    func updateFontIfNeeded() {
        guard let stringValue = fontAwesomeIcon
            else { return }

        let fontAwesomeStyle = style
        let fontSize = iconPointSize > 0
            ? iconPointSize
            : Font.fontAwesomePointSize(of: stringValue,
                                        with: fontAwesomeStyle,
                                        fitting: maxIconSize,
                                        usingTypographicBounds: usesTypographicBounds)
        let newFont = Font.fontAwesome(ofSize: fontSize, style: fontAwesomeStyle)
        guard newFont != font
            else { return }

        font = newFont
        didUpdateFont()
    }

    func didUpdateFont() { }

}
#endif
