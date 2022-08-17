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
        self.toolbar.orangeBtn.addTarget(self, action: #selector(orangeBtnDidClicked), for: .touchUpInside)
        self.toolbar.redBtn.addTarget(self, action: #selector(redBtnDidClicked), for: .touchUpInside)
        self.toolbar.greenBtn.addTarget(self, action: #selector(greenBtnDidClicked), for: .touchUpInside)
        self.toolbar.blueBtn.addTarget(self, action: #selector(blueBtnDidClicked), for: .touchUpInside)
        self.toolbar.grayBtn.addTarget(self, action: #selector(grayBtnDidClicked), for: .touchUpInside)
    }
    
    @objc func yellowBtnDidClicked(){

        let selectedRange = self.textView.selectedRange
        let selectedTextRange = self.textView.selectedTextRange

        let start = selectedRange.lowerBound


        let attribute = textView.attributedText.attribute(.backgroundColor,
                                                          at: start,
                                                          effectiveRange: &self.textView.selectedRange) as? UIFont


        let attributedString = NSMutableAttributedString(attributedString: textView.attributedText)

        if let value = attribute as? Int{
            if(value == 1){
                attributedString.removeAttribute(.backgroundColor, range: selectedRange)
            }
        }else{
            attributedString.addAttribute(.backgroundColor,
                                          value: UIColor(
                                            red: 254/255,
                                            green: 210/255,
                                            blue: 90/255,
                                            alpha: 0.5
                                        ),
                                          range: selectedRange)

        textView.attributedText = attributedString

        moveCursorEndOfSelection(selectedTextRange)
        }
    }
    
    @objc func orangeBtnDidClicked(){

        let selectedRange = self.textView.selectedRange
        let selectedTextRange = self.textView.selectedTextRange

        let start = selectedRange.lowerBound


        let attribute = textView.attributedText.attribute(.backgroundColor,
                                                          at: start,
                                                          effectiveRange: &self.textView.selectedRange) as? UIFont


        let attributedString = NSMutableAttributedString(attributedString: textView.attributedText)

        if let value = attribute as? Int{
            if(value == 1){
                attributedString.removeAttribute(.backgroundColor, range: selectedRange)
            }
        }else{
            attributedString.addAttribute(.backgroundColor,
                                          value: UIColor(
                                            red: 255/255,
                                            green: 143/255,
                                            blue: 84/255,
                                            alpha: 0.5
                                        ),
                                          range: selectedRange)

        textView.attributedText = attributedString

        moveCursorEndOfSelection(selectedTextRange)
        }
    }
    
    @objc func redBtnDidClicked(){

        let selectedRange = self.textView.selectedRange
        let selectedTextRange = self.textView.selectedTextRange

        let start = selectedRange.lowerBound


        let attribute = textView.attributedText.attribute(.backgroundColor,
                                                          at: start,
                                                          effectiveRange: &self.textView.selectedRange) as? UIFont


        let attributedString = NSMutableAttributedString(attributedString: textView.attributedText)

        if let value = attribute as? Int{
            if(value == 1){
                attributedString.removeAttribute(.backgroundColor, range: selectedRange)
            }
        }else{
            attributedString.addAttribute(.backgroundColor,
                                          value: UIColor(
                                            red: 234/255,
                                            green: 44/255,
                                            blue: 4/255,
                                            alpha: 0.5
                                        ),
                                          range: selectedRange)

        textView.attributedText = attributedString

        moveCursorEndOfSelection(selectedTextRange)
        }
    }
    
    @objc func greenBtnDidClicked(){

        let selectedRange = self.textView.selectedRange
        let selectedTextRange = self.textView.selectedTextRange

        let start = selectedRange.lowerBound


        let attribute = textView.attributedText.attribute(.backgroundColor,
                                                          at: start,
                                                          effectiveRange: &self.textView.selectedRange) as? UIFont


        let attributedString = NSMutableAttributedString(attributedString: textView.attributedText)

        if let value = attribute as? Int{
            if(value == 1){
                attributedString.removeAttribute(.backgroundColor, range: selectedRange)
            }
        }else{
            attributedString.addAttribute(.backgroundColor,
                                          value: UIColor(
                                            red: 172/255,
                                            green: 215/255,
                                            blue: 134/255,
                                            alpha: 0.5
                                        ),
                                          range: selectedRange)

        textView.attributedText = attributedString

        moveCursorEndOfSelection(selectedTextRange)
        }
    }
    
    @objc func blueBtnDidClicked(){

        let selectedRange = self.textView.selectedRange
        let selectedTextRange = self.textView.selectedTextRange

        let start = selectedRange.lowerBound


        let attribute = textView.attributedText.attribute(.backgroundColor,
                                                          at: start,
                                                          effectiveRange: &self.textView.selectedRange) as? UIFont


        let attributedString = NSMutableAttributedString(attributedString: textView.attributedText)

        if let value = attribute as? Int{
            if(value == 1){
                attributedString.removeAttribute(.backgroundColor, range: selectedRange)
            }
        }else{
            attributedString.addAttribute(.backgroundColor,
                                          value: UIColor(
                                            red: 86/255,
                                            green: 152/255,
                                            blue: 255/255,
                                            alpha: 0.5
                                        ),
                                          range: selectedRange)

        textView.attributedText = attributedString

        moveCursorEndOfSelection(selectedTextRange)
        }
    }
    
    @objc func grayBtnDidClicked(){

        let selectedRange = self.textView.selectedRange
        let selectedTextRange = self.textView.selectedTextRange

        let start = selectedRange.lowerBound


        let attribute = textView.attributedText.attribute(.backgroundColor,
                                                          at: start,
                                                          effectiveRange: &self.textView.selectedRange) as? UIFont


        let attributedString = NSMutableAttributedString(attributedString: textView.attributedText)

        if let value = attribute as? Int{
            if(value == 1){
                attributedString.removeAttribute(.backgroundColor, range: selectedRange)
            }
        }else{
            attributedString.addAttribute(.backgroundColor,
                                          value: UIColor(
                                            red: 184/255,
                                            green: 184/255,
                                            blue: 184/255,
                                            alpha: 0.5
                                        ),
                                          range: selectedRange)

        textView.attributedText = attributedString

        moveCursorEndOfSelection(selectedTextRange)
        }
    }
}
