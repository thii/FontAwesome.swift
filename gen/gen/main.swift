//  main.swift
//  gen
//
//  Created by Yuki Nagai on 8/8/16.
//  Copyright © 2016 Yuki Nagai. All rights reserved.
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

import Yaml

struct Icon {
    let name: String
    let id: String
    let unicode: String
}

func main() {
    let fileURL = NSBundle.mainBundle().URLForResource("icons", withExtension: "yml")!
    let fileString = try! String(contentsOfURL: fileURL)
    let fileIcons = Yaml.load(fileString).value!["icons"].array ?? []
    let icons = fileIcons.map { fileIcon -> Icon in
        let id = fileIcon["id"].string!
        let name = { id -> String in
            let components = id.componentsSeparatedByString("-")
            return "fa" + components.enumerate().map { index, value in
                if value == "o" { return "Outlined" }
                return String(value.characters.prefix(1)).capitalizedString + String(value.characters.dropFirst())
                }.joinWithSeparator("")
        }(id)
        return Icon(name: name, id: id, unicode: fileIcon["unicode"].string!)
    }
    var lines = [
        "// Icon.swift",
        "//",
        "// Copyright (c) 2014-2015 Thi Doan",
        "//",
        "// Permission is hereby granted, free of charge, to any person obtaining a copy",
        "// of this software and associated documentation files (the \"Software\"), to deal",
        "// in the Software without restriction, including without limitation the rights",
        "// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell",
        "// copies of the Software, and to permit persons to whom the Software is",
        "// furnished to do so, subject to the following conditions:",
        "//",
        "// The above copyright notice and this permission notice shall be included in",
        "// all copies or substantial portions of the Software.",
        "//",
        "// THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR",
        "// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,",
        "// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE",
        "// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER",
        "// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,",
        "// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN",
        "// THE SOFTWARE.",
        "",
        "/// An enumaration of FontAwesome icon names.",
        "public enum Icon: String {"
    ]
    lines += icons.map { "    case \($0.name) = \"fa-\($0.id)\"" }
    lines += [
        "",
        "    /// Unicode string.",
        "    var unicode: String {",
        "        let value: UInt32",
        "        switch self {"
    ]
    lines += icons.map { "        case .\($0.name): value = 0x\($0.unicode.capitalizedString)" }
    lines += [
        "        }",
        "        return String(UnicodeScalar(value))",
        "    }",
        "}",
        ""
    ]
    let destination = NSProcessInfo.processInfo().environment["FAGEN_DESTINATION"]!
    try! lines.joinWithSeparator("\n").writeToFile(destination, atomically: true, encoding: NSUTF8StringEncoding)
}
main()
