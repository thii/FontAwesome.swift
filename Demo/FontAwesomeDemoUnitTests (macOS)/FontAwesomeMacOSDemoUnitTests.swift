// FontAwesomeMacOSDemoUnitTests.swift
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

import XCTest
@testable import FontAwesome
@testable import FontAwesomeDemoMacOS

class FontAwesomeMacOSDemoUnitTests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false

        if FontAwesomeConfig.defaultButtonIconSize != .medium {
            FontAwesomeConfig.defaultButtonIconSize = .medium
            // Force re-layout.
            toolbar?.sizeMode = .regular
            RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.5))
        }
    }

    func testButton() {
        let size = isHighResolutionDisplay
            ? NSSize(width: 14, height: 13.5)
            : NSSize(width: 13, height: 13)
        let button: FontAwesomeButton = viewController.fontAwesomeButton

        XCTAssertFalse(button.isInToolbar)
        XCTAssertEqual(button.image?.size, size)
    }

    func testLabel() {
        let label: FontAwesomeLabel = viewController.fontAwesomeLabel

        XCTAssertEqual(label.iconPointSize, 50)
        XCTAssertEqual(label.stringValue, FontAwesome.github.unicode)
        XCTAssertEqual(label.font?.pointSize, 50)
        XCTAssertEqual(label.bounds.size, NSSize(width: isHighResolutionDisplay ? 52.5 : 53,
                                                 height: 61))
    }

    func testView() {
        let size = isHighResolutionDisplay
            ? NSSize(width: 138.5, height: 167)
            : NSSize(width: 141, height: 170)
        let labelSubview = viewController.fontAwesomeView.subviews.first as? FontAwesomeLabel

        XCTAssertNotNil(labelSubview)
        XCTAssertEqual(labelSubview!.stringValue, FontAwesome.github.unicode)
        XCTAssertEqual(labelSubview!.font?.pointSize, size.width)
        XCTAssertEqual(labelSubview!.bounds.size, size)
    }

    func testRegularToolbarItems() {
        setToolbar(sizeMode: .regular)
        AssertSizesOfToolbarItems()
    }

    func testSmallToolbarItems() {
        setToolbar(sizeMode: .small)
        AssertSizesOfToolbarItems()
    }

    func testRegularFirstToolbarItemCycle() {
        setToolbar(sizeMode: .regular)
        AssertSizesOfToolbarItems()

        setToolbar(sizeMode: .small)
        AssertSizesOfToolbarItems()

        setToolbar(sizeMode: .regular)
        AssertSizesOfToolbarItems()

        setToolbar(sizeMode: .small)
        AssertSizesOfToolbarItems()
    }

    func testSmallFirstToolbarItemCycle() {
        setToolbar(sizeMode: .small)
        AssertSizesOfToolbarItems()

        setToolbar(sizeMode: .regular)
        AssertSizesOfToolbarItems()

        setToolbar(sizeMode: .small)
        AssertSizesOfToolbarItems()

        setToolbar(sizeMode: .regular)
        AssertSizesOfToolbarItems()
    }

    func testIconHeight() {
        let button = FontAwesomeButton(icon: .fontAwesomeFlag)

        button.controlSize = .regular
        XCTAssertEqual(button.iconHeight, 13)

        button.controlSize = .small
        XCTAssertEqual(button.iconHeight, 12)

        button.controlSize = .mini
        XCTAssertEqual(button.iconHeight, 11)
    }

    func testEquatable() {
        XCTAssertEqual(NSToolbar.SizeMode.regular, NSToolbar.SizeMode.default)
        XCTAssertTrue(NSToolbar.SizeMode.regular == NSToolbar.SizeMode.default)
        XCTAssertEqual(NSToolbar.SizeMode.small, NSToolbar.SizeMode.small)
        XCTAssertTrue(NSToolbar.SizeMode.small == NSToolbar.SizeMode.small)
        XCTAssertNotEqual(NSToolbar.SizeMode.small, NSToolbar.SizeMode.default)
        XCTAssertTrue(NSToolbar.SizeMode.small != NSToolbar.SizeMode.default)
        XCTAssertNotEqual(NSToolbar.SizeMode.small, NSToolbar.SizeMode.regular)
        XCTAssertTrue(NSToolbar.SizeMode.small != NSToolbar.SizeMode.regular)
    }

    func testImageVerticalAdjustmentForAllBezels() {
        let button = FontAwesomeButton()

        for bezelStyle in NSButton.BezelStyle.allCases {
            button.bezelStyle = bezelStyle

            let value = button.cell?.value(forKey: "_imageVerticalAdjustmentForBezel") as? CGFloat
            XCTAssertEqual(button.buttonCell?.verticalImageAdjustmentForBezel,
                           value,
                           "`imageVerticalAdjustment(for:)` does not return the expected "
                            + "value of \(value ?? -1) for the '\(bezelStyle)' bezel style")
        }
    }

    // MARK: - Test Misc.

    var toolbar: NSToolbar? {
        return window?.toolbar
    }
    var viewController: ViewController {
        return NSApp.windows[0].contentViewController as! ViewController
    }
    var window: NSWindow? {
        return NSApp.windows.first
    }

    var backingScaleFactor: CGFloat {
        return window?.backingScaleFactor ?? 0
    }
    var pixelPointValue: CGFloat {
        return 1 / backingScaleFactor
    }
    var isHighResolutionDisplay: Bool {
        return backingScaleFactor == 2
    }

    func setToolbar(sizeMode: NSToolbar.SizeMode) {
        guard toolbar?.sizeMode != sizeMode
            else { return }

        window?.perform(Selector(("toggleUsingSmallToolbarIcons:")))
        XCTAssertEqual(toolbar?.sizeMode, sizeMode)

        RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.5))
    }

    func toggleUsingSmallToolbarIcons() {
        setToolbar(sizeMode: toolbar?.sizeMode == .small ? .regular : .small)
    }

    func expectedItemWidth(for item: FontAwesomeToolbarItem) -> CGFloat {
        switch item.itemIdentifier {
        case .defaultWidth:
            if isHighResolutionDisplay {
                return toolbar?.sizeMode == .small
                    ? 38 - floor(2.5 * backingScaleFactor)
                    : 38
            } else {
                return toolbar?.sizeMode == .small
                    ? 38 - floor(2.5 * backingScaleFactor)
                    : 38 + 1
            }
        case .fittedWidth:
            if isHighResolutionDisplay {
                return toolbar?.sizeMode == .small ? 22 : 25
            } else {
                return toolbar?.sizeMode == .small ? 22 : 25
            }
        case .fixedWidth:
            if isHighResolutionDisplay {
                return toolbar?.sizeMode == .small
                    ? 40 - floor(2.5 * backingScaleFactor)
                    : 40
            } else {
                return toolbar?.sizeMode == .small
                    ? 40 - floor(2.5 * backingScaleFactor)
                    : 40 + 1
            }
        case .fixedPointSize:
            if isHighResolutionDisplay {
                return toolbar?.sizeMode == .small
                    ? 38 - floor(2.5 * backingScaleFactor) + 0.5
                    : 38 + 0.5
            } else {
                return toolbar?.sizeMode == .small
                    ? 38 - floor(2.5 * backingScaleFactor) + 1
                    : 38
            }
        default:
            return 0
        }
    }

    func expectedImageSize(for item: FontAwesomeToolbarItem) -> NSSize {
        var size: NSSize
        if toolbar?.sizeMode == .small {
            size = isHighResolutionDisplay
                ? NSSize(width: 15, height: 14.5)
                : NSSize(width: 14, height: 14)
        } else {
            size = isHighResolutionDisplay
                ? NSSize(width: 16, height: 15)
                : NSSize(width: 15, height: 14)
        }

        switch item.itemIdentifier {
        case .fixedPointSize:
            size.width += pixelPointValue

            if !(toolbar?.sizeMode == .small) {
                size.height += pixelPointValue
            }
        default: ()
        }

        return size
    }

    func expectedImageOrigin(for item: FontAwesomeToolbarItem) -> NSPoint {
        var point: NSPoint = .zero
        if toolbar?.sizeMode == .small {
            point.y = isHighResolutionDisplay ? 3.5 : 4
        } else {
            point.y = isHighResolutionDisplay ? 6 : 7
        }

        point.x = ((expectedItemWidth(for: item) - expectedImageSize(for: item).width) / 2)
            + (item.bezelWidthAdjustment / 2)

        return point
    }

    // swiftlint:disable:next identifier_name
    func AssertSizesOfToolbarItems(file: StaticString = #file, line: UInt = #line) {
        XCTAssertNotNil(toolbar, "Could not find toolbar", file: file, line: line)

        for item in toolbar!.items.compactMap({ $0 as? FontAwesomeToolbarItem }) {
            XCTAssertNotNil(item.button,
                            "the item \"\(item.itemIdentifier.rawValue)\" does not have"
                                + " a valid `button` value",
                            file: file,
                            line: line)
            XCTAssertTrue(item.button!.isInToolbar,
                          "the item \"\(item.itemIdentifier.rawValue)\"'s button does not have "
                            + "the correct `isInToolbar` value")

            let expectedWidth = expectedItemWidth(for: item)
            XCTAssertEqual(item.button!.frame.width - item.bezelWidthAdjustment,
                           expectedWidth,
                           "the item \"\(item.itemIdentifier.rawValue)\" does not have"
                            + " the expected button width \(expectedWidth)",
                           file: file,
                           line: line)
            XCTAssertEqual(item.minSize.width - item.bezelWidthAdjustment,
                           expectedWidth,
                           "the item \"\(item.itemIdentifier.rawValue)\" does not have"
                            + " the expected `minSize.width` \(expectedWidth)",
                           file: file,
                           line: line)

            let expectedSize = expectedImageSize(for: item)
            XCTAssertEqual(item.button!.image?.size,
                           expectedSize,
                           "the item \"\(item.itemIdentifier.rawValue)\" does not have"
                            + " the expected image size \(expectedSize)",
                           file: file,
                           line: line)

            let expectedOrigin = expectedImageOrigin(for: item)
            XCTAssertEqual(item.button!.buttonCell?.imageRect(forBounds: item.button!.bounds).origin,
                           expectedOrigin,
                           "the item \"\(item.itemIdentifier.rawValue)\" does not have"
                            + " the expected image origin \(expectedOrigin)",
                           file: file,
                           line: line)
        }
    }

}
