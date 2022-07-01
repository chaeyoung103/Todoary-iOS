//
//  SignUpViewController.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/01.
//

import UIKit
import SnapKit
import Then

class SignUpViewController: UIViewController {
    
    //MARK: - UIComponenets
    
    let navigationBar = UIView()
    
    //id
    let idTitle = UILabel().then{
        $0.text = "아이디"
        $0.textColor = .headline
        $0.font = UIFont.nbFont(type: .header)
    }
    
    let idTextField = UITextField().then{
        $0.placeholder = "이메일"
        $0.font = UIFont.nbFont(type: .body2)
    }
    
    let idBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }
    
    let emailSignLabel = UILabel().then{
        $0.text = "@"
        $0.font = UIFont.nbFont(type: .body2)
        $0.textColor = .todoaryGrey
    }
    
    let emailLabel = UILabel().then{
        $0.text = "선택"
        $0.font = UIFont.nbFont(type: .body2)
        $0.textColor = .todoaryGrey
    }
    
    let emailBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }
    
    let emailArrowButton = UIButton().then{
        $0.setImage(UIImage(named: "arrow_down"), for: .normal)
    }
    
    let idCertificationButton = UIButton().then{
        $0.setTitle("인증하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .subButton)
        $0.backgroundColor = .buttonColor
        $0.layer.cornerRadius = 22/2
    }
    
    //인증코드
    let certificationTitle = UILabel().then{
        $0.text = "인증코드 입력"
        $0.textColor = .headline
        $0.font = UIFont.nbFont(type: .header)
        
    }

    let certificationTextField = UITextField().then{
        $0.font = UIFont.nbFont(type: .body2)
    }

    let certificationBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }
    
    let certificationOkButton = UIButton().then{
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .subButton)
        $0.backgroundColor = .buttonColor
        $0.layer.cornerRadius = 22/2
    }

    //pw
    let pwTitle = UILabel().then{
        $0.text = "비밀번호"
        $0.textColor = .headline
        $0.font = UIFont.nbFont(type: .header)
    }

    let pwTextField = UITextField().then{
        $0.placeholder = "영문, 숫자 포함 8자리 이상"
        $0.font = UIFont.nbFont(type: .body2)
    }

    let pwBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }

    let pwCertificationField = UITextField().then{
        $0.font = UIFont.nbFont(type: .body2)
    }

    let pwCertificationBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }

    let pwInCorrectLabel = UILabel().then{
        $0.text = "비밀번호가 일치하지 않습니다"
        $0.textColor = .todoaryGrey
        $0.font = UIFont.nbFont(type: .body2)
    }

    //name
    let nameTitle = UILabel().then{
        $0.text = "이름"
        $0.textColor = .headline
        $0.font = UIFont.nbFont(type: .header)
    }

    let nameTextField = UITextField().then{
        $0.font = UIFont.nbFont(type: .body2)
    }

    let nameBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }

    //nickname
    let nickNameTitle = UILabel().then{
        $0.text = "닉네임"
        $0.textColor = .headline
        $0.font = UIFont.nbFont(type: .header)
    }

    let nickNameTextField = UITextField().then{
        $0.textColor = .todoaryGrey
        $0.font = UIFont.nbFont(type: .body2)
        $0.text = "Todoary에서 사용하실 닉네임을 알려주세요"
    }

    let nickNameBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }

    let nextButton = UIButton().then{
        $0.setTitle("다음으로", for: .normal)
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
