//
//  ToolBarText.swift
//  Todoary
//
//  Created by 박지윤 on 2022/08/11.
//

import Foundation
import UIKit

extension DiaryViewController{
    
    
    
    func setTextToolBarAction(){
    
        self.toolbar.alignLeftBtn.addTarget(self, action: #selector(alignLeftBtnDidClicked), for: .touchUpInside)
        self.toolbar.ailgnCenterBtn.addTarget(self, action: #selector(alignCenterBtnDidClicked), for: .touchUpInside)
        self.toolbar.alignRightBtn.addTarget(self, action: #selector(alignRightBtnDidClicked), for: .touchUpInside)

        self.toolbar.strikeLineBtn.addTarget(self, action: #selector(strikeBtnDidClicked), for: .touchUpInside)
        self.toolbar.underLineBtn.addTarget(self, action: #selector(underLineBtnDidClicked), for: .touchUpInside)
        self.toolbar.boldBtn.addTarget(self, action: #selector(boldBtnDidClicked), for: .touchUpInside)
        
        self.toolbar.fontBtn1.addTarget(self, action: #selector(fontChange(_:)), for: .touchUpInside)
        self.toolbar.fontBtn2.addTarget(self, action: #selector(fontChange(_:)), for: .touchUpInside)
        self.toolbar.fontBtn3.addTarget(self, action: #selector(fontChange(_:)), for: .touchUpInside)
        self.toolbar.fontBtn4.addTarget(self, action: #selector(fontChange(_:)), for: .touchUpInside)
        self.toolbar.fontBtn5.addTarget(self, action: #selector(fontChange(_:)), for: .touchUpInside)
        
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
    
    //NSAttributedString -> html
    @objc
    func convertNSAttributeToHtml(){
        let text = NSAttributedString(attributedString: textView.attributedText)
        print(text.attributedString2Html)
    }
    
    //html -> NSAttributedString
    func convertHtmlToNSAttributeString(){
        
        let text = Optional("<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01//EN\" \"http://www.w3.org/TR/html4/strict.dtd\">\n<html>\n<head>\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n<meta http-equiv=\"Content-Style-Type\" content=\"text/css\">\n<title></title>\n<meta name=\"Generator\" content=\"Cocoa HTML Writer\">\n<style type=\"text/css\">\np.p1 {margin: 0.0px 0.0px 0.0px 0.0px; line-height: 25.0px; font: 15.0px \'Apple SD Gothic Neo\'; color: #000000}\nspan.s1 {font-family: \'AppleSDGothicNeo-SemiBold\'; font-weight: bold; font-style: normal; font-size: 15.00px; text-decoration: underline}\nspan.s2 {font-family: \'AppleSDGothicNeo-Medium\'; font-weight: normal; font-style: normal; font-size: 15.00px; text-decoration: underline}\nspan.s3 {font-family: \'AppleSDGothicNeo-Medium\'; font-weight: normal; font-style: normal; font-size: 15.00px; text-decoration: line-through}\n</style>\n</head>\n<body>\n<p class=\"p1\"><span class=\"s1\">&#xAC00;&#xB098;</span><span class=\"s2\">&#xB2E4;&#xB77C;</span><span class=\"s3\">&#xB9C8;&#xBC14;&#xC0AC;&#xC544;</span></p>\n</body>\n</html>\n")
        
        if let string = text{
            let data = Data(string.utf8)
            
            if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
                textView.attributedText = attributedString
            }
        }
        
    }
    
    @objc
    func fontChange(_ sender: UIButton){
        
        //TODO: - 현재 폰트와 동일할 경우 함수 종료시키기
        
        let font: DiaryFontType!
        
        switch sender{
        case self.toolbar.fontBtn1:
            font = .font1
            break
        case self.toolbar.fontBtn2:
            font = .font2
            break
        case self.toolbar.fontBtn3:
            font = .font3
            break
        case self.toolbar.fontBtn4:
            font = .font4
            break
        case self.toolbar.fontBtn5:
            font = .font5
            break
        default:
            return
        }
        
        self.currentFont.fontName = font
        self.textView.font = currentFont.returnFont(.normal)
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
        
        var fontStyle: styleType!
        
        if let fontName = attribute?.fontName{
            fontStyle = fontName == currentFont.normal ? .bold : .normal
        }
        
        let attributedString = NSMutableAttributedString(attributedString: textView.attributedText)
        
        attributedString.addAttribute(.font,
                                      value: currentFont.returnFont(fontStyle),
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

extension NSAttributedString {
    var attributedString2Html: String? {
        do {
            let htmlData = try self.data(from: NSRange(location: 0, length: self.length), documentAttributes:[.documentType: NSAttributedString.DocumentType.html]);
            return String.init(data: htmlData, encoding: String.Encoding.utf8)
        } catch {
            print("error:", error)
            return nil
        }
    }
}
