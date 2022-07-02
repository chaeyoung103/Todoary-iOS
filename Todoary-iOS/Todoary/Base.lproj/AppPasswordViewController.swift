//
//  AppPasswordViewController.swift
//  Todoary
//
//  Created by 예리 on 2022/07/02.
//
import Foundation
import UIKit
import SnapKit
import Then

class AppPasswordViewController : UIViewController {
    
    //MARK: - UIComponenets

    //텍스트

    let appPwTitle = UILabel().then{
        $0.text = "암호 입력"
        $0.textColor = .headline
        $0.font = UIFont.nbFont(type: .header)
    }
    
    let appPwtext = UILabel().then{
        $0.text = "암호를 입력해 주세요"
        $0.textColor = .headline
        $0.font = UIFont.nbFont(type: .body1)
    }
    
    //비밀번호 이미지


    //버튼
    
    let nemberBtn1 =  UIButton().then{
        $0.setTitle( "1", for: .normal)
        $0.backgroundColor = .numberBtnColor
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .numberBtn)
    }
    
    let nemberBtn2 =  UIButton().then{
        $0.setTitle( "2", for: .normal)
        $0.backgroundColor = .numberBtnColor
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .numberBtn)
    }
    
        
    let nemberBtn3 =  UIButton().then{
        $0.setTitle( "3", for: .normal)
        $0.backgroundColor = .numberBtnColor
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .numberBtn)
    }
        
    let nemberBtn4 =  UIButton().then{
        $0.setTitle( "4", for: .normal)
        $0.backgroundColor = .numberBtnColor
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .numberBtn)
    }

    let nemberBtn5 =  UIButton().then{
        $0.setTitle( "5", for: .normal)
        $0.backgroundColor = .numberBtnColor
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .numberBtn)
    }
    
    let nemberBtn6 =  UIButton().then{
        $0.setTitle( "6", for: .normal)
        $0.backgroundColor = .numberBtnColor
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .numberBtn)
    }
    
    let nemberBtn7 =  UIButton().then{
        $0.setTitle( "7", for: .normal)
        $0.backgroundColor = .numberBtnColor
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .numberBtn)
    }
    
    let nemberBtn8 =  UIButton().then{
        $0.setTitle( "8", for: .normal)
        $0.backgroundColor = .numberBtnColor
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .numberBtn)
    }
    
    let nemberBtn9 =  UIButton().then{
        $0.setTitle( "9", for: .normal)
        $0.backgroundColor = .numberBtnColor
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .numberBtn)
    }
    
    let nemberBtn0 =  UIButton().then{
        $0.setTitle( "0", for: .normal)
        $0.backgroundColor = .numberBtnColor
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .numberBtn)
    }
    
    let deletBnt = UIButton().then{
        $0.setImage(UIImage(systemName: "delete.backward"), for: .normal)
        $0.tintColor = .black
        $0.contentMode = .scaleToFill
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        setUpView()
        setUpConstraint()
    }

}
