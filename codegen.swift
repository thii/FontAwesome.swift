#!/usr/bin/swift

import Foundation

typealias Icons = [String: Icon]

struct Icon: Codable {
    let changes: [String]
    let styles: [String]
    let unicode: String
    let label: String
    let svg: [String: SVG]
}

struct SVG: Codable {
    let raw: String
    let viewBox: [String]
    let width: UInt
    let height: UInt
    let path: String
}

extension String {
    public func camelCased(with separator: Character) -> String {
        return split(separator: separator).reduce("") { result, element in
            "\(result)\(result.count > 0 ? String(element.capitalized) : String(element))"
        }
    }

    public func filteredKeywords() -> String {
        if self == "500px" {
            return "fiveHundredPixels"
        }
        if self == "subscript" {
            return "`subscript`"
        }
        return self
    }
}

guard let json = FileManager.default.contents(atPath: "FortAwesome/Font-Awesome/advanced-options/metadata/icons.json") else {
    fatalError("Could not find JSON metadata file")
}

let icons = try JSONDecoder().decode(Icons.self, from: json)

// Start writing FontAwesome enum
var fontAwesomeEnum = ""

fontAwesomeEnum += """
// Enum.swift
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

// DO NOT EDIT! This file is auto-generated. To regenerate it, update
// Font-Awesome submodule and run `./codegen.swift`.

/// An enumaration of FontAwesome icon names.
// swiftlint:disable file_length type_body_length
public enum FontAwesome: String {

"""

let sortedKeys = Array(icons.keys).sorted(by: <)
sortedKeys.forEach { key in
    guard let value = icons[key] else { return }
    let enumKeyName = key.filteredKeywords().camelCased(with: "-")
    fontAwesomeEnum += """
        case \(enumKeyName) = \"\\u{\(value.unicode)}\"

    """
}

fontAwesomeEnum += """
}

/// An array of FontAwesome icon codes.
// swiftlint:disable identifier_name
public let FontAwesomeIcons: [String: String] = [

"""

sortedKeys.forEach { key in
    guard let value = icons[key] else { return }
    fontAwesomeEnum += """
        \"fa-\(key)\": \"\\u{\(value.unicode)}\"
    """
    if key != sortedKeys.last {
        fontAwesomeEnum += ",\n"
    }
}

fontAwesomeEnum += """

]

"""

FileManager.default.createFile(atPath: "FontAwesome/Enum.swift", contents: fontAwesomeEnum.data(using: .utf8), attributes: nil)
