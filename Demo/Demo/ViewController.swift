// FontAwesome.swift
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

final class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var barButtonItem: UIBarButtonItem!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // FontAwesome icon in label
        let label = self.label!
        label.font = UIFont.fontAwesome(of: 100)
        label.text = String.fontAwesomeIcon(with: .faGithub)
        
        // FontAwesome icon in button
        let button = self.button!
        button.titleLabel?.font = UIFont.fontAwesome(of: 100)
        button.setTitle(String.fontAwesomeIcon(with: .faGithub), for: .normal)
        
        let attributes = [NSFontAttributeName: UIFont.fontAwesome(of: 20)]
        
        // FontAwesome icon as navigation bar item
        let barButtonItem = self.barButtonItem!
        barButtonItem.setTitleTextAttributes(attributes, for: .normal)
        barButtonItem.title = String.fontAwesomeIcon(with: .faGithub)
        
        // FontAwesome icon as image
        let imageView1 = self.imageView1!
        imageView1.image = UIImage.fontAwesomeIcon(with: .faGithub, size: CGSize(width: 100, height: 100))
        
        // FontAwesome icon as image with color
        let imageView2 = self.imageView2!
        imageView2.image = UIImage.fontAwesomeIcon(with: .faGithub, size: CGSize(width: 100, height: 100), textColor: .white, backgroundColor: .black)
    }
}

