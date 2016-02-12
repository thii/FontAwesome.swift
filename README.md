# FontAwesome.swift

[![Build Status](http://img.shields.io/travis/thii/FontAwesome.swift.svg?style=flat)](https://travis-ci.org/thii/FontAwesome.swift)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/FontAwesome.swift.svg)](https://img.shields.io/cocoapods/v/FontAwesome.swift.svg)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Platform](https://img.shields.io/cocoapods/p/FontAwesome.swift.svg?style=flat)](http://cocoadocs.org/docsets/FontAwesome.swift)
[![License](https://img.shields.io/cocoapods/l/FontAwesome.swift.svg)](https://raw.githubusercontent.com/thii/FontAwesome.swift/master/LICENSE)

Use Font Awesome in your Swift projects

## Installation

### CocoaPods

To integrate FontAwesome into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

pod 'FontAwesome.swift'
```

Then, run the following command:

```bash
$ pod install
```

And add `import FontAwesome_swift` to the top of the files using FontAwesome.

### Carthage

To integrate FontAwesome into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "thii/FontAwesome.swift" >= 0.4.1
```

Then add `import FontAwesome` to the top of the files using FontAwesome.

### Manually
- Drag and drop `FontAwesome.otf` and all Swift files into your project

## Examples

### FontAwesome icon in label
```swift
label.font = UIFont.fontAwesomeOfSize(200)
label.text = String.fontAwesomeIconWithName(FontAwesome.Github)
```

### FontAwesome icon in label from css class name
```swift
label.font = UIFont.fontAwesomeOfSize(200)
label.text = String.fontAwesomeIconWithCode("fa-github")
```


### FontAwesome icon in button
```swift
button.titleLabel?.font = UIFont.fontAwesomeOfSize(30)
button.setTitle(String.fontAwesomeIconWithName(.Github), forState: .Normal)
```

### FontAwesome icon as navigation bar item
```swift
let attributes = [NSFontAttributeName: UIFont.fontAwesomeOfSize(20)] as Dictionary!
leftBarButton.setTitleTextAttributes(attributes, forState: .Normal)
leftBarButton.title = String.fontAwesomeIconWithName(.Github)
```

### FontAwesome icon as toolbar item
```swift
let attributes = [NSFontAttributeName: UIFont.fontAwesomeOfSize(20)] as Dictionary!
toolbarItem.setTitleTextAttributes(attributes, forState: .Normal)
toolbarItem.title = String.fontAwesomeIconWithName(.Github)
```

### FontAwesome icon as an image
```swift
tabBarItem.image = UIImage.fontAwesomeIconWithName(.Github, textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))
```

### FontAwesome icon as an image with background color
```swift
tabBarItem.image = UIImage.fontAwesomeIconWithName(FontAwesome.Github, textColor: UIColor.blueColor(), size: CGSizeMake(4000, 4000), backgroundColor: UIColor.redColor())
```

## Requirements

iOS 8 or later.

## License
- FontAwesome.otf file licensed under [SIL OFL 1.1](http://scripts.sil.org/OFL)
- FontAwesome.swift licensed under [MIT](http://thi.mit-license.org/)
