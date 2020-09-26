// NSButton.BezelStyle.swift
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

import AppKit

extension NSButton.BezelStyle: CaseIterable, CustomDebugStringConvertible {

    public static var allCases: [NSButton.BezelStyle] {
        return [
            .rounded,
            .regularSquare,
            .disclosure,
            .shadowlessSquare,
            .circular,
            .texturedSquare,
            .helpButton,
            .smallSquare,
            .texturedRounded,
            .roundRect,
            .recessed,
            .roundedDisclosure,
            .inline
        ]
    }

    public var debugDescription: String {
        switch self {
        case .rounded:
            return ".rounded"
        case .regularSquare:
            return ".regularSquare"
        case .disclosure:
            return ".disclosure"
        case .shadowlessSquare:
            return ".shadowlessSquare"
        case .circular:
            return ".circular"
        case .texturedSquare:
            return ".texturedSquare"
        case .helpButton:
            return ".helpButton"
        case .smallSquare:
            return ".smallSquare"
        case .texturedRounded:
            return ".texturedRounded"
        case .roundRect:
            return ".roundRect"
        case .recessed:
            return ".recessed"
        case .roundedDisclosure:
            return ".roundedDisclosure"
        case .inline:
            return ".inline"
        @unknown default:
            return ""
        }
    }

}
