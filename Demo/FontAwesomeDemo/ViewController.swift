// ViewController.swift
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
import FontAwesome

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var barButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewColored: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // FontAwesome icon in label
        label.font = UIFont.fontAwesome(ofSize: 100, style: .brands)
        label.text = String.fontAwesomeIcon(name: .github)

        let attributes = [NSAttributedString.Key.font: UIFont.fontAwesome(ofSize: 20, style: .brands)]

        // FontAwesome icon in button
        button.titleLabel?.font = UIFont.fontAwesome(ofSize: 30, style: .brands)
        button.setTitle(String.fontAwesomeIcon(name: .github), for: .normal)

        // FontAwesome icon as navigation bar item
        barButton.setTitleTextAttributes(attributes, for: .normal)
        barButton.title = String.fontAwesomeIcon(name: .github)

        // FontAwesome icon as image
        imageView.image = UIImage.fontAwesomeIcon(name: .github, style: .brands, textColor: .black, size: CGSize(width: 4000, height: 4000))

        // FontAwesome icon as image with background color
        imageViewColored.image = UIImage.fontAwesomeIcon(name: .github, style: .brands, textColor: .white, size: CGSize(width: 4000, height: 4000), backgroundColor: .black)
    }
}
