// ViewController.swift
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
import FontAwesome

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var barButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewColored: UIImageView!
    @IBOutlet weak var toolbarItem: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        // FontAwesome icon in label
        label.font = UIFont.fontAwesomeOfSize(100)
        label.text = String.fontAwesomeIconWithName(FontAwesome.Github)

        let attributes = [NSFontAttributeName: UIFont.fontAwesomeOfSize(20)] as Dictionary!

        // FontAwesome icon in button
        button.titleLabel?.font = UIFont.fontAwesomeOfSize(30)
        button.setTitle(String.fontAwesomeIconWithName(.Github), forState: .Normal)

        // FontAwesome icon as navigation bar item
        barButton.setTitleTextAttributes(attributes, forState: .Normal)
        barButton.title = String.fontAwesomeIconWithName(.Github)

        // FontAwesome icon as toolbar item
        toolbarItem.setTitleTextAttributes(attributes, forState: .Normal)
        toolbarItem.title = String.fontAwesomeIconWithName(.Github)

        // FontAwesome icon as image
        imageView.image = UIImage.fontAwesomeIconWithName(FontAwesome.Github, textColor: UIColor.blackColor(), size: CGSizeMake(4000, 4000))

        // FontAwesome icon as image with background color
        imageViewColored.image = UIImage.fontAwesomeIconWithName(FontAwesome.Github, textColor: UIColor.blueColor(), size: CGSizeMake(4000, 4000), backgroundColor: UIColor.redColor())
    }

}
