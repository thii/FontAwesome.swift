# FontAwesome.swift

[![CI Status](http://img.shields.io/travis/thii/FontAwesome.swift.svg?style=flat)](https://travis-ci.org/thii/FontAwesome.swift)

## Installation

- Add this project as a submodule
```shell
$ cd /path/to/your/project
$ git submodule add https://github.com/thii/FontAwesome.swift
```
- Drag and drop `FontAwesome.otf` and `FontAwesome.swift` files into your project
- Add the `Fonts provided by application` key in your project's `plist` file
- Add a `String` item inside that with the value `FontAwesome.otf`

## Examples

```swift
var myLabel:UILabel!
myLabel.font = UIFont.fontAwesomeOfSize(200)
myLabel.text = String.fontAwesomeIconWithName("fa-github")

```

## Requirements

## License

[MIT](http://thi.mit-license.org/)
