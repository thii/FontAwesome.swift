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

    func testFontsShouldBeLoaded() {
        let solidFont = UIFont.fontAwesome(ofSize: 200, style: .solid)
        let regularFont = UIFont.fontAwesome(ofSize: 200, style: .regular)
        let brandsFont = UIFont.fontAwesome(ofSize: 200, style: .brands)
        XCTAssertNotNil(solidFont, "Solid font should be loaded.")
        XCTAssertNotNil(regularFont, "Regular font should be loaded.")
        XCTAssertNotNil(brandsFont, "Brands font should be loaded.")
    }

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
    
    func testFontsShouldBeLoadedForAllDynamicTypes() {
        let bodyFont = UIFont.fontAwesome(forTextStyle: .body, style: .brands)
        let caption1Font = UIFont.fontAwesome(forTextStyle: .caption1, style: .brands)
        let caption2Font = UIFont.fontAwesome(forTextStyle: .caption2, style: .brands)
        let footnoteFont = UIFont.fontAwesome(forTextStyle: .footnote, style: .brands)
        let headlineFont = UIFont.fontAwesome(forTextStyle: .headline, style: .brands)
        let subheadlineFont = UIFont.fontAwesome(forTextStyle: .subheadline, style: .brands)
        
        XCTAssertNotNil(bodyFont, "Body font should be loaded.")
        XCTAssertNotNil(caption1Font, "Caption1 font should be loaded.")
        XCTAssertNotNil(caption2Font, "Caption2 font should be loaded.")
        XCTAssertNotNil(footnoteFont, "Footnote font should be loaded.")
        XCTAssertNotNil(headlineFont, "Headline font should be loaded.")
        XCTAssertNotNil(subheadlineFont, "Subheadline font should be loaded.")
        
        if #available(iOS 9.0, *) {
            let calloutFont = UIFont.fontAwesome(forTextStyle: .callout, style: .brands)
            let title1Font = UIFont.fontAwesome(forTextStyle: .title1, style: .brands)
            let title2Font = UIFont.fontAwesome(forTextStyle: .title2, style: .brands)
            let title3Font = UIFont.fontAwesome(forTextStyle: .title3, style: .brands)
            
            XCTAssertNotNil(calloutFont, "Callout font should be loaded.")
            XCTAssertNotNil(title1Font, "Title1 font should be loaded.")
            XCTAssertNotNil(title2Font, "Title2 font should be loaded.")
            XCTAssertNotNil(title3Font, "Title3 font should be loaded.")
        }
        
        if #available(iOS 11.0, *) {
            let largeTitleFont = UIFont.fontAwesome(forTextStyle: .largeTitle, style: .brands)
            
            XCTAssertNotNil(largeTitleFont, "LargeTitle font should be loaded.")
        }
    }
    
    func testLabelTextUsingDynamicType() {
        let label = UILabel()
        label.font = UIFont.fontAwesome(forTextStyle: .body, style: .brands)
        label.text = String.fontAwesomeIcon(name: FontAwesome.github)
        XCTAssertEqual(label.text, "\u{f09b}")
    }
}
