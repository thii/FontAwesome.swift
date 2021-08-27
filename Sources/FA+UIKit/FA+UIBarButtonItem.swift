//
//  File.swift
//  
//
//  Created by Mason Phillips on 8/27/21.
//

import UIKit

@IBDesignable public class FontAwesomeBarButtonItem: UIBarButtonItem {

    @IBInspectable public var isFontAwesomeCSSCode: Bool = true
    @IBInspectable public var styleName: String = "Brands"
    @IBInspectable public var size: CGFloat = 25.0

    public override func awakeFromNib() {
        super.awakeFromNib()
        useFontAwesome()
    }

    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        useFontAwesome()
    }

    private func useFontAwesome() {
        updateText {
            if let cssCode = title {
                title = String.fontAwesomeIcon(code: cssCode)
            }
        }
        updateFontAttributes { (state, font) in
            let currentAttributes = titleTextAttributes(for: state) ?? [:]
            var attributes = [NSAttributedString.Key: Any]()
            currentAttributes.enumerated().forEach {
                let currentAttribute = $0.element.key
                attributes[currentAttribute] = $0.element.value
            }
            attributes[NSAttributedString.Key.font] = font
            setTitleTextAttributes(attributes, for: state)
        }
    }

}

extension FontAwesomeBarButtonItem: FontAwesomeTextRepresentable {
    var isTextCSSCode: Bool {
        return isFontAwesomeCSSCode
    }

    var textSize: CGFloat {
        return size
    }

    var fontStyle: FontAwesomeStyle {
        return FontAwesomeStyle(rawValue: styleName) ?? .solid
    }

    static func supportedStates() -> [UIControl.State] {
        return [.normal, .highlighted, .disabled]
    }

}
