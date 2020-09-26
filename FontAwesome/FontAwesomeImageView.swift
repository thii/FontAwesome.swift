// FontAwesomeImageView.swift
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

@IBDesignable public class FontAwesomeImageView: ImageView {

    @IBInspectable public var cssCode: String = "fa-font-awesome-flag"
    // Note: Using the `Color` type alias breaks the IBDesignable functionality.
    //       Hence, the need for explicit definitions.
    #if canImport(UIKit)
    @IBInspectable public var imageColor: UIColor = .black
    @IBInspectable public var imageBackgroundColor: UIColor = .clear
    #else
    @IBInspectable public var imageColor: NSColor = .black
    @IBInspectable public var imageBackgroundColor: NSColor = .clear
    #endif
    @IBInspectable public var styleName: String = "Brands"
    #if canImport(AppKit) && !targetEnvironment(macCatalyst)
    /// The (exclusive) total horizontal and vertical change in points tolerated before the resolution of the backing
    /// image (of the Font Awesome icon) is updated.
    ///
    /// Generating the icon image is a computationally intensive operation with a time complexity of _O(n²)_. Such
    /// facets behoove us to minimize image generation, which can be accomplished by increasing the tolerance. On
    /// the other hand, setting a value of `0` will result in image generation upon each invocation of `layout()`.
    ///
    /// This property has a default value of `10`.
    @IBInspectable public var sizeChangeTolerance: CGFloat = 10
    #endif

    #if canImport(AppKit) && !targetEnvironment(macCatalyst)
    /// The size that was last used to generate the Font Awesome icon image.
    private var lastBoundsUsedForImage: NSSize = .zero

    /// Returns the total point change to the size of the receiver since the last image was generated.
    open var grossSizeChangeSinceImageGeneration: CGFloat {
        return abs(bounds.width - lastBoundsUsedForImage.width)
            + abs(bounds.height - lastBoundsUsedForImage.height)
    }
    #endif

    #if canImport(AppKit) && !targetEnvironment(macCatalyst)
    override public init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        commonInit()
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    convenience public init(icon: FontAwesome, style: FontAwesomeStyle = .brands) {
        self.init()
        cssCode = icon.rawValue
        styleName = style.rawValue
    }

    public func commonInit() {
        if cell == nil {
            cell = NSImageCell(imageCell: nil)
            imageScaling = .scaleProportionallyUpOrDown
        }
    }
    #endif

    public override func awakeFromNib() {
        super.awakeFromNib()
        #if canImport(AppKit) && !targetEnvironment(macCatalyst)
        commonInit()
        #endif
        useFontAwesomeImage()
    }

    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        #if canImport(AppKit) && !targetEnvironment(macCatalyst)
        commonInit()
        #endif
        useFontAwesomeImage()
    }

    private func useFontAwesomeImage() {
        createImages { (img, _) in
            image = img
        }

        #if canImport(AppKit) && !targetEnvironment(macCatalyst)
        lastBoundsUsedForImage = bounds.size
        #endif
    }

    #if canImport(AppKit) && !targetEnvironment(macCatalyst)
    open override func viewDidEndLiveResize() {
        super.viewDidEndLiveResize()

        useFontAwesomeImage()
    }

    open override func viewDidChangeBackingProperties() {
        super.viewDidChangeBackingProperties()

        useFontAwesomeImage()
    }

    open override func layout() {
        if grossSizeChangeSinceImageGeneration >= sizeChangeTolerance {
            useFontAwesomeImage()
        }

        super.layout()
    }
    #endif

}

extension FontAwesomeImageView: FontAwesomeImageRepresentable {

    var imageWidth: CGFloat {
        return frame.width
    }

    var imageConfigs: [ImageConfig] {
        guard let style = FontAwesomeStyle(rawValue: styleName.lowercased()) else { return [] }
        return [(cssCode, style, imageColor, imageBackgroundColor)]
    }

}
