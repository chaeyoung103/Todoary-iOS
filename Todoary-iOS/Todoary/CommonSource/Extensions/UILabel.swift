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
    
    func labelTypeSetting(type: TextStyles){
        
        if let labelText = text, labelText.isEmpty == false {
            var attributedString = NSMutableAttributedString(string: labelText)
            attributedString = addLetterSpacing(type: type, attributedString: attributedString)
            attributedString = setTextWithLineHeight(type: type, attributedString: attributedString)
            
            self.attributedText = attributedString
        }
        self.font = UIFont.nbFont(type: type)
    }
    
//    func setTextWithLineHeight(type: TextStyles){
//
//        let lineHeight: Double!
//
//        switch type {
//        case .header:
//            lineHeight = 21.6
//            break
//        case .subtitle:
//            lineHeight = 19.2
//            break
//        case .body1, .body2:
//            lineHeight = 16.8
//            break
//        case .sub1:
//            lineHeight = 14.4
//            break
//        default:
//            return
//        }
//
//       if let text = text {
//           let style = NSMutableParagraphStyle()
//           style.maximumLineHeight = lineHeight
//           style.minimumLineHeight = lineHeight
//
//           let attributes: [NSAttributedString.Key: Any] = [
//               .paragraphStyle: style,
//               .baselineOffset: (lineHeight - font.lineHeight) / 4
//           ]
//
//           let attrString = NSAttributedString(string: text,
//                                               attributes: attributes)
//           self.attributedText = attrString
//       }
//   }
    
    func setTextWithLineHeight(type: TextStyles, attributedString: NSMutableAttributedString) -> NSMutableAttributedString{
        
        var lineHeight: Double = 0
        
        switch type {
        case .header:
            lineHeight = 21.6
            break
        case .subtitle:
            lineHeight = 19.2
            break
        case .body1, .body2:
            lineHeight = 16.8
            break
        case .sub1:
            lineHeight = 14.4
            break
        default:
            return attributedString
        }
        
        let style = NSMutableParagraphStyle()
        style.maximumLineHeight = lineHeight
        style.minimumLineHeight = lineHeight
        
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: style,
            .baselineOffset: (lineHeight - font.lineHeight) / 4
        ]
        
        attributedString.addAttributes(attributes, range: NSRange(location: 0,
                                                                  length: attributedString.length-1))
        return attributedString
   }
    
//    func addLetterSpacing(type: TextStyles){
//
//        if let labelText = text, labelText.isEmpty == false{
//
//            let attributedString = NSMutableAttributedString(string: labelText)
//
//            var value: Double = 0
//
//            switch type{
//            case .header, .subtitle:
//                break
//            case .body1:
//                value = 0.28
//            case .body2:
//                value = 0.28
//            case .sub1:
//                value = 0.36
//            default:
//                return
//            }
//
//            attributedString.addAttribute(.kern,
//                                          value: value,
//                                          range: NSRange(location: 0,
//                                                         length: attributedString.length-1))
//
//            self.attributedText = attributedString
//        }
//    }
    
    func addLetterSpacing(type: TextStyles, attributedString: NSMutableAttributedString) -> NSMutableAttributedString{

            var value: Double = 0
            
            switch type{
            case .header, .subtitle:
                break
            case .body1:
                value = 0.28
            case .body2:
                value = 0.28
            case .sub1:
                value = 0.36
            default:
                break
            }
            
            attributedString.addAttribute(.kern,
                                          value: value,
                                          range: NSRange(location: 0,
                                                         length: attributedString.length-1))

        return attributedString
        }
}



