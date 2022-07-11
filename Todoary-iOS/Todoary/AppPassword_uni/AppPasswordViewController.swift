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
    
    var password: String = ""
    
    var inputPw1Fill = false{
        didSet{
            self.validatePw1Fill()
        }
    }
    
    var inputPw2Fill = false{
        didSet{
            self.validatePw2Fill()
        }
    }
    
    var inputPw3Fill = false{
        didSet{
            self.validatePw3Fill()
        }
    }
    
    var inputPw4Fill = false{
        didSet{
            self.validatePw4Fill()
        }
    }
    

    //text

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
    
    //MARK: - input not password
    let inputNotPw1 = UIImageView().then{
        $0.image = UIImage(named: "inputNotPassword")
    }
    
    let inputNotPw2 = UIImageView().then{
        $0.image = UIImage(named: "inputNotPassword")
    }
    
    let inputNotPw3 = UIImageView().then{
        $0.image = UIImage(named: "inputNotPassword")
    }
    
    let inputNotPw4 = UIImageView().then{
        $0.image = UIImage(named: "inputNotPassword")
    }
    
    //MARK: - input password
    let inputPw1 = UIImageView().then{
        $0.image = UIImage(named: "inputPassword")
        $0.isHidden = true
    }
    
    let inputPw2 = UIImageView().then{
        $0.image = UIImage(named: "inputPassword")
        $0.isHidden = true
    }
    
    let inputPw3 = UIImageView().then{
        $0.image = UIImage(named: "inputPassword")
        $0.isHidden = true
    }
    
    let inputPw4 = UIImageView().then{
        $0.image = UIImage(named: "inputPassword")
        $0.isHidden = true
    }
    
    //MARK: - numbutton
    //button
    
    let numBtn1 =  UIButton().then{
        $0.setTitle( "1", for: .normal)
        $0.backgroundColor = .numberBtnColor
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .numberBtn)
        $0.addTarget(self, action: #selector(numBtndidTab), for: .touchUpInside)
    }
    
    let numBtn2 =  UIButton().then{
        $0.setTitle( "2", for: .normal)
        $0.backgroundColor = .numberBtnColor
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .numberBtn)
        $0.addTarget(self, action: #selector(numBtndidTab), for: .touchUpInside)
    }
    
        
    let numBtn3 =  UIButton().then{
        $0.setTitle( "3", for: .normal)
        $0.backgroundColor = .numberBtnColor
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .numberBtn)
    }
        
    let numBtn4 =  UIButton().then{
        $0.setTitle( "4", for: .normal)
        $0.backgroundColor = .numberBtnColor
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .numberBtn)
    }

    let numBtn5 =  UIButton().then{
        $0.setTitle( "5", for: .normal)
        $0.backgroundColor = .numberBtnColor
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .numberBtn)
    }
    
    let numBtn6 =  UIButton().then{
        $0.setTitle( "6", for: .normal)
        $0.backgroundColor = .numberBtnColor
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .numberBtn)
    }
    
    let numBtn7 =  UIButton().then{
        $0.setTitle( "7", for: .normal)
        $0.backgroundColor = .numberBtnColor
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .numberBtn)
    }
    
    let numBtn8 =  UIButton().then{
        $0.setTitle( "8", for: .normal)
        $0.backgroundColor = .numberBtnColor
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .numberBtn)
    }
    
    let numBtn9 =  UIButton().then{
        $0.setTitle( "9", for: .normal)
        $0.backgroundColor = .numberBtnColor
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .numberBtn)
    }
    
    let numBtn0 =  UIButton().then{
        $0.setTitle( "0", for: .normal)
        $0.backgroundColor = .numberBtnColor
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .numberBtn)
    }
 
    //MARK: - UIComponenets
    let deletBtn = UIButton().then{
        $0.setImage(UIImage(systemName: "delete.backward"), for: .normal)
        $0.tintColor = .black
        $0.contentMode = .scaleToFill
        $0.addTarget(self, action: #selector(numBtndidTab), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        setUpView()
        setUpConstraint()
    }
    
    
    func validatePw1Fill(){
        if inputPw1Fill
        { inputPw1.isHidden = false
        }else{ inputPw1.isHidden = true
        }
    }
    
    func validatePw2Fill(){
        if inputPw2Fill
        { inputPw2.isHidden = false
        }else{ inputPw2.isHidden = true
        }
    }
    
    func validatePw3Fill(){
        if inputPw3Fill
        { inputPw3.isHidden = false
        }else{ inputPw3.isHidden = true
        }
    }
    
    func validatePw4Fill(){
        if inputPw4Fill
        { inputPw4.isHidden = false
        }else{ inputPw4.isHidden = true
        }
    }
    
    
    @objc func numBtndidTab() {
        if numBtn1.isTouchInside
        && numBtn2.isTouchInside
        && numBtn3.isTouchInside {
            inputPw1Fill = false
        }
        else if inputPw1Fill == true {
            inputPw2Fill = true
        }
        else if inputPw2Fill == true {
            inputPw3Fill = true
        }
        else if inputPw3Fill ==  true {
            inputPw4Fill = true
        } else {
            inputPw1Fill = false
            inputPw2Fill = false
            inputPw3Fill = false
            inputPw4Fill = false
            
        }
    }
}


