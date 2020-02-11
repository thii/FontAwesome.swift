// FontAwesomeRepresentable.swift
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

public protocol FontAwesomeRepresentable: class {

    /// The name of the [Font Awesome icon](https://fontawesome.com/icons?d=gallery).
    ///
    /// This property has a default value of `"fa-font-awesome-flag"` (`FontAwesome.fontAwesomeFlag`).
    ///
    /// - Note: The _fa-_ prefix is optional. For example, `"fa-camera"` and `"camera"` are equivalent.
    ///
    /// - Important: The usage of `icon` should be preferred.
    var iconCode: String { get set }
    /// The Font Awesome font style.
    ///
    /// This property has a default value of `"brands"` (`FontAwesomeStyle.brands`).
    ///
    /// - Important: The usage of `style` should be preferred.
    var styleName: String { get set }

    /// The Unicode Font Awesome icon.
    var fontAwesomeIcon: String? { get }
    /// The [Font Awesome icon](https://fontawesome.com/icons?d=gallery).
    var icon: FontAwesome? { get set }
    /// The Font Awesome font style.
    var style: FontAwesomeStyle { get set }

}

public extension FontAwesomeRepresentable {

    var fontAwesomeIcon: String? {
        guard let icon = self.icon
            else { return nil }

        return String.fontAwesomeIcon(name: icon)
    }

    var icon: FontAwesome? {
        get { return FontAwesome(name: iconCode) }
        set { iconCode = newValue?.rawValue ?? "" }
    }

    var style: FontAwesomeStyle {
        get { return FontAwesomeStyle(rawValue: styleName.lowercased()) ?? .brands }
        set { styleName = newValue.rawValue }
    }

}
