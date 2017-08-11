// FontAwesomeTabBarItem.swift
//
// Copyright (c) 2017 Maik639
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

@IBDesignable public class FontAwesomeTabBarItem: UITabBarItem {

    @IBInspectable public var iconName: String = "fa-square-o"
    @IBInspectable public var selectedIconName: String = "fa-square"
    @IBInspectable public var size: CGFloat = 38.0

    public override func awakeFromNib() {
        super.awakeFromNib()
        useFontAwesomeImage()
    }

    public override func prepareForInterfaceBuilder() {
        useFontAwesomeImage()
    }

    private func useFontAwesomeImage() {
        createImages { (img, index) in
            if index == 0 {
                image = img
            } else {
                selectedImage = img
            }
        }
    }

}

extension FontAwesomeTabBarItem: FontAwesomeImageRepresentable {

    var imageWidth: CGFloat {
        return size
    }

    var imageConfigs: [ImageConfig] {
        return [(iconName, nil, nil), (selectedIconName, nil, nil)]
    }

}
