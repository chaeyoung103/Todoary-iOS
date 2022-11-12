//
//  PwFindViewController.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/02.
//

import UIKit
import SnapKit
import Then

class PwFindViewController: BaseViewController, UITextFieldDelegate {
    //MARK: - Properties
    
    var password: String = ""
    var email: String = ""
    var certification: String = ""
    
    var emailCheck = false{
        didSet {//프로퍼티 옵저버
            self.validateUserInput()
        }
    }
    var isValidPw = false {
        didSet {//프로퍼티 옵저버
            self.validateUserInput()
        }
    }
    
    var isValidPwCheck = false {
        didSet {//프로퍼티 옵저버
            self.validateUserInput()
        }
    }
    
    var isCertification = false {
        didSet {//프로퍼티 옵저버
            self.validateUserInput()
        }
    }
    
    //MARK: - UIComponenets
    
    //id
    let idTitle = UILabel().then{
        $0.text = "아이디"
        $0.textColor = .headline
        $0.font = UIFont.nbFont(type: .subtitle)
        $0.addLetterSpacing(spacing: 0.32)
    }
    
    let idTf = UITextField().then{
        $0.placeholder = "이메일을 입력해주세요"
        $0.setPlaceholderColor()
        $0.font = UIFont.nbFont(type: .body2)
        $0.textFieldTypeSetting(type: .body1)
        $0.returnKeyType = .next
        $0.enablesReturnKeyAutomatically = true
    }
    
    let idNoticeLb = UILabel().then{
        $0.text = "*가입시 등록했던 이메일을 입력해주세요 "
        $0.textColor = .todoaryGrey
        $0.addLetterSpacing(spacing: 0.36)
        $0.font = UIFont.nbFont(type: .sub1)
    }
    
    let idBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }
    
    let idCertificationBtn = UIButton().then{
        $0.setTitle("인증하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .subButton)
        $0.buttonTypeSetting(type: .subButton)
        $0.backgroundColor = .buttonColor
        $0.layer.cornerRadius = 22/2
        $0.addTarget(self, action: #selector(idCertificationBtnDidTap), for: .touchUpInside)
    }
    
    //인증코드
    let certificationTitle = UILabel().then{
        $0.text = "인증코드 입력"
        $0.textColor = .headline
        $0.font = UIFont.nbFont(type: .subtitle)
        $0.addLetterSpacing(spacing: 0.32)
        
    }

    let certificationTf = UITextField().then{
        $0.font = UIFont.nbFont(type: .body2)
        $0.returnKeyType = .next
        $0.enablesReturnKeyAutomatically = true
    }

    let certificationBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }
    
    let certificationOkBtn = UIButton().then{
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .subButton)
        $0.buttonTypeSetting(type: .subButton)
        $0.backgroundColor = .buttonColor
        $0.layer.cornerRadius = 22/2
        $0.addTarget(self, action: #selector(certificationOkBtnDidTap), for: .touchUpInside)
    }

    //pw
    let pwTitle = UILabel().then{
        $0.text = "비밀번호 재설정"
        $0.textColor = .headline
        $0.font = UIFont.nbFont(type: .subtitle)
        $0.addLetterSpacing(spacing: 0.32)
    }

    let pwTf = UITextField().then{
        $0.placeholder = "영문, 숫자 포함 8자리 이상"
        $0.isSecureTextEntry = true
        $0.setPlaceholderColor()
        $0.font = UIFont.nbFont(type: .body2)
        $0.textFieldTypeSetting(type: .body1)
        $0.returnKeyType = .next
        $0.enablesReturnKeyAutomatically = true
        $0.addTarget(self, action: #selector(tfDidChange), for: .editingChanged)
    }

    let pwBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }
    
    let pwNoticeLb = UILabel().then{
        $0.isHidden = true
        $0.text = "*영문, 숫자 포함 8자리 이상 입력해주세요 "
        $0.labelTypeSetting(type: .sub1)
        $0.textColor = .noticeRed
        $0.font = UIFont.nbFont(type: .sub1)
    }

    let pwCertificationTf = UITextField().then{
        $0.placeholder = "비밀번호 재입력"
        $0.setPlaceholderColor()
        $0.isSecureTextEntry = true
        $0.font = UIFont.nbFont(type: .body2)
        $0.textFieldTypeSetting(type: .body1)
        $0.returnKeyType = .done
        $0.enablesReturnKeyAutomatically = true
        $0.addTarget(self, action: #selector(tfDidChange), for: .editingChanged)
    }

    let pwCertificationBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }
    
    let pwCertificationNoticeLb = UILabel().then{
        $0.isHidden = true
        $0.text = "*비밀번호가 일치하지 않습니다 "
        $0.labelTypeSetting(type: .sub1)
        $0.textColor = .noticeRed
        $0.font = UIFont.nbFont(type: .sub1)
    }


    let confirmBtn = UIButton().then{
        $0.isEnabled = false
        $0.setTitle("확인", for: .normal)
        $0.backgroundColor = .buttonColor
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .button1)
        $0.layer.cornerRadius = 52/2
        $0.addTarget(self, action: #selector(passWordChangeBtnDidTap), for: .touchUpInside)
    }
    
    
    //MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationTitle.text = "비밀번호 재설정"
        self.view.backgroundColor = .white
        
        self.idTf.delegate = self
        self.certificationTf.delegate = self
        self.pwTf.delegate = self
        self.pwCertificationTf.delegate = self


        setUpView()
        setUpConstraint()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        UIView.animate(withDuration: 0.3){
            self.view.window?.frame.origin.y = 0
        }
    }
    
    //MARK: - Actions
    
    @objc func backBtnDidTab() {
        self.navigationController?.popViewController(animated: true)
        }
    
    @objc func tfDidChange(_ sender: UITextField) {
        let text = sender.text ?? ""
        
        switch sender{
        case idTf:
            self.email = text
        case certificationTf:
            self.certification = text
        case pwTf:
            pwNoticeLb.isHidden = false
            self.isValidPw = text.isValidPw()
            self.password = text
            if isValidPw{
                pwNoticeLb.isHidden = true
                }
            else {
                pwNoticeLb.isHidden = false
            }
        case pwCertificationTf:
            pwCertificationNoticeLb.isHidden = false
            if text == self.password {
                isValidPwCheck = true
                pwCertificationNoticeLb.isHidden = true
            }else{
                isValidPwCheck = false
                pwCertificationNoticeLb.isHidden = false
            }
        default:
            fatalError("Missing TextField...")
        }
    }
    

    @objc func idCertificationBtnDidTap() {
        self.email = idTf.text!
        EmailCheckDataManager().emailCheckDataManager(self, email: self.email)
        print(self.email)
        print("버튼")
    }
    
    @objc func passWordChangeBtnDidTap(){
        
        let pwInput = PwFindInput(email:idTf.text!, newPassword: self.password)
        
        PwFindDataManager().pwFindDataManager(self, pwInput)

    }
    
    @objc func certificationOkBtnDidTap(){
        self.certification = certificationTf.text!
        if self.certification == UserDefaults.standard.string(forKey: "key"){
            isCertification = true
        }else{
            isCertification = false
        }
        
        let alertTitle : String!
        
        if isCertification{
            alertTitle = "인증이 완료되었습니다."
        }else{
            alertTitle = "인증코드가 일치하지 않습니다."
        }
        
        let alert = ConfirmAlertViewController(title: alertTitle)
        alert.modalPresentationStyle = .overFullScreen
        self.present(alert, animated: false, completion: nil)
        
    }
    
    //MARK: - Helpers
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == idTf {
            certificationTf.becomeFirstResponder()
            } else if textField == certificationTf {
                pwTf.becomeFirstResponder()
            }else if textField == pwTf {
                pwCertificationTf.becomeFirstResponder()
            }else if textField == pwCertificationTf {
                pwCertificationTf.resignFirstResponder()
            }
            return true
        }
    
    func validateUserInput(){
        if isValidPw
            && isValidPwCheck
            && emailCheck
            && isCertification{
            confirmBtn.isEnabled = true
        }else{
            confirmBtn.isEnabled = false
        }
    }
    

    func checkEmail(_ code: Int){
        
        if(code == 1000) { //사용가능 이메일 점검 조건문 추가
            
            emailCheck = true
            
            idNoticeLb.text = "*유효한 이메일입니다."
            idNoticeLb.textColor = .todoaryGrey
        
            MailSender.shared.sendEmail(email: self.email, viewController: self)
            
        }else if(code == 2017){
            idNoticeLb.text = "*유효하지 않은 이메일입니다. 다시 입력해 주세요."
            idNoticeLb.textColor = .noticeRed
            emailCheck = false
        }else{
            emailCheck = false

        }
    }
}

//정규표현식
extension String {
    func isValidPw() -> Bool {
        //영어,숫자 8자 이상일때 -> True
        let pwRegEx = "^(?=.*[a-z])[A-Za-z\\d$@$!%*?&]{8,}"
        let predicate = NSPredicate.init(format: "SELF MATCHES %@", pwRegEx)
        return predicate.evaluate(with: self)
    }
}
