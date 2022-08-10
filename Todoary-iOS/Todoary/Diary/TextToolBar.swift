//
//  TextToolBar.swift
//  Todoary
//
//  Created by 박지윤 on 2022/08/09.
//

import Foundation
import UIKit

extension DiaryViewController{
    
    func setTextToolBarAction(){
        self.toolbar.alignLeftBtn.addTarget(self, action: #selector(alignLeftBtnDidClicked), for: .touchUpInside)
        self.toolbar.ailgnCenterBtn.addTarget(self, action: #selector(alignCenterBtnDidClicked), for: .touchUpInside)
        self.toolbar.alignRightBtn.addTarget(self, action: #selector(alignRightBtnDidClicked), for: .touchUpInside)
        self.toolbar.fontBtn.addTarget(self, action: #selector(fontBtnDidClicked), for: .touchUpInside)
        self.toolbar.strikeLineBtn.addTarget(self, action: #selector(strikeBtnDidClicked), for: .touchUpInside)
        self.toolbar.underLineBtn.addTarget(self, action: #selector(underLineBtnDidClicked), for: .touchUpInside)
        self.toolbar.boldBtn.addTarget(self, action: #selector(boldBtnDidClicked), for: .touchUpInside)
    }
    
    @objc
    func alignLeftBtnDidClicked(){
        self.textView.textAlignment = .left
    }
    
    
    @objc
    func alignCenterBtnDidClicked(){
        self.textView.textAlignment = .center
    }
    
    
    @objc
    func alignRightBtnDidClicked(){
        self.textView.textAlignment = .right
    }
    
    @objc
    func fontBtnDidClicked(){
        
    }
    
    @objc
    func strikeBtnDidClicked(){

        let selectedRange = self.textView.selectedRange
        let selectedTextRange = self.textView.selectedTextRange
        
        let start = selectedRange.lowerBound

        let attribute = textView.attributedText.attribute(.strikethroughStyle,
                                                          at: start,
                                                          effectiveRange: &self.textView.selectedRange)
        
        let attributedString = NSMutableAttributedString(attributedString: textView.attributedText)

        if let value = attribute as? Int{
            if(value == 1){
                attributedString.removeAttribute(.strikethroughStyle, range: selectedRange)
            }
        }else{
            attributedString.addAttribute(.strikethroughStyle,
                                          value: 1,
                                          range: selectedRange)
        }
        
        textView.attributedText = attributedString
        
        moveCursorEndOfSelection(selectedTextRange)
    }
    
    @objc
    func underLineBtnDidClicked(){
        
        let selectedRange = self.textView.selectedRange
        let selectedTextRange = self.textView.selectedTextRange
        
        let start = selectedRange.lowerBound

        let attribute = textView.attributedText.attribute(.underlineStyle,
                                                          at: start,
                                                          effectiveRange: &self.textView.selectedRange)
        
        let attributedString = NSMutableAttributedString(attributedString: textView.attributedText)

        if let value = attribute as? Int{
            if(value == 1){
                attributedString.removeAttribute(.underlineStyle, range: selectedRange)
            }
        }else{
            attributedString.addAttribute(.underlineStyle,
                                          value: NSUnderlineStyle.single.rawValue,
                                          range: selectedRange)
        }
        
        textView.attributedText = attributedString
        
        moveCursorEndOfSelection(selectedTextRange)
    }
    
    @objc
    func boldBtnDidClicked(){
        
        /*
         무조건 첫 번째 글자 기준으로 적용시키기
         첫 번째 글자 -> 볼드 -> 볼드 취소
         첫 번째 글자 -> 기본 -> 볼드
         */
        
        let selectedRange = self.textView.selectedRange
        let selectedTextRange = self.textView.selectedTextRange
        
        let start = selectedRange.lowerBound

        let attribute = textView.attributedText.attribute(.font,
                                                          at: start,
                                                          effectiveRange: &self.textView.selectedRange) as? UIFont

        var fontWeight: NBWeight!
        
        if let fontName = attribute?.fontName{
            fontWeight = fontName == "AppleSDGothicNeo-Bold" ? NBWeight.medium : .bold
        }
        
        let attributedString = NSMutableAttributedString(attributedString: textView.attributedText)
        
        attributedString.addAttribute(.font,
                                      value: UIFont.nbFont(ofSize: 15, weight: fontWeight),
                                      range: selectedRange)
        
        textView.attributedText = attributedString
        
        moveCursorEndOfSelection(selectedTextRange)
    }
    
    //Attribute 추가 후 커서 마지막 드래그 위치로 이동
    func moveCursorEndOfSelection(_ selectedTextRange: UITextRange?){
        // only if there is a currently selected range
        if let selectedRange = selectedTextRange {
            // and only if the new position is valid
            if let newPosition = textView.position(from: selectedRange.end, offset: 0) {
                // set the new position
                textView.selectedTextRange = textView.textRange(from: newPosition, to: newPosition)
            }
        }
    }
}

extension UITextInput{
    
    var selectedRange: NSRange?{
        if let selectedRange = self.selectedTextRange{
            return NSMakeRange(self.offset(from: self.beginningOfDocument, to: selectedRange.start),
                               self.offset(from: selectedRange.start,to: selectedRange.end))
        }else{
            return nil
        }
    }
}
