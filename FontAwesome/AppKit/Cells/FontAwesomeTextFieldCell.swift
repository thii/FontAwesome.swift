// FontAwesomeTextFieldCell.swift
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

open class FontAwesomeTextFieldCell: NSTextFieldCell {

    /// See `FontAwesomeLabel.iconCode`'s documentation.
    public var iconCode: String = FontAwesome.fontAwesomeFlag.rawValue {
        didSet { stringValue = fontAwesomeLabel?.fontAwesomeIcon ?? "" }
    }
    /// See `FontAwesomeLabel.iconPointSize`'s documentation.
    public var iconPointSize: CGFloat = 0
    /// See `FontAwesomeLabel.styleName`'s documentation.
    public var styleName: String = FontAwesomeStyle.brands.rawValue

    public var fontAwesomeLabel: FontAwesomeLabel? {
        return controlView as? FontAwesomeLabel
    }

    public override init(textCell string: String) {
        super.init(textCell: string)

        commonInit()
    }

    public required init(coder: NSCoder) {
        super.init(coder: coder)
    }

    open override func awakeFromNib() {
        super.awakeFromNib()

        commonInit()
    }

    open func commonInit() {
        isSelectable = false
        isBezeled = false
        drawsBackground = false
    }

    open override var cellSize: NSSize {
        var bounds = FALayoutManager.typographicBounds(of: attributedStringValue).size
        bounds.width = (bounds.width + (2 * FALayoutManager.pixelPointValue)).roundUpToPixel()
        return bounds
    }

    open override func drawInterior(withFrame cellFrame: NSRect, in controlView: NSView) {
        let imageBounds = FALayoutManager.imageBounds(of: attributedStringValue)
        let x = ((cellFrame.width - imageBounds.width) / 2).roundDownToPixel()
        FALayoutManager.draw(attributedStringValue, at: CGPoint(x: x, y: 0))
    }

}
