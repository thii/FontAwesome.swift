// FontAwesomeButtonCell.swift
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

open class FontAwesomeButtonCell: NSButtonCell {

    public typealias IconSize = FontAwesomeIconSize

    /// See `FontAwesomeButton.extraPadding`'s documentation.
    public var extraPadding: NSSize = .zero
    /// See `FontAwesomeButton.iconCode`'s documentation.
    public var iconCode: String = FontAwesome.fontAwesomeFlag.rawValue
    /// See `FontAwesomeButton.iconSize`'s documentation.
    public var iconSize: IconSize?
    /// See `FontAwesomeButton.iconOffset`'s documentation.
    public var iconOffset: NSPoint = .zero
    /// See `FontAwesomeButton.iconPointSize`'s documentation.
    public var iconPointSize: CGFloat = 0
    /// See `FontAwesomeButton.isInToolbar`'s documentation.
    public var isInToolbar: Bool = false
    /// See `FontAwesomeButton.styleName`'s documentation.
    public var styleName: String = FontAwesomeStyle.brands.rawValue

    /// Mirrors `NSButtonCell`'s private `_imageVerticalAdjustmentForBezel` property.
    open var verticalImageAdjustmentForBezel: CGFloat {
        if FALayoutManager.isHighResolutionDisplay {
            if bezelStyle == .texturedRounded {
                return FALayoutManager.pixelPointValue
            }
        } else {
            switch bezelStyle {
            case .regularSquare,
                 .disclosure,
                 .shadowlessSquare,
                 .texturedSquare,
                 .helpButton,
                 .smallSquare,
                 .texturedRounded,
                 .roundRect,
                 .recessed,
                 .roundedDisclosure:
                return FALayoutManager.pixelPointValue
            default: ()
            }
        }

        return 0
    }

    public var fontAwesomeButton: FontAwesomeButton? {
        return controlView as? FontAwesomeButton
    }

    open override var cellSize: NSSize {
        return adjustingSize(super.cellSize.adding(size: extraPadding))
    }

    public override init(imageCell image: NSImage?) {
        super.init(imageCell: image)

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
        imagePosition = .imageOnly
        imageScaling = .scaleNone
    }

    open func adjustingSize(_ size: NSSize) -> NSSize {
        return fontAwesomeButton?.adjustingSize(size) ?? size
    }

    open func bezelRect(forBounds rect: NSRect) -> NSRect {
        return fontAwesomeButton?.bezelRect(forBounds: rect) ?? rect
    }

    open override func imageRect(forBounds rect: NSRect) -> NSRect {
        guard let image = image
            else { return super.imageRect(forBounds: rect) }

        var imageRect = bezelRect(forBounds: rect)
        imageRect.origin.x += (iconOffset.x
            + ((imageRect.width - image.size.width) / 2))
            .roundUpToPixel()
        imageRect.origin.y += (iconOffset.y
            + ((imageRect.height - image.size.height) / 2)
            + verticalImageAdjustmentForBezel)
            .roundUpToPixel()
        imageRect.size = image.size
        return imageRect
    }

}
