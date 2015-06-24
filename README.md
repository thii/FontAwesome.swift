# FontAwesome.swift [![CI Status](http://img.shields.io/travis/thii/FontAwesome.swift.svg?style=flat)](https://travis-ci.org/thii/FontAwesome.swift)

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

### Carthage

To integrate FontAwesome into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "thii/FontAwesome" >= 0.4.1
```

### Manually
- Drag and drop `FontAwesome.otf` and all Swift files into your project

## Examples

If you installed using CocoaPods or Carthage, you need to add `import FontAwesome` to the top of the files using FontAwesome.

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

### FontAwesome icon as a (tabbaritem's) image
```swift
tabBarItem.image = UIImage.fontAwesomeIconWithName(.Github, , textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))
```


## Requirements

iOS 8 or later.

## License
- FontAwesome.otf file licensed under [SIL OFL 1.1](http://scripts.sil.org/OFL)
- FontAwesome.swift licensed under [MIT](http://thi.mit-license.org/)
