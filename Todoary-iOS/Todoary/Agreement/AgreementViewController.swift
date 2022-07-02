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


class AgreementViewController : UIViewController {
    
    //MARK: - UIComponenets

    //텍스트

    let agreeTitle = UILabel().then{
        $0.text = "Todoary 서비스 이용약관에 동의해 주세요."
        $0.textColor = .headline
        $0.font = UIFont.nbFont(type: .subtitle)
    }

    //버튼
    let confirmButton = UIButton().then{
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

