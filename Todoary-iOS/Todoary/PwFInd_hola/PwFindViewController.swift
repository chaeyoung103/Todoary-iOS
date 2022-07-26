//
//  PwFindViewController.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/02.
//

import UIKit
import SnapKit
import Then

class PwFindViewController: UIViewController {
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
    
    //navigation bar
    var navigationView:NavigationView!
    
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
        
        navigationView = NavigationView(frame: .zero , self.navigationController!).then{
            $0.navigationTitle.text = "비밀번호 재설정"
        }
        self.view.backgroundColor = .white

        setUpView()
        setUpConstraint()
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
        
        let alert = UIAlertController(title: alertTitle, message: nil, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Helpers
    
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
            
            MailSender.shared.sendEmail("thdcodud103@naver.com")
            
            //이메일 사용 가능한 경우, 메일 발송 팝업 띄우기
            let alert = UIAlertController(title: "인증코드가 메일로 발송되었습니다.", message: nil, preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            
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
