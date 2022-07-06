//
//  UILable.swift
//  Todoary
//
//  Created by 예리 on 2022/07/05.
//

import Foundation
import UIKit

//lineHeight 설정
extension UILabel {
     func setTextWithLineHeight(text: String?, lineHeight: CGFloat){
        if let text = text {
            let style = NSMutableParagraphStyle()
            style.maximumLineHeight = lineHeight
            style.minimumLineHeight = lineHeight

            let attributes: [NSAttributedString.Key: Any] = [
                .paragraphStyle: style,
                .baselineOffset: (lineHeight - font.lineHeight) / 4
            ]
            
            let attrString = NSAttributedString(string: text,
                                                attributes: attributes)
            self.attributedText = attrString
        }
    }
    
    func addLetterSpacing(_ value: Double = 0.28){
        if let labelText = text, labelText.isEmpty == false{
            let attributedString = NSMutableAttributedString(string: labelText)
            attributedString.addAttribute(.kern,
                                          value: value,
                                          range: NSRange(location: 0, length: attributedString.length-1))
            attributedText = attributedString
        }
    }
}



