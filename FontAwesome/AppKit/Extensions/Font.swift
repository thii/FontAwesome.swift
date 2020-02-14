// Font.swift
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

import AppKit

extension Font {

    /// Returns the font point size that fits a Font Awesome icon within a bounding size.
    ///
    /// - Parameters:
    ///   - icon: The Unicode Font Awesome icon.
    ///   - style: The font style.
    ///   - maxSize: The maximum size.
    ///   - usingTypographicBounds: Whether to use the glyph's typographic bounds instead of the image
    ///   bounds. When true, the icon will be typeset by the system.
    ///
    /// - Returns: The font point size that fits `icon` with `style` inside `maxSize`.
    static public func fontAwesomePointSize(of icon: String,
                                            with style: FontAwesomeStyle,
                                            fitting maxSize: CGSize,
                                            usingTypographicBounds: Bool = false) -> CGFloat {
        let arbitraryPointSize: CGFloat = 100
        let font = Font.fontAwesome(ofSize: arbitraryPointSize, style: style)
        let attributedString = NSMutableAttributedString(string: icon, attributes: [.font: font])
        let adjustment = usingTypographicBounds ? 2 * FALayoutManager.pixelPointValue : 0
        let adjustedMaxSize = NSSize(width: maxSize.width - adjustment, height: maxSize.height)

        let iconSize = usingTypographicBounds
            ? FALayoutManager.typographicBounds(of: attributedString).size
            : FALayoutManager.imageBounds(of: attributedString).size

        let heightRatio = iconSize.height / arbitraryPointSize
        let widthRatio = iconSize.width / arbitraryPointSize
        let heightMaxPointSize = adjustedMaxSize.height / heightRatio
        let widthMaxPointSize = adjustedMaxSize.width / widthRatio
        let minimumPointSize = min(heightMaxPointSize, widthMaxPointSize).roundDownToPixel()
        return max(minimumPointSize, 0.1)
    }

}
