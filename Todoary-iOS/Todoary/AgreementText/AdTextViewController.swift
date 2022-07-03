//
//  AdTextViewController.swift
//  Todoary
//
//  Created by 예리 on 2022/07/04.
//

import Foundation
import UIKit
import SnapKit
import Then

//lineHeight 설정
extension UILabel {
     func setAdTextWithLineHeight(text: String?, lineHeight: CGFloat){
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
}


class AdTextViewController : UIViewController {
    
    //MARK: - UIComponenets
    
    //약관내용

    let contentScrollView = UIScrollView().then{
        $0.backgroundColor = .white
        $0.showsVerticalScrollIndicator = true
        $0.isScrollEnabled = true
        $0.indicatorStyle = .black
    }
    
    let AdText = UILabel().then{
        $0.numberOfLines = 0
        $0.textAlignment = .left
        $0.textColor = .headline
        $0.font = UIFont.nbFont(type: .body1)
        $0.setAdTextWithLineHeight(
            text: "광고성정보수신동의광고성정보수신동의광고성정보수신동의광고성정보수신동의광고성정보수신동의광고성정보수신동의광고성정보수신동의광고성정보수신동의광고성정보수신동의광고성정보수신동의광고성정보수신동의광고성정보수신동의광고성정보수신동의광고성정보수신동의광고성정보수신동의광고성정보수신동의광고성정보수신동의광고성정보수신동의광고성정보수신동의광고성정보수신동의광고성정보수신동의광고성정보수신동의광고성정보수신동의광고성정보수신동의광고성정보수신동의광고성정보수신동의광고성정보수신동의광고성정보수신동의광고성정보수신동의광고성정보수신동의광고성정보수신동의광고성정보수신동의광고성정보수신동의광고성정보수신동의광고성정보수신동의광고성정보수신동의광고성정보수신동의광고성정보수신동의광고성정보수신동의광고성정보수신동의광고성정보수신동의광고성정보수신동의광고성정보수신동의광고성정보수신동의광고성정보수신동의광고성정보수신동의광고성정보수신동의광고성정보수신동의광고성정보수신동의광고성정보수신동의광고성정보수신동의광고성정보수신동의광고성정보수신동의광고성정보수신동의",
            lineHeight: 21)
    
    }

    override func viewDidLoad() {
    
        super.viewDidLoad()

        setUpView()
        setUpConstraint()
    }

}
