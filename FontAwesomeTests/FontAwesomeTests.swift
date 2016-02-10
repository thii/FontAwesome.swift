// FontAwesomeTests.swift
//
// Copyright (c) 2014-2015 Thi Doan
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

    func testIconFontShouldBeRegisted() {
        let label = UILabel()
        label.font = UIFont.fontAwesomeOfSize(200)
        XCTAssertNotNil(label.font, "Icon font should not be nil.")
    }

    func testLabelText() {
        let label = UILabel()
        label.font = UIFont.fontAwesomeOfSize(200)
        label.text = String.fontAwesomeIconWithName(FontAwesome.Github)
        XCTAssertEqual(label.text, "\u{f09b}")
        label.text = String.fontAwesomeIconWithCode("fa-github")
        XCTAssertEqual(label.text, "\u{f09b}")
    }

    func testButtonTitle() {
        let button = UIButton()
        button.titleLabel?.font = UIFont.fontAwesomeOfSize(30)
        button.setTitle(String.fontAwesomeIconWithName(.Github), forState: .Normal)
        XCTAssertEqual(button.titleLabel?.text, "\u{f09b}")
    }

    func testBarItemTitle() {
        let barItem = UIBarButtonItem()
        let attributes = [NSFontAttributeName: UIFont.fontAwesomeOfSize(20)] as Dictionary!
        barItem.setTitleTextAttributes(attributes, forState: .Normal)
        barItem.title = String.fontAwesomeIconWithName(.Github)
        XCTAssertEqual(barItem.title, "\u{f09b}")
    }

    func testIconImage() {
        let barItem = UIBarButtonItem()
        barItem.image = UIImage.fontAwesomeIconWithName(FontAwesome.Github, textColor: UIColor.blueColor(), size: CGSizeMake(4000, 4000), backgroundColor: UIColor.redColor())
        XCTAssertNotNil(barItem.image)
    }
}
