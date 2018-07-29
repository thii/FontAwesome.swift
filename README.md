# FontAwesome.swift

[![Build Status](http://img.shields.io/travis/thii/FontAwesome.swift.svg?style=flat)](https://travis-ci.org/thii/FontAwesome.swift)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/FontAwesome.swift.svg)](https://img.shields.io/cocoapods/v/FontAwesome.swift.svg)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Platform](https://img.shields.io/cocoapods/p/FontAwesome.swift.svg?style=flat)](http://cocoadocs.org/docsets/FontAwesome.swift)
[![License](https://img.shields.io/cocoapods/l/FontAwesome.swift.svg)](https://raw.githubusercontent.com/thii/FontAwesome.swift/master/LICENSE)

Use Font Awesome in your Swift projects

To see the complete set of 3,652 icons in Font Awesome 5, please check the [FontAwesome.com](http://fontawesome.com/icons/) site.

## Installation

Since this is a Swift project, integrating using Carthage is the recommended way. Releases which support CocoaPods might be delayed sometimes.

### Carthage

To integrate FontAwesome into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "thii/FontAwesome.swift"
```

Then add `import FontAwesome` to the top of the files using FontAwesome.

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

### Manually
- Drag and drop all `.otf` and `.swift` files into your project

## Examples

```swift
// FontAwesome icon in label
label.font = UIFont.fontAwesome(ofSize: 100, style: .brands)
label.text = String.fontAwesomeIcon(name: .github)

let attributes = [NSAttributedStringKey.font: UIFont.fontAwesome(ofSize: 20, style: .brands)]

// FontAwesome icon in button
button.titleLabel?.font = UIFont.fontAwesome(ofSize: 30, style: .brands)
button.setTitle(String.fontAwesomeIcon(name: .github), for: .normal)

// FontAwesome icon as navigation bar item
barButton.setTitleTextAttributes(attributes, for: .normal)
barButton.title = String.fontAwesomeIcon(name: .github)

// FontAwesome icon as toolbar item
toolbarItem.setTitleTextAttributes(attributes, for: .normal)
toolbarItem.title = String.fontAwesomeIcon(name: .github)

// FontAwesome icon as image
imageView.image = UIImage.fontAwesomeIcon(name: .github, style: .brands, textColor: .black, size: CGSize(width: 4000, height: 4000))

// FontAwesome icon as image with background color
imageViewColored.image = UIImage.fontAwesomeIcon(name: .github, style: .brands, textColor: .white, size: CGSize(width: 4000, height: 4000), backgroundColor: .black)
```

## Requirements

iOS 8 or later.

## Development
To update this project to include all the latest icons:

    cd FortAwesome/Font-Awesome
    git fetch origin
    git checkout 5.3.0 # Replace with the latest released version
    cd ../.. # Go back the project root
    ./codegen.swift # Re-generate Enum.swift file from the latest icon list

## License
- All font files licensed under [SIL OFL 1.1](http://scripts.sil.org/OFL)
- FontAwesome.swift licensed under [MIT](http://thi.mit-license.org/)
