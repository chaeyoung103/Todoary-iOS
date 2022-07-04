//
//  AgreementViewController.swift
//  Todoary
//
//  Created by 예리 on 2022/07/02.
//

import Foundation
import UIKit
import SnapKit
import Then

extension UIButton {
    func setUnderline() {
        guard let title = title(for: .normal) else { return }
        let attributedString = NSMutableAttributedString(string: title)
        attributedString.addAttribute(.underlineStyle,
                                      value: NSUnderlineStyle.single.rawValue,
                                      range: NSRange(location: 0, length: title.count)
        )
        setAttributedTitle(attributedString, for: .normal)
    }
}

class AgreementViewController : UIViewController {
    
    //MARK: - UIComponenets
    
    //navigationView
    let agreeNavigationView = NavigationView().then {
        $0.navigationTitle.text = "약관동의"
    }

    //텍스트

    let agreeTitle = UILabel().then{
        $0.text = "Todoary 서비스 이용약관에 동의해 주세요."
        $0.textColor = .headline
        $0.font = UIFont.nbFont(type: .subtitle)
    }
    
    let allCheckText = UILabel().then{
        $0.text = "전체동의"
        $0.textColor = .headline
        $0.font = UIFont.nbFont(type: .subtitle)
    }
    
    //약관 제목
    let privacyTitle = UIButton().then{
        $0.setTitle("개인 정보 취급방침 동의 (필수)", for: .normal)
        $0.setTitleColor(.headline, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .body1)
        $0.setUnderline()
    }
    
    let useServiceTitle = UIButton().then{
        $0.setTitle("서비스 이용약관 동의 (필수)", for: .normal)
        $0.setTitleColor(.headline, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .body1)
        $0.setUnderline()
    }
    
    let adTitle = UIButton().then{
        $0.setTitle("광고성 정보 수신 동의 (선택)", for: .normal)
        $0.setTitleColor(.headline, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .body1)
        $0.titleLabel?.textAlignment = .left
        $0.setUnderline()
    }
    
    let locationTitle = UIButton().then{
        $0.setTitle("위치정보 이용 동의 (선택)", for: .normal)
        $0.setTitleColor(.headline, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .body1)
        $0.titleLabel?.textAlignment = .left
        $0.setUnderline()
    }


    //약관 체크버튼
    
    let allCheckBtn = UIButton().then{
        $0.setImage(UIImage(named: "check_box"), for: .normal)
        $0.setImage(UIImage(named: "check_box_outline_blank"), for: .normal)
    }
    
    let privacyCheckBtn = UIButton().then{
        $0.setImage(UIImage(named: "check_box"), for: .normal)
        $0.setImage(UIImage(named: "check_box_outline_blank"), for: .normal)
        
    }
    
    let useServiceCheckBtn = UIButton().then{
        $0.setImage(UIImage(named: "check_box"), for: .normal)
        $0.setImage(UIImage(named: "check_box_outline_blank"), for: .selected)
        
    }
    
    let adCheckBtn = UIButton().then{
        $0.setImage(UIImage(named: "check_box"), for: .normal)
        $0.setImage(UIImage(named: "check_box_outline_blank"), for: .normal)
        
    }
    
    let locationCheckBtn = UIButton().then{
        $0.setImage(UIImage(named: "check_box"), for: .normal)
        $0.setImage(UIImage(named: "check_box_outline_blank"), for: .normal)
        
    }

    
    //BorderLine
    let privacyBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }
    
    let useServiceBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }

    let adBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }

    let locationBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }

    let agreeAllBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }
    
    //버튼
    let confirmBtn = UIButton().then{
        $0.setTitle("확인", for: .normal)
        $0.backgroundColor = .buttonColor
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .button1)
        $0.layer.cornerRadius = 52/2
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        setUpView()
        setUpConstraint()
    }

}
