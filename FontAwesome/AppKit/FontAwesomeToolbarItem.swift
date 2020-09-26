// FontAwesomeToolbarItem.swift
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

open class FontAwesomeToolbarItem: NSToolbarItem, FontAwesomeRepresentable {

    @IBInspectable
    open var iconCode: String {
        get { return button?.iconCode ?? "" }
        set {
            assert(button != nil)
            button?.iconCode = newValue
        }
    }
    @IBInspectable
    open var styleName: String {
        get { return button?.styleName ?? "" }
        set {
            assert(button != nil)
            button?.styleName = newValue
        }
    }
    /// The extra padding applied to the button's size, when applicable.
    ///
    /// This property has a default value of `.zero`.
    @IBInspectable
    open var extraPadding: NSSize {
        get { return button?.extraPadding ?? .zero }
        set {
            assert(button != nil)
            button?.extraPadding = newValue
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
        get { return button?.iconOffset ?? .zero }
        set {
            assert(button != nil)
            button?.iconOffset = newValue
        }
    }
    /// The font point size of the icon when the toolbar is in default/regular size mode  (i.e. `sizeMode` has a value of `.default`
    /// or `.regular`).
    @IBInspectable
    open var iconPointSize: CGFloat = 0 {
        didSet {
            if !(toolbar?.sizeMode == .small) {
                updateSize()
            }
        }
    }
    /// A convience setter for `iconSize` accessible through Interface Builder.
    ///
    /// Possible values are `"small"` or `"s"`, `"medium"` or `"m"`, and `"large"` or `"l"`.
    ///
    /// - Important: The usage of `iconSize` should be preferred for programmatic consumption.
    @IBInspectable
    open var iconSizeStringValue: String {
        get { return button?.iconSizeStringValue ?? "" }
        set {
            assert(button != nil)
            button?.iconSizeStringValue = newValue
        }
    }
    /// The font point size of the icon when the toolbar is in small size mode  (i.e. `sizeMode` has a value of `.small`).
    ///
    /// When zero, the `iconPointSize` will be used.
    ///
    /// This property has a default value of `0`.
    @IBInspectable
    open var smallIconPointSize: CGFloat = 0 {
        didSet {
            if toolbar?.sizeMode == .small {
                updateSize()
            }
        }
    }
    /// The pixel-perfect point width of the toolbar item's button.
    ///
    /// When zero, the width of the button will be sized to the minimum needed to contain the icon.
    ///
    /// This property has a default value of `38`.
    ///
    /// - Note: An extra _pixel_ may be added to the width when necessary to properly center the image within the button.
    @IBInspectable
    open var width: CGFloat = 38 {
        didSet { updateSize() }
    }

    /// The size of the Font Awesome icon.
    ///
    /// A value of `nil` implies the receiver assumes the value of `FontAwesomeConfig.defaultButtonIconSize`.
    ///
    /// This property has a default value of `nil`.
    ///
    /// - Note: The icon sizes corresponding to the values of `FontAwesomeIconSize` may not be aesthetically pleasing for
    ///         certain icons. Want better control? Your options include using `iconPointSize`/`smallIconPointSize` or
    ///         overriding `FontAwesomeButton.iconHeight`.
    open var iconSize: FontAwesomeIconSize? {
        get { return button?.iconSize }
        set {
            assert(button != nil)
            button?.iconSize = newValue
        }
    }

    private var buttonImageKeyValueObservation: NSKeyValueObservation?

    /// Returns a point value that is added to the item's minimum and maximum width, when appropriate.
    ///
    /// This property is used to atone for any impurities in AppKit's geometry in order to attain pixel perfect button width.
    open var bezelWidthAdjustment: CGFloat {
        return FALayoutManager.isHighResolutionDisplay ? 1 : 0
    }
    /// Whether the receiver has been configured.
    open var isConfigured: Bool {
        return button?.isInToolbar ?? false
    }
    /// Returns a value that is subtracted from `width` to obtain the button width for use when the toolbar is in _small_ size mode.
    ///
    /// This property has a default return value of `5` for high-resolution scaled display modes and `2` for all others. This is
    /// consistent with the width change in native toolbar buttons.
    open var smallSizeModeAdjustment: CGFloat {
        return floor(2.5 * FALayoutManager.backingScaleFactor)
    }

    public var button: FontAwesomeButton? {
        return view as? FontAwesomeButton
    }

    public init(itemIdentifier: NSToolbarItem.Identifier,
                icon: FontAwesome,
                style: FontAwesomeStyle = .brands) {
        super.init(itemIdentifier: itemIdentifier)

        commonInit()

        self.icon = icon
        self.style = style
    }

    public override init(itemIdentifier: NSToolbarItem.Identifier) {
        super.init(itemIdentifier: itemIdentifier)

        view = createButton()
    }

    open override func awakeFromNib() {
        super.awakeFromNib()

        commonInit()
    }

    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()

        commonInit()
    }

    open func commonInit() {
        if button == nil {
            view = createButton()
        }

        guard let button = button
            else { return }

        button.isInToolbar = true
        button.identifier = NSUserInterfaceItemIdentifier(itemIdentifier.rawValue)
        button.bezelStyle = .texturedRounded
        button.isEnabled = isEnabled
        button.action = action
        button.target = target

        updateSize()

        // Note: We invoke `updateSize()` in response to any observed change to the
        //       button's `image` property, which will ensure the image is horizontally
        //       centered in the button equidistantly.
        buttonImageKeyValueObservation = button.buttonCell?.observe(\.image) { [weak self] (_, _) in
            DispatchQueue.main.async {
                self?.updateSize()
            }
        }
    }

    open func createButton() -> FontAwesomeButton {
        return FontAwesomeButton()
    }

    open func fittingSize() -> NSSize {
        guard let button = button
            else { return .zero }

        if button.needsLayout {
            button.layoutSubtreeIfNeeded()
        }

        var size = NSSize(width: extraPadding.width,
                          height: button.fittingSize.height + extraPadding.height)
        if width > 0 {
            size.width += width + bezelWidthAdjustment

            if toolbar?.sizeMode == .small {
                size.width -= smallSizeModeAdjustment
            }
        } else {
            size.width += FALayoutManager.fittingSize(for: button).width
        }

        return button.adjustingSize(size)
    }

    open func updateSize() {
        guard isConfigured
            else { return }

        button?.iconPointSize = (toolbar?.sizeMode == .small && smallIconPointSize > 0)
            ? smallIconPointSize
            : iconPointSize

        minSize = fittingSize()
        maxSize = minSize
    }

    open override func validate() {
        guard isConfigured
            else { return }

        if let action = action,
            let aTarget = NSApp.target(forAction: action, to: target, from: self) {
            isEnabled = (aTarget as? NSToolbarItemValidation)?.validateToolbarItem(self) ?? true
        } else {
            isEnabled = false
        }

        super.validate()
    }

}
