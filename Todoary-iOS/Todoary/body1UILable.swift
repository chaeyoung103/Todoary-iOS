//
//  body1UILable.swift
//  Todoary
//
//  Created by 예리 on 2022/07/04.
//

import Foundation
import UIKit

extension UILabel {
    public var letterSpacing: CGFloat? {
        get { getAttribute(.kern) }
        set {
            setAttribute(.kern, value: newValue)
            setupAttributeCacheIfNeeded()
        }
    }
    
    public var underline: NSUnderlineStyle? {
        get { getAttribute(.underlineStyle) }
        set {
            setAttribute(.underlineStyle, value: newValue)
            setupAttributeCacheIfNeeded()
        }
    }
    
    public var strikethrough: NSUnderlineStyle? {
        get { getAttribute(.strikethroughStyle) }
        set {
            setAttribute(.strikethroughStyle, value: newValue)
            setupAttributeCacheIfNeeded()
        }
    }
}
