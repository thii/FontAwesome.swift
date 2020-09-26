// FontAwesomeButton.swift
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
open class FontAwesomeButton: NSButton, FontAwesomeTextRepresentable {

    public typealias ButtonCell = FontAwesomeButtonCell

    @IBInspectable
    open var iconCode: String {
        get { return buttonCell?.iconCode ?? FontAwesome.fontAwesomeFlag.rawValue }
        set {
            assert(buttonCell != nil)
            buttonCell?.iconCode = newValue
            needsLayout = true
        }
    }
    @IBInspectable
    open var styleName: String {
        get { return buttonCell?.styleName ?? FontAwesomeStyle.brands.rawValue }
        set {
            assert(buttonCell != nil)
            buttonCell?.styleName = newValue
            needsLayout = true
        }
    }
    /// The extra padding applied to the button's size, when applicable.
    ///
    /// This property has a default value of `.zero`.
    @IBInspectable
    open var extraPadding: NSSize {
        get { return buttonCell?.extraPadding ?? .zero }
        set {
            assert(buttonCell != nil)
            buttonCell?.extraPadding = newValue
            needsLayout = true
        }
    }
    /// The point offset for the icon position.
    ///
    /// A positive `y` value indicates a shift above the text baseline, and a negative value indicates a shift
    /// below the text baseline. Similarly, a positive `x` value indicates a horizontal shift towards the trailing
    /// edge, and a negative value indicates a shift towards the leading edge.
    ///
    /// This property has a default value of `.zero`.
    @IBInspectable
    open var iconOffset: NSPoint {
        get { return buttonCell?.iconOffset ?? .zero }
        set {
            assert(buttonCell != nil)
            buttonCell?.iconOffset = newValue
            needsLayout = true
        }
    }
    @IBInspectable
    open var iconPointSize: CGFloat {
        get { return buttonCell?.iconPointSize ?? 0 }
        set {
            assert(buttonCell != nil)
            buttonCell?.iconPointSize = newValue
            needsLayout = true
        }
    }
    /// The size of the Font Awesome icon.
    ///
    /// A value of `nil` implies the receiver assumes the value of `FontAwesomeConfig.defaultButtonIconSize`.
    ///
    /// This property has a default value of `nil`.
    ///
    /// - Note: The icon sizes corresponding to the values of `FontAwesomeIconSize` may not be aesthetically pleasing for
    ///         certain icons. Want better control? Your options include using `iconPointSize` or overriding
    ///         `FontAwesomeButton.iconHeight`.
    open var iconSize: ButtonCell.IconSize? {
        get { return buttonCell?.iconSize }
        set {
            assert(buttonCell != nil)
            buttonCell?.iconSize = newValue
            needsLayout = true
        }
    }
    /// A convience setter for `iconSize` accessible through Interface Builder.
    ///
    /// Possible values are `"small"` or `"s"`, `"medium"` or `"m"`, and `"large"` or `"l"`.
    ///
    /// - Important: The usage of `iconSize` should be preferred for programmatic consumption.
    @IBInspectable
    open var iconSizeStringValue: String {
        get { return (iconSize ?? FontAwesomeConfig.defaultButtonIconSize).rawValue }
        set { iconSize = ButtonCell.IconSize(stringValue: newValue) }
    }
    /// Whether the receiver is inside of a toolbar.
    ///
    /// This property has a default value of `false`.
    open var isInToolbar: Bool {
        get { return buttonCell?.isInToolbar ?? false }
        set {
            assert(buttonCell != nil)
            buttonCell?.isInToolbar = newValue
        }
    }

    open var buttonCell: ButtonCell? {
        return cell as? ButtonCell
    }
    /// Returns the height of the Font Awesome icon used by the button.
    ///
    /// In computing the height, the default implementation depends on the values of the `controlSize`, `iconSize`, and
    /// `isInToolbar` properties.
    ///
    /// - Note: The heights returned may not be aesthetically pleasing for certain icons. Want better control? Your options include
    ///         using `iconPointSize` or overriding `FontAwesomeButton.iconHeight`.
    open var iconHeight: CGFloat {
        // Note: `NSFont.systemFontSize` will typically be 13. The raw value of
        //       `NSControl.ControlSize`'s are 0, 1, and 2 for `.regular`, `.small`,
        //        and `.mini`, respectively. In all, this translates to 13, 12, and
        //        11 for `.regular`, `.small`, and `.mini`, respectively.
        var height = NSFont.systemFontSize - CGFloat(controlSize.rawValue)

        switch iconSize ?? FontAwesomeConfig.defaultButtonIconSize {
        case .large:
            height += 2
        case .small:
            height -= 2
        default: ()
        }

        return height + (isInToolbar ? 2 : 0)
    }
    /// Returns the toolbar item's identifier that the receiver belongs to.
    ///
    /// - Important: The receiver must be in a toolbar item; otherwise, the return value is invalid.
    open var toolbarItemIdentifier: NSToolbarItem.Identifier {
        assert(isInToolbar)
        return NSToolbarItem.Identifier(identifier?.rawValue ?? "")
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

    open func commonInit() {
        guard !(cell is ButtonCell)
            else { return }

        cell = createCell()
        setButtonType(.momentaryPushIn)
        bezelStyle = .rounded
    }

    open func createCell() -> ButtonCell {
        return ButtonCell(imageCell: nil)
    }

    open func adjustingSize(_ size: NSSize) -> NSSize {
        guard let imageSize = image?.size
            else { return size }

        var mutableSize = size
        let insets = alignmentRectInsets
        let pixelPoint = FALayoutManager.pixelPointValue
        let estimatedSize = size.subtracting(width: insets.left + insets.right + imageSize.width,
                                             height: insets.top + insets.bottom + imageSize.height)

        if !bezelStyle.hasFixedWidth
            && estimatedSize.width.truncatingRemainder(dividingBy: 2 * pixelPoint) != 0 {
            // Equidistant horizontal centering.
            mutableSize.width += pixelPoint
        }

        if !bezelStyle.hasFixedHeight
            && estimatedSize.height.truncatingRemainder(dividingBy: 2 * pixelPoint) != 0 {
            // Equidistant vertical centering.
            mutableSize.height += pixelPoint
        }

        return mutableSize
    }

    open func bezelRect(forBounds rect: NSRect) -> NSRect {
        if let bezelView = subviews.first, bezelView.className.hasSuffix("BezelView") {
            return bezelView.alignmentRect(forFrame: rect)
        }

        var bezelFrame = alignmentRect(forFrame: rect)

        if isFlipped {
            bezelFrame.origin.y = rect.height - bezelFrame.maxY
        }

        return bezelFrame
    }

    open override func layout() {
        updateFontIfNeeded()

        super.layout()
    }

    // MARK: - FontAwesomeTextRepresentable

    open var maxIconSize: NSSize {
        return iconPointSize > 0
            ? NSSize(width: 0, height: iconPointSize)
            : NSSize(width: 1000, height: iconHeight)
    }

    open func didUpdateFont() {
        guard let icon = icon, let font = font
            else { return }

        image = Image.fontAwesomeIcon(name: icon, font: font, textColor: .black, size: maxIconSize)
        assert(image!.isTemplate)

        // Condition necessary for proper behavior of buttons in toolbar items in macOS 10.13.
        if !isInToolbar {
            sizeToFit()
        }
    }

}
