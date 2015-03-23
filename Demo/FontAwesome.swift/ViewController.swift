// ViewController.swift
//
// Copyright (c) 2014 Doan Truong Thi
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

class ViewController: UIViewController {

  @IBOutlet weak var leftBarButton: UIBarButtonItem!
  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var toolbarItem: UIBarButtonItem!
  @IBOutlet weak var button: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()

    // FontAwesome icon in label
    label.font = UIFont.fontAwesomeOfSize(200)
    label.text = String.fontAwesomeIconWithName(FontAwesome.Github)

    let attributes = [NSFontAttributeName: UIFont.fontAwesomeOfSize(20)] as Dictionary!

    // FontAwesome icon in button
    button.titleLabel?.font = UIFont.fontAwesomeOfSize(30)
    button.setTitle(String.fontAwesomeIconWithName(.Github), forState: .Normal)

    // FontAwesome icon as navigation bar item
    leftBarButton.setTitleTextAttributes(attributes, forState: .Normal)
    leftBarButton.title = String.fontAwesomeIconWithName(.Github)

    // FontAwesome icon as toolbar item
    toolbarItem.setTitleTextAttributes(attributes, forState: .Normal)
    toolbarItem.title = String.fontAwesomeIconWithName(.Github)

  }
}

