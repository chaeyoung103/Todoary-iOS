//
//  UITextView.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/13.
//

import UIKit

extension UITextView {
    
    
    //button type별 자간, 폰트 자동화 함수
    func textViewTypeSetting(){

        if let labelText = text, labelText.isEmpty == false {
            
            var attributedString = NSMutableAttributedString(string: labelText)
            
            attributedString = addLetterSpacing(attributedString: attributedString)
            attributedString = setTextWithLineHeight(attributedString: attributedString)

            attributedText = attributedString
        }
        
        font = UIFont.nbFont(ofSize: 16, weight: .medium)
        textColor = .black
        
    }
    
    private func addLetterSpacing(attributedString: NSMutableAttributedString) -> NSMutableAttributedString{
        
        attributedString.addAttribute(.kern,
                                      value: 0.32,
                                      range: NSRange(location: 0,
                                                     length: attributedString.length-1))
        
        return attributedString
    }
    
    private func setTextWithLineHeight(attributedString: NSMutableAttributedString) -> NSMutableAttributedString{
        
        let lineHeight: CGFloat = 19.2
        
        let style = NSMutableParagraphStyle()
        style.maximumLineHeight = lineHeight
        style.minimumLineHeight = lineHeight
        
//        style.lineSpacing = lineHeight
        
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: style,
            .baselineOffset: (lineHeight - font!.lineHeight) / 4
        ]
       
        attributedString.addAttributes(attributes,
                                       range: NSRange(location: 0,
                                                      length: attributedString.length-1))
        return attributedString
    }

}
