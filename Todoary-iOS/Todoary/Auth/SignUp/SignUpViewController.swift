//
//  SignUpViewController.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/01.
//

import UIKit
import SnapKit
import Then

class SignUpViewController: UIViewController{
    
    //MARK: - Properties
    
    var email: String = ""
    var certificationCode : String = ""
    var passwd : String = ""
    var passwdCheck : String = ""
    var name : String = ""
    var nickname : String = ""
    
    var isMarketingAgree : Bool! //agreemnetVC에서 마케팅 동의 여부 정보 넘겨받기
    
    var isValidEmail = false{
        didSet{
            self.validateUserInput()
        }
    }
    
    var isValidCertiCode = false{
        didSet{
            self.validateUserInput()
        }
    }
    
    var isValidPasswd = false{
        didSet{
            self.validateUserInput()
        }
    }
    
    var isValidPasswdCheck = false{
        didSet{
            self.validateUserInput()
        }
    }
    
    var isValidName = false{
        didSet{
            self.validateUserInput()
        }
    }
    
    var isValidNickname = false{
        didSet{
            self.validateUserInput()
        }
    }
    
    //MARK: - UI
    
    var navigationView : NavigationView!
    
    //id
    let idTitle = UILabel().then{
        $0.text = "아이디"
        $0.textColor = .headline
        $0.labelTypeSetting(type: .subtitle)
    }
    
    let idTextField = UITextField().then{
        $0.placeholder = "이메일을 입력해주세요"
        $0.textFieldTypeSetting()
        $0.returnKeyType = .next
        $0.enablesReturnKeyAutomatically = true
    }
    
    let idBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }
    
    let idCertificationButton = UIButton().then{
        $0.setTitle("인증하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.buttonTypeSetting(type: .subButton)
        $0.backgroundColor = .buttonColor
        $0.layer.cornerRadius = 22/2
        
        $0.addTarget(self, action: #selector(certificationBtnDidClicked(_:)), for: .touchUpInside)
    }
    
    let idCanUseLabel = UILabel().then{
        $0.labelTypeSetting(type: .sub1)
        $0.isHidden = true
    }
    
    //인증코드
    let certificationTitle = UILabel().then{
        $0.text = "인증코드 입력"
        $0.textColor = .headline
        $0.labelTypeSetting(type: .subtitle)
        
    }

    let certificationTextField = UITextField().then{
        $0.textFieldTypeSetting()
        $0.returnKeyType = .next
        $0.enablesReturnKeyAutomatically = true
    }

    let certificationBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }
    
    let certificationOkButton = UIButton().then{
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.buttonTypeSetting(type: .subButton)
        $0.backgroundColor = .buttonColor
        $0.layer.cornerRadius = 22/2
        $0.addTarget(self, action: #selector(certificationOKBtnDidClicked(_:)), for: .touchUpInside)
    }

    //pw
    let pwTitle = UILabel().then{
        $0.text = "비밀번호"
        $0.textColor = .headline
        $0.labelTypeSetting(type: .subtitle)
    }

    let pwTextField = UITextField().then{
        $0.placeholder = "영문, 숫자 포함 8자리 이상"
        $0.textFieldTypeSetting()
        $0.isSecureTextEntry = true
        $0.returnKeyType = .next
        $0.enablesReturnKeyAutomatically = true
    }

    let pwBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }
    
    let pwCanUseLabel = UILabel().then{
        $0.text = "*영문, 숫자 포함 8자리 이상 "
        $0.textColor = .noticeRed
        $0.labelTypeSetting(type: .sub1)
        $0.isHidden = true
    }

    let pwCertificationTextField = UITextField().then{
        $0.placeholder = "비밀번호 재입력"
        $0.textFieldTypeSetting()
        $0.isSecureTextEntry = true
        $0.returnKeyType = .next
        $0.enablesReturnKeyAutomatically = true
    }

    let pwCertificationBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }

    let pwIncorrectLabel = UILabel().then{
        $0.text = "비밀번호가 일치하지 않습니다."
        $0.textColor = .noticeRed
        $0.labelTypeSetting(type: .sub1)
        $0.isHidden = true
    }

    //name
    let nameTitle = UILabel().then{
        $0.text = "이름"
        $0.textColor = .headline
        $0.labelTypeSetting(type: .subtitle)
    }

    let nameTextField = UITextField().then{
        $0.placeholder = "이름을 입력해주세요"
        $0.textFieldTypeSetting()
        $0.returnKeyType = .next
        $0.enablesReturnKeyAutomatically = true
    }

    let nameBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }
    
    let nameCanUseLabel = UILabel().then{
        $0.text = "*8자 이하의 한글 또는 영어로만 가능합니다."
        $0.textColor = .todoaryGrey
        $0.labelTypeSetting(type: .sub1)
    }

    //nickname
    let nicknameTitle = UILabel().then{
        $0.text = "닉네임"
        $0.textColor = .headline
        $0.labelTypeSetting(type: .subtitle)
    }

    let nicknameTextField = UITextField().then{
        $0.placeholder = "Todoary에서 사용하실 닉네임을 알려주세요"
        $0.textFieldTypeSetting()
        $0.returnKeyType = .done
        $0.enablesReturnKeyAutomatically = true
    }

    let nicknameBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }
    
    let nicknameCanUseLabel = UILabel().then{
        $0.text = "*10자 이하의 한글,영어,숫자로만 가능합니다."
        $0.textColor = .todoaryGrey
        $0.labelTypeSetting(type: .sub1)
    }

    let nextButton = UIButton().then{
        $0.isEnabled = false
        $0.setTitle("다음", for: .normal)
        $0.backgroundColor = .buttonColor
        $0.setTitleColor(.white, for: .normal)
        $0.buttonTypeSetting(type: .button1)
        $0.layer.cornerRadius = 52/2
        $0.addTarget(self, action: #selector(nextButtonDidClicked(_:)), for: .touchUpInside)
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .white
        
        navigationView = NavigationView(frame: .zero, self.navigationController!).then{
            $0.navigationTitle.text = "회원가입"
        }
        
        self.idTextField.delegate = self
        self.certificationTextField.delegate = self
        self.pwTextField.delegate = self
        self.pwCertificationTextField.delegate = self
        self.nameTextField.delegate = self
        self.nicknameTextField.delegate = self

        setUpView()
        setUpConstraint()
        textFieldAddRecognizer()
        settingTextFieldDelegate()
    }
    
    //MARK: - Helper

    func validateUserInput(){
        if isValidName
            && isValidPasswd
            && isValidNickname
            && isValidCertiCode
            && isValidPasswdCheck {
            nextButton.isEnabled = true
        }else{
            nextButton.isEnabled = false
        }
    }
    
    func textFieldAddRecognizer(){
        
        let tfChangedArray = [idTextField, certificationTextField, pwCertificationTextField]
        
        tfChangedArray.forEach{ each in
            each.addTarget(self, action: #selector(textFieldDidEditingChanged(_:)), for: .editingChanged)
        }
        
        let tfEditedEndArray = [pwTextField, nameTextField, nicknameTextField]
        
        tfEditedEndArray.forEach{ each in
            each.addTarget(self, action: #selector(textFieldDidEditingEnd(_:)), for: .editingDidEnd)
        }
        
        nicknameTextField.addTarget(self, action: #selector(initNicknameCanUseLabel), for: .editingDidBegin)
    }
    
    func settingTextFieldDelegate(){
        let textFields = [idTextField,certificationTextField,pwTextField,nameTextField,nicknameTextField]
        
        textFields.forEach{ each in
            each.delegate = self
        }
    }
    
    //MARK: - Action
    @objc
    func initNicknameCanUseLabel(){
        nicknameCanUseLabel.isHidden = false
        nicknameCanUseLabel.text = "*10자 이하의 한글,영어,숫자로만 가능합니다."
    }
    
    @objc
    func textFieldDidEditingChanged(_ sender: UITextField){
        
        let text = sender.text ?? ""
        
        switch sender {
        case idTextField:
            
            isValidEmail = text.isValidEmail()
            email = text
            return
            
        case certificationTextField:
            
            isValidCertiCode = (text == UserDefaults.standard.string(forKey: "key"))
            return
            
        case pwCertificationTextField:
            
            let bool = (sender.text == passwd)
            isValidPasswdCheck = bool
            
            if (bool){
                pwIncorrectLabel.isHidden = true
            }else{
                pwIncorrectLabel.isHidden = false
            }
            return
        default:
            fatalError("Missing Textfield")
        }
    }
    
    @objc
    func textFieldDidEditingEnd(_ sender : UITextField){
        
        let text = sender.text ?? ""
        
        switch sender{
        case pwTextField:
            isValidPasswd = text.isValidPassword()
            if(!isValidPasswd){
                pwCanUseLabel.isHidden = false
            }else{
                pwCanUseLabel.isHidden = true
            }
            passwd = text
            return
        case nameTextField:
            isValidName = text.isValidName()
            if(isValidName){
                nameCanUseLabel.isHidden = true
                name = text
            }else{
                nameCanUseLabel.isHidden = false
            }
            return
        case nicknameTextField:
            isValidNickname = text.isValidNickname()
            if(isValidNickname){
                nicknameCanUseLabel.isHidden = true
                nickname = text
            }else{
                nicknameCanUseLabel.isHidden = false
            }
            return
        default:
            fatalError("Missing Textfield")
        }
    }
    
    @objc
    func certificationBtnDidClicked(_ sender: UIButton){
        
        idCanUseLabel.isHidden = false

        if(isValidEmail){
            //이메일 중복 여부 확인
            SignUpDataManager().gets(self, email: self.email)
            print("API - email 중복 검사 요청")

        }else{
            idCanUseLabel.text = "*이메일 형식이 올바르지 않습니다."
            idCanUseLabel.textColor = .noticeRed
        }
            
    }
    
    @objc
    func certificationOKBtnDidClicked(_ sender: UIButton){
        
        let alertTitle : String!

        if isValidCertiCode{
            alertTitle = "인증이 완료되었습니다."
        }else{
            alertTitle = "인증코드가 일치하지 않습니다."
        }

        let alert = UIAlertController(title: alertTitle, message: nil, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "확인", style: .default, handler: nil)

        alert.addAction(alertAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc
    func nextButtonDidClicked(_ sender: UIButton){
        let userData = SignUpInput(email: self.email, name: self.name, nickname: self.nickname, password: self.passwd, isTermsEnable: self.isMarketingAgree)
        SignUpDataManager().posts(self, userData)
    }
}

//MARK: - Keyboard
extension SignUpViewController: UITextFieldDelegate{
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        UIView.animate(withDuration: 0.3){
            self.view.window?.frame.origin.y = 0
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{
        
        let size: CGFloat!
        
        switch textField{
        case nameTextField:
            size = 80
            break
        case nicknameTextField:
            size = 200
            break
        default:
            return true
        }
        
        UIView.animate(withDuration: 0.3){
            self.view.window?.frame.origin.y -= size
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == idTextField {
            certificationTextField.becomeFirstResponder()
            } else if textField == certificationTextField {
                pwTextField.becomeFirstResponder()
            }else if textField == pwTextField {
                pwCertificationTextField.becomeFirstResponder()
            }else if textField == pwCertificationTextField {
                nameTextField.becomeFirstResponder()
            }else if textField == nameTextField {
                nicknameTextField.becomeFirstResponder()
            }else if textField == nicknameTextField {
                nicknameTextField.resignFirstResponder()
                UIView.animate(withDuration: 0.3){
                    self.view.window?.frame.origin.y = 0
                }
            }
            return true
        }
}

//MARK: - API
extension SignUpViewController{
    
    func checkSignUpResultCode(_ code: Int){
        switch(code){
        case 1000:
            self.navigationController?.popToRootViewController(animated: true)
            return
        case 2017:
            nextButton.isEnabled = false
            idCanUseLabel.isHidden = false
            idCanUseLabel.text = "중복된 이메일입니다."
            return
        case 2032:
            nextButton.isEnabled = false
            nicknameCanUseLabel.isHidden = false
            nicknameCanUseLabel.text = "중복된 닉네임입니다."
            return
        default:
            print("데이터 베이스 오류")
            nextButton.isEnabled = false
            //팝업 띄우기
            let alert = DataBaseErrorAlert()
            self.present(alert, animated: true, completion: nil)
            return
        }
    }
    
    func checkEmailApiResultCode(_ code: Int){
        
        switch code {
        case 1000:
            
            idCanUseLabel.text = "*사용 가능한 이메일입니다."
            idCanUseLabel.textColor = .todoaryGrey
            
            MailSender.shared.sendEmail(self.email)
            
            //이메일 사용 가능한 경우, 메일 발송 팝업 띄우기
            let alert = UIAlertController(title: "인증코드가 메일로 발송되었습니다.", message: "", preferredStyle: .alert)
            
            let alertAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil)
            
            return
            
        case 2017:
            idCanUseLabel.isHidden = false
            idCanUseLabel.text = "*중복된 이메일 입니다."
            idCanUseLabel.textColor = .noticeRed
            isValidEmail = false
            
            return
        default:
            print("데이터베이스 오류")
            let alert = DataBaseErrorAlert()
            self.present(alert, animated: true, completion: nil)
            return
        }
        
    }
}
