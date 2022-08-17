//
//  HighlightText .swift
//  Todoary
//
//  Created by 예리 on 2022/08/17.
//

import Foundation
import UIKit

extension DiaryViewController{
    
    func setHighlightToolBarAction(){
    
        self.toolbar.yellowBtn.addTarget(self, action: #selector(yellowBtnDidClicked), for: .touchUpInside)
        self.toolbar.orangeBtn.addTarget(self, action: #selector(alignRightBtnDidClicked), for: .touchUpInside)
        self.toolbar.redBtn.addTarget(self, action: #selector(alignRightBtnDidClicked), for: .touchUpInside)
        self.toolbar.greenBtn.addTarget(self, action: #selector(alignRightBtnDidClicked), for: .touchUpInside)
        self.toolbar.blueBtn.addTarget(self, action: #selector(alignRightBtnDidClicked), for: .touchUpInside)
        self.toolbar.grayBtn.addTarget(self, action: #selector(alignRightBtnDidClicked), for: .touchUpInside)
    }
    
    @objc
    func yellowBtnDidClicked(){
        
        /*
         무조건 첫 번째 글자 기준으로 적용시키기
         첫 번째 글자 -> 볼드 -> 볼드 취소
         첫 번째 글자 -> 기본 -> 볼드
         */
        
        let selectedRange = self.textView.selectedRange
        let selectedTextRange = self.textView.selectedTextRange
        
        let start = selectedRange.lowerBound

        let attribute = textView.attributedText.attribute(.underlineColor,
                                                          at: start,
                                                          effectiveRange: &self.textView.selectedRange) as? UIFont
        
        
        let attributedString = NSMutableAttributedString(attributedString: textView.attributedText)
        
        if let value = attribute as? Int{
            if(value == 1){
                attributedString.removeAttribute(.underlineColor, range: selectedRange)
            }
        }else{
            attributedString.addAttribute(.underlineColor,
                                          value: NSUnderlineStyle.single.rawValue,
                                          range: selectedRange)
        
        textView.attributedText = attributedString
        
        moveCursorEndOfSelection(selectedTextRange)
        }
    }
}
