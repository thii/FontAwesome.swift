// FontAwesomeLayoutManager.swift
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

/// The convenience variable for the shared layout manager instance.
///
/// - Note: This property is equivalent to calling `FontAwesomeLayoutManager.shared`.
@inlinable
internal var FALayoutManager: FontAwesomeLayoutManager {
    return FontAwesomeLayoutManager.shared
}

/// An object that coordinates the layout and display of Font Awesome icons.
public class FontAwesomeLayoutManager {

    /// Returns the shared instance of the layout manager.
    public static var shared = FontAwesomeLayoutManager()

    public let textStorage: NSTextStorage

    private let textStorageLock: NSLock = NSLock()

    public lazy var sizingButton: NSButton = { NSButton() }()

    /// The backing store pixel scale factor.
    open var backingScaleFactor: CGFloat {
        return NSApp?.windows.first?.backingScaleFactor ?? NSScreen.main?.backingScaleFactor ?? 2
    }
    /// Returns the point value of a single pixel.
    open var pixelPointValue: CGFloat {
        return 1 / backingScaleFactor
    }
    /// Returns whether the application's initial window (or main screen) uses a high-resolution scaled display mode.
    open var isHighResolutionDisplay: Bool {
        return backingScaleFactor == 2
    }

    public var layoutManager: NSLayoutManager {
        return textStorage.layoutManagers[0]
    }
    public var textContainer: NSTextContainer {
        return layoutManager.textContainers[0]
    }

    public init() {
        let textContainer = NSTextContainer()
        textContainer.lineFragmentPadding = 0

        let layoutManager = NSLayoutManager()
        layoutManager.typesetterBehavior = .behavior_10_4
        layoutManager.addTextContainer(textContainer)

        textStorage = NSTextStorage()
        textStorage.addLayoutManager(layoutManager)
    }

    open func draw(_ attributedString: NSAttributedString, at point: NSPoint) {
        textStorageLock.lock()
        defer { textStorageLock.unlock() }

        textStorage.setAttributedString(attributedString)
        let iconGlyphRange = layoutManager.glyphRange(for: textContainer)
        layoutManager.drawBackground(forGlyphRange: iconGlyphRange, at: point)
        layoutManager.drawGlyphs(forGlyphRange: iconGlyphRange, at: point)
    }

    open func fittingSize(for button: NSButton) -> NSSize {
        if button.needsLayout {
            button.layoutSubtreeIfNeeded()
        }

        sizingButton.controlSize = button.controlSize
        sizingButton.bezelStyle = button.bezelStyle
        sizingButton.image = button.image

        sizingButton.sizeToFit()

        return sizingButton.frame.size
    }

    open func imageBounds(of attributedString: NSAttributedString) -> Rect {
        return CTLineGetImageBounds(CTLineCreateWithAttributedString(attributedString), nil)
    }

    open func lineHeight(for font: Font) -> CGFloat {
        return layoutManager.defaultLineHeight(for: font)
    }

    open func typographicBounds(of attributedString: NSAttributedString) -> Rect {
        textStorageLock.lock()
        defer { textStorageLock.unlock() }

        textStorage.setAttributedString(attributedString)

        let iconGlyphRange = layoutManager.glyphRange(for: textContainer)
        return layoutManager.boundingRect(forGlyphRange: iconGlyphRange, in: textContainer)
    }

}
