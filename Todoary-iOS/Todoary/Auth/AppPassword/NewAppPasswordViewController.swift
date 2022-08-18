//
//  NewAppPasswordViewController.swift
//  Todoary
//
//  Created by 예리 on 2022/08/12.
//

import Foundation
import UIKit
import SnapKit
import Then

class NewAppPasswordViewController : UIViewController {
    
    //MARK: - UIComponenets
    
    var passwordArr : [String] = []
    var passwordArr2 : [String] = []
    
    let defaults = UserDefaults.standard

    //text

    let appPwTitle = UILabel().then{
        $0.text = "암호 입력"
        $0.textColor = .headline
        $0.font = UIFont.nbFont(type: .header)
    }
    
    let newAppPwtext = UILabel().then{
        $0.text = "새로운 암호를 입력해 주세요"
        $0.textColor = .headline
        $0.font = UIFont.nbFont(type: .body1)
        $0.isHidden = false
    }
    
    let newAppPwtext2 = UILabel().then {
        $0.text = "한 번 더 입력해 주세요"
        $0.textColor = .headline
        $0.font = UIFont.nbFont(type: .body1)
        $0.isHidden = true
    }
    
    let pwnotcorrect = UILabel().then {
        $0.text = "다시 입력해 주세요"
        $0.textColor = .headline
        $0.font = UIFont.nbFont(type: .body1)
        $0.isHidden = true
    }
    
    //MARK: - input not password
    
    let inputNotPw = UIStackView().then{
        $0.axis = .horizontal
    }
    
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
    
    let inputPw = UIStackView().then{
        $0.axis = .horizontal
    }
    
    let inputPw1 = UIImageView().then{
        $0.image = UIImage(named: "password1")
        $0.isHidden = true
    }
    
    let inputPw2 = UIImageView().then{
        $0.image = UIImage(named: "password2")
        $0.isHidden = true
    }
    
    let inputPw3 = UIImageView().then{
        $0.image = UIImage(named: "password3")
        $0.isHidden = true
    }
    
    let inputPw4 = UIImageView().then{
        $0.image = UIImage(named: "password4")
        $0.isHidden = true
    }
    
    //MARK: - numbutton
    //button
    
    let numBtn1 =  UIButton().then{
        $0.setTitle( "1", for: .normal)
        $0.backgroundColor = .numberBtnColor
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .numberBtn)
        $0.setBackgroundImage(UIImage(named: "home_profile"), for: UIControl.State.highlighted)
        $0.addTarget(self, action: #selector(firstPwInput), for: .touchUpInside)
        $0.addTarget(self, action: #selector(secondPwInput), for: .touchUpInside)
        $0.addTarget(self, action: #selector(wrongPwInput), for: .touchUpInside)
    }
    
    let numBtn2 =  UIButton().then{
        $0.setTitle( "2", for: .normal)
        $0.backgroundColor = .numberBtnColor
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .numberBtn)
        $0.setBackgroundImage(UIImage(named: "home_profile"), for: UIControl.State.highlighted)
        $0.addTarget(self, action: #selector(firstPwInput), for: .touchUpInside)
        $0.addTarget(self, action: #selector(secondPwInput), for: .touchUpInside)
        $0.addTarget(self, action: #selector(wrongPwInput), for: .touchUpInside)
        

    }
    
        
    let numBtn3 =  UIButton().then{
        $0.setTitle( "3", for: .normal)
        $0.backgroundColor = .numberBtnColor
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .numberBtn)
        $0.setBackgroundImage(UIImage(named: "home_profile"), for: UIControl.State.highlighted)
        $0.addTarget(self, action: #selector(firstPwInput), for: .touchUpInside)
        $0.addTarget(self, action: #selector(secondPwInput), for: .touchUpInside)
        $0.addTarget(self, action: #selector(wrongPwInput), for: .touchUpInside)


    }
        
    let numBtn4 =  UIButton().then{
        $0.setTitle( "4", for: .normal)
        $0.backgroundColor = .numberBtnColor
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .numberBtn)
        $0.setBackgroundImage(UIImage(named: "home_profile"), for: UIControl.State.highlighted)
        $0.addTarget(self, action: #selector(firstPwInput), for: .touchUpInside)
        $0.addTarget(self, action: #selector(secondPwInput), for: .touchUpInside)
        $0.addTarget(self, action: #selector(wrongPwInput), for: .touchUpInside)
    }

    let numBtn5 =  UIButton().then{
        $0.setTitle( "5", for: .normal)
        $0.backgroundColor = .numberBtnColor
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .numberBtn)
        $0.setBackgroundImage(UIImage(named: "home_profile"), for: UIControl.State.highlighted)
        $0.addTarget(self, action: #selector(firstPwInput), for: .touchUpInside)
        $0.addTarget(self, action: #selector(secondPwInput), for: .touchUpInside)
        $0.addTarget(self, action: #selector(wrongPwInput), for: .touchUpInside)
    }
    
    let numBtn6 =  UIButton().then{
        $0.setTitle( "6", for: .normal)
        $0.backgroundColor = .numberBtnColor
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .numberBtn)
        $0.setBackgroundImage(UIImage(named: "home_profile"), for: UIControl.State.highlighted)
        $0.addTarget(self, action: #selector(firstPwInput), for: .touchUpInside)
        $0.addTarget(self, action: #selector(secondPwInput), for: .touchUpInside)
        $0.addTarget(self, action: #selector(wrongPwInput), for: .touchUpInside)
    }
    
    let numBtn7 =  UIButton().then{
        $0.setTitle( "7", for: .normal)
        $0.backgroundColor = .numberBtnColor
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .numberBtn)
        $0.setBackgroundImage(UIImage(named: "home_profile"), for: UIControl.State.highlighted)
        $0.addTarget(self, action: #selector(firstPwInput), for: .touchUpInside)
        $0.addTarget(self, action: #selector(secondPwInput), for: .touchUpInside)
        $0.addTarget(self, action: #selector(wrongPwInput), for: .touchUpInside)
    }
    
    let numBtn8 =  UIButton().then{
        $0.setTitle( "8", for: .normal)
        $0.backgroundColor = .numberBtnColor
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .numberBtn)
        $0.setBackgroundImage(UIImage(named: "home_profile"), for: UIControl.State.highlighted)
        $0.addTarget(self, action: #selector(firstPwInput), for: .touchUpInside)
        $0.addTarget(self, action: #selector(secondPwInput), for: .touchUpInside)
        $0.addTarget(self, action: #selector(wrongPwInput), for: .touchUpInside)
    }
    
    let numBtn9 =  UIButton().then{
        $0.setTitle( "9", for: .normal)
        $0.backgroundColor = .numberBtnColor
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .numberBtn)
        $0.setBackgroundImage(UIImage(named: "home_profile"), for: UIControl.State.highlighted)
        $0.addTarget(self, action: #selector(firstPwInput), for: .touchUpInside)
        $0.addTarget(self, action: #selector(secondPwInput), for: .touchUpInside)
        $0.addTarget(self, action: #selector(wrongPwInput), for: .touchUpInside)
    }
    
    let numBtn0 =  UIButton().then{
        $0.setTitle( "0", for: .normal)
        $0.backgroundColor = .numberBtnColor
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .numberBtn)
        $0.setBackgroundImage(UIImage(named: "home_profile"), for: UIControl.State.highlighted)
        $0.addTarget(self, action: #selector(firstPwInput), for: .touchUpInside)
        $0.addTarget(self, action: #selector(secondPwInput), for: .touchUpInside)
        $0.addTarget(self, action: #selector(wrongPwInput), for: .touchUpInside)
    }
    
    let blueCharacter = UIImageView().then{
        $0.image = UIImage(named: "password5")
    }

 
    //MARK: - UIComponenets_deletBtn
    let deletBtn = UIButton().then{
        $0.setImage(UIImage(named: "backspace"), for: .normal)
        $0.tintColor = .black
        $0.contentMode = .scaleToFill
        $0.addTarget(self, action: #selector(deletBtndidtab), for: .touchUpInside)
        $0.addTarget(self, action: #selector(deletBtndidtab2), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = .white

        setUpView()
        setUpConstraint()
    }
    
    
       //MARK: - numbtndidtab
    
    //비밀번호 처음 설정할 때
    
    @objc func firstPwInput(sender : UIButton) {
        
        if newAppPwtext.isHidden == false {
            
            //숫자버튼 누름면 타이틀 값(숫자) 배열에 저장
            let numdigit = sender.currentTitle!
            passwordArr.append(numdigit)
            
            let pwarraycount = passwordArr.count
            
            switch pwarraycount {
            case 1 :
                inputPw1.isHidden = false
                
            case 2 :
                inputPw2.isHidden = false
                
            case 3 :
                inputPw3.isHidden = false
                
            case 4 :
                inputPw4.isHidden = false
                print(passwordArr)
                
                //이미지 보이기 위한 딜레이
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) { [self] in
                    
                    newAppPwtext.isHidden = true
                    //비밀번호를 4자리 설정했다면, 비밀번화 확인 입력 문구 보이게 만들어주기
                    newAppPwtext2.isHidden = false
                    inputPw1.isHidden = true
                    inputPw2.isHidden = true
                    inputPw3.isHidden = true
                    inputPw4.isHidden = true
                }
            default:
                return
            }
        }
    }

    //비밀번호 같은지 확인하기
    
    @objc func secondPwInput(sender : UIButton) {
        
        if newAppPwtext2.isHidden == false {
            
            let numdigit = sender.currentTitle!
            //숫자버튼 누름면 타이틀 값(숫자) 배열에 저장, 비교를 위해 새로운 배열(passwordArr2)에 저장
            passwordArr2.append(numdigit)
            
            let pwarraycount = passwordArr2.count
            
            switch pwarraycount {
            case 1 :
                inputPw1.isHidden = false
                
            case 2 :
                inputPw2.isHidden = false
                
            case 3 :
                inputPw3.isHidden = false
                
            case 4 :
                inputPw4.isHidden = false
                print(passwordArr)
                print(passwordArr2)
                
                //비밀번호 4자리 모두 입려했을 때, 처음 비밀번호 설정(passwordArr)과 확인 비밀번호 설정(passwordArr2)이 같은지 확인
                if passwordArr == passwordArr2 {
                    defaults.set(passwordArr2, forKey: "newPasswordArr")
//                    defaults.object(forKey: "newPasswordArr")
                    print(UserDefaults.standard.stringArray(forKey: "newPasswordArr"))
                    
                    //이미지 보이기 위해 딜레이
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {

                        //비밀번호 같다면 설정화면으로 넘어가기
                        self.navigationController?.popViewController(animated: true)
                    }
                    
                } else {
                    //같지 않다면 배열 지워주고, 다시 입력 페이지로 넘어가기
                    
                    //이미지 보이기 위한 딜레이
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) { [self] in
                        
                        passwordArr2.removeAll()
                        newAppPwtext.isHidden = true
                        newAppPwtext2.isHidden = true
                        pwnotcorrect.isHidden = false
                        inputPw1.isHidden = true
                        inputPw2.isHidden = true
                        inputPw3.isHidden = true
                        inputPw4.isHidden = true
                }
            }
                
            default:
                return
            }
        }
    }
    
    //다시 입력 페이지
    
    @objc func wrongPwInput(sender : UIButton) {
        
        if pwnotcorrect.isHidden == false {
            
            //숫자버튼 누름면 타이틀 값(숫자) 배열에 저장, 비교를 위해 확인 입력 에서 지웠던 배열(passwordArr2)에 저장
            let numdigit = sender.currentTitle!
            passwordArr2.append(numdigit)
            
            let pwarraycount = passwordArr2.count
            
            switch pwarraycount {
            case 1 :
                inputPw1.isHidden = false
                
            case 2 :
                inputPw2.isHidden = false
                
            case 3 :
                inputPw3.isHidden = false
                
            case 4 :
                inputPw4.isHidden = false
                print(passwordArr)
                print(passwordArr2)
                
                if passwordArr == passwordArr2 {
                    defaults.set(passwordArr2, forKey: "newPasswordArr")
                    defaults.object(forKey: "newPasswordArr")
                    print(UserDefaults.standard.stringArray(forKey: "newPasswordArr"))
                    
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
                        
                        self.navigationController?.popViewController(animated: true)
   }
                    
                    
                } else {
                    passwordArr2.removeAll()
                    newAppPwtext.isHidden = true
                    newAppPwtext2.isHidden = true
                    pwnotcorrect.isHidden = false
                    
                    //이미지 보이기 위한 딜레이
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) { [self] in
                        
                        inputPw1.isHidden = true
                        inputPw2.isHidden = true
                        inputPw3.isHidden = true
                        inputPw4.isHidden = true
                }
            }
                
            default:
                return
            }
        }
    }
    
    //처음 비밀번호 확인페이지에서 deletBtn누를 때 배열 passwordArr항목 지우기

    @objc
    func deletBtndidtab(sender : UIButton) {
        
        let pwarraycount = passwordArr.count
        
        if newAppPwtext.isHidden == false{
            
            if deletBtn.isTouchInside {
                switch pwarraycount {
                case 4 :
                    inputPw4.isHidden = true
                    passwordArr.removeLast()
                    
                case 3 :
                    inputPw3.isHidden = true
                    passwordArr.removeLast()
                    
                case 2 :
                    inputPw2.isHidden = true
                    passwordArr.removeLast()
                    
                case 1 :
                    inputPw1.isHidden = true
                    passwordArr.removeLast()
                    
                default :
                    return
                }
            }
        }
    }
    
    //확인입력, 다시입력 비밀번호 확인페이지에서 deletBtn누를 때 배열 passwordArr2항목 지우기
    //같은 버튼에 타겟이라 상황 설정
    
    @objc
    func deletBtndidtab2(sender : UIButton) {
        
        if newAppPwtext2.isHidden == false ||
            pwnotcorrect.isHidden == false {
            
            let pwarraycount = passwordArr2.count
            
            if deletBtn.isTouchInside {
                switch pwarraycount {
                case 4 :
                    inputPw4.isHidden = true
                    passwordArr2.removeLast()
                    
                case 3 :
                    inputPw3.isHidden = true
                    passwordArr2.removeLast()
                    
                case 2 :
                    inputPw2.isHidden = true
                    passwordArr2.removeLast()
                    
                case 1 :
                    inputPw1.isHidden = true
                    passwordArr2.removeLast()
                    
                    
                default :
                    return
                }
            }
        }
    }
}



