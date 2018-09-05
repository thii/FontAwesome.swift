// FontAwesomeTests.swift
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

import UIKit
import XCTest
@testable import FontAwesome

class FontAwesomeTests: XCTestCase {

    func testIconFontShouldBeRegistered() {
        let label = UILabel()
        label.font = UIFont.fontAwesome(ofSize: 200, style: .brands)
        XCTAssertNotNil(label.font, "Icon font should not be nil.")
    }

    func testLabelText() {
        let label = UILabel()
        label.font = UIFont.fontAwesome(ofSize: 200, style: .brands)
        label.text = String.fontAwesomeIcon(name: FontAwesome.github)
        XCTAssertEqual(label.text, "\u{f09b}")
    }

    func testLabelTextFromCode() {
        let label = UILabel()
        label.font = UIFont.fontAwesome(ofSize: 200, style: .brands)
        label.text = String.fontAwesomeIcon(code: "fa-github")
        XCTAssertEqual(label.text, "\u{f09b}")
    }

    func testButtonTitle() {
        let button = UIButton()
        button.titleLabel?.font = UIFont.fontAwesome(ofSize: 30, style: .brands)
        button.setTitle(String.fontAwesomeIcon(name: .github), for: UIControl.State())
        XCTAssertEqual(button.titleLabel?.text, "\u{f09b}")
    }

    func testBarItemTitle() {
        let barItem = UIBarButtonItem()
        let attributes = [NSAttributedString.Key.font: UIFont.fontAwesome(ofSize: 20, style: .brands)]
        barItem.setTitleTextAttributes(attributes, for: UIControl.State())
        barItem.title = String.fontAwesomeIcon(name: .github)
        XCTAssertEqual(barItem.title, "\u{f09b}")
    }

    func testIconImageZeroSize() {
        let barItem = UIBarButtonItem()
        barItem.image = UIImage.fontAwesomeIcon(name: FontAwesome.github, style: .brands, textColor: UIColor.blue, size: CGSize(width: 4000, height: 0), backgroundColor: UIColor.red)
        XCTAssertNotNil(barItem.image)
    }

    func testIconImage() {
        let barItem = UIBarButtonItem()
        barItem.image = UIImage.fontAwesomeIcon(name: FontAwesome.github, style: .brands, textColor: UIColor.blue, size: CGSize(width: 4000, height: 4000), backgroundColor: UIColor.red)
        XCTAssertNotNil(barItem.image)
    }

    func testIconImageFromCode() {
        let barItem = UIBarButtonItem()
        barItem.image = UIImage.fontAwesomeIcon(code: "fa-github", style: .brands, textColor: UIColor.blue, size: CGSize(width: 4000, height: 4000), backgroundColor: UIColor.red)
        XCTAssertNotNil(barItem.image)
    }
}
