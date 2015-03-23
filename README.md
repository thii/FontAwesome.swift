# FontAwesome.swift [![CI Status](http://img.shields.io/travis/thii/FontAwesome.swift.svg?style=flat)](https://travis-ci.org/thii/FontAwesome.swift)

Use Font Awesome in your Swift projects

## Installation

- Drag and drop `FontAwesome.otf` and `FontAwesome.swift` files into your project

## Examples

### FontAwesome icon in label
```swift
label.font = UIFont.fontAwesomeOfSize(200)
label.text = String.fontAwesomeIconWithName(FontAwesome.Github)

let attributes = [NSFontAttributeName: UIFont.fontAwesomeOfSize(20)] as Dictionary!
```

### FontAwesome icon in button
```swift
button.titleLabel?.font = UIFont.fontAwesomeOfSize(30)
button.setTitle(String.fontAwesomeIconWithName(.Github), forState: .Normal)
```

### FontAwesome icon as navigation bar item
```swift
leftBarButton.setTitleTextAttributes(attributes, forState: .Normal)
leftBarButton.title = String.fontAwesomeIconWithName(.Github)
```

### FontAwesome icon as toolbar item
```swift
toolbarItem.setTitleTextAttributes(attributes, forState: .Normal)
toolbarItem.title = String.fontAwesomeIconWithName(.Github)
```


## Requirements

iOS 7 or later.

## License
- FontAwesome.otf file licensed under [SIL OFL 1.1](http://scripts.sil.org/OFL)
- FontAwesome.swift licensed under [MIT](http://thi.mit-license.org/)
