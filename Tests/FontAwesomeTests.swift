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

import XCTest
import UIKit
@testable import FontAwesome

final class FontAwesomeTests: XCTestCase {
    func testIconFontShouldBeRegisted() {
        let label = UILabel()
        label.font = UIFont.fontAwesome(of: 200)
        XCTAssertNotNil(label.font)
    }
    
    func testLabelText() {
        let expected = "\u{f09b}"
        let label = UILabel()
        label.font = UIFont.fontAwesome(of: 200)
        label.text = String.fontAwesomeIcon(with: .faGithub)
        XCTAssertEqual(label.text, expected)
        label.text = String.fontAwesomeIcon(with: "fa-github")
        XCTAssertEqual(label.text, expected)
    }
    
    func testLabelTextForWrongName() {
        let label = UILabel()
        label.font = UIFont.fontAwesome(of: 200)
        label.text = String.fontAwesomeIcon(with: "wrong-name")
        XCTAssertEqual(label.text, "")
    }
    
    func testButtonImage() {
        let button = UIButton()
        button.setImage(UIImage.fontAwesomeIcon(with: .faGithub, size: CGSize(width: 4000, height: 4000), textColor: .yellow, backgroundColor: .red), for: .normal)
        XCTAssertNotNil(button.image(for: .normal))
        button.setImage(UIImage.fontAwesomeIcon(with: "fa-github", size: CGSize(width: 4000, height: 4000), textColor: .yellow, backgroundColor: .red), for: .normal)
        XCTAssertNotNil(button.image(for: .normal))
    }
    
    func testButtonImageForWrongName() {
        let button = UIButton()
        button.setImage(UIImage.fontAwesomeIcon(with: "wrong-name", size: CGSize(width: 4000, height: 4000), textColor: .yellow, backgroundColor: .red), for: .normal)
        XCTAssertNotNil(button.image(for: .normal))
    }
}
