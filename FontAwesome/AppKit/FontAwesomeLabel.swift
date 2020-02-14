// FontAwesomeLabel.swift
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

@IBDesignable
open class FontAwesomeLabel: NSTextField {

    public typealias TextFieldCell = FontAwesomeTextFieldCell

    @IBInspectable
    open var iconCode: String {
        get { return textFieldCell?.iconCode ?? FontAwesome.fontAwesomeFlag.rawValue }
        set {
            assert(textFieldCell != nil)
            textFieldCell?.iconCode = newValue
            needsLayout = true
        }
    }
    @IBInspectable
    open var styleName: String {
        get { return textFieldCell?.styleName ?? FontAwesomeStyle.brands.rawValue }
        set {
            assert(textFieldCell != nil)
            textFieldCell?.styleName = newValue
            needsLayout = true
        }
    }
    @IBInspectable
    open var iconPointSize: CGFloat {
        get { return textFieldCell?.iconPointSize ?? 0 }
        set {
            assert(textFieldCell != nil)
            textFieldCell?.iconPointSize = newValue
            needsLayout = true
        }
    }

    public var textFieldCell: TextFieldCell? {
        return cell as? TextFieldCell
    }

    open override var intrinsicContentSize: NSSize {
        return cell?.cellSize ?? .zero
    }

    public override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)

        commonInit()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)

        commonInit()
    }

    public init(icon: FontAwesome, style: FontAwesomeStyle = .brands) {
        super.init(frame: .zero)

        commonInit()

        self.icon = icon
        self.style = style
    }

    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()

        commonInit()
        layout()
    }

    open func commonInit() {
        if !(cell is TextFieldCell) {
            cell = createCell()
        }

        stringValue = fontAwesomeIcon ?? ""
    }

    open func createCell() -> TextFieldCell {
        return TextFieldCell(textCell: "")
    }

    open override func layout() {
        updateFontIfNeeded()

        super.layout()
    }

}

extension FontAwesomeLabel: FontAwesomeTextRepresentable {

    open var maxIconSize: NSSize {
        return superview is FontAwesomeView
            ? superview!.bounds.size
            : bounds.size
    }

    open var usesTypographicBounds: Bool {
        return true
    }

    open func didUpdateFont() {
        sizeToFit()
    }

}
