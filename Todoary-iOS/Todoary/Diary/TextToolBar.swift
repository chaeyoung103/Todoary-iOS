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
        let selectedTextRange = self.textView.selectedTextRange!
        
        let attributedString = NSMutableAttributedString(attributedString: textView.attributedText)
        
        attributedString.addAttribute(.strikethroughStyle,
                                      value: 1,
                                      range: selectedRange)
        
        textView.attributedText = attributedString
    }
    
    @objc
    func underLineBtnDidClicked(){
        
        let selectedRange = self.textView.selectedRange
        let selectedTextRange = self.textView.selectedTextRange!
        
        let attributedString = NSMutableAttributedString(attributedString: textView.attributedText)
        
        attributedString.addAttribute(.underlineStyle,
                                      value: NSUnderlineStyle.single.rawValue,
                                      range: selectedRange)
        
        textView.attributedText = attributedString
    }
    
    @objc
    func boldBtnDidClicked(){
        
        /*
         기본값 UIFont.nbFont(ofSize: 15, weight: .bold)
         볼드 값 UIFont.nbFont(ofSize: 15, weight: .bold)
         
         1. 선택한 범위 현재 attribute 가져오기
         2. if bold 아닐 경우 bold 적용
         3. bold일 경우 기본값으로 돌리기
         4. bold, bold 아닌 문자 섞여있을 경우 더 많이 적용된 값 기준으로 적용
         */
        
        let selectedRange = self.textView.selectedRange
        let selectedTextRange = self.textView.selectedTextRange!
        
        chooseBoldOrDefault(selectedTextRange)
        
        let attributedString = NSMutableAttributedString(attributedString: textView.attributedText)
        
        attributedString.addAttribute(.font,
                                      value: UIFont.nbFont(ofSize: 15, weight: .bold),
                                      range: selectedRange)
        
        textView.attributedText = attributedString
    }
    
    func chooseBoldOrDefault(_ textRange: UITextRange){
        
        let start = textView.offset(from: textView.beginningOfDocument, to: textRange.start)
        let end = textView.offset(from: textView.beginningOfDocument, to: textRange.end)
        
        var count = 0
        
        for i in start..<end{
            let attribute = textView.attributedText.attribute(.font, at: i, effectiveRange: &self.textView.selectedRange) as? UIFont
            
            if let fontName = attribute?.fontName{
                if(fontName == "AppleSDGothicNeo-Bold"){
                    count += 1
                }
            }
        }
        
        //
        print("기본", end - start - count, "선택", count)
        print(count >= end - start - count)
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
