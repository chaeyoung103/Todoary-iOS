//
//  LoginViewController.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/01.
//


import UIKit
import SnapKit
import Then

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var validateAutoLogin = false
    
    //MARK: - UIComponenets
    
    let logo = UIImageView().then{
        $0.image = UIImage(named: "login_logo")
        $0.contentMode = .scaleAspectFill
    }
    
    let comment = UIImageView().then{
        $0.image = UIImage(named: "login_comment")
        $0.contentMode = .scaleAspectFill
    }
    
    let picture = UIImageView().then{
        $0.image = UIImage(named: "loginPic")
        $0.contentMode = .scaleAspectFill
    }
    
    //id
    let idTitle = UILabel().then{
        $0.text = "아이디"
        $0.textColor = .headline
        $0.font = UIFont.nbFont(ofSize: 16, weight: .bold)
    }
    
    let idTf = UITextField().then{
        $0.placeholder = "가입하신 이메일을 입력해주세요"
        $0.textFieldTypeSetting(type: .body1)
        $0.font = UIFont.nbFont(type: .body2)
        $0.setPlaceholderColor()
        $0.returnKeyType = .next
        $0.enablesReturnKeyAutomatically = true
        $0.addTarget(self, action: #selector(tfDidChange), for: .editingChanged)
    }
    
    let idBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }


    //pw
    let pwTitle = UILabel().then{
        $0.text = "비밀번호"
        $0.textColor = .headline
        $0.font = UIFont.nbFont(ofSize: 16, weight: .bold)
    }

    let pwTf = UITextField().then{
        $0.placeholder = "비밀번호를 입력해주세요"
        $0.textFieldTypeSetting(type: .body1)
        $0.isSecureTextEntry = true
        $0.font = UIFont.nbFont(type: .body2)
        $0.setPlaceholderColor()
        $0.returnKeyType = .done
        $0.enablesReturnKeyAutomatically = true
        $0.addTarget(self, action: #selector(tfDidChange), for: .editingChanged)
    }

    let pwBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }

    let autoLoginTitle = UILabel().then{
        $0.textAlignment = .center
        $0.text = "자동로그인"
        $0.addLetterSpacing(spacing: 0.28)
        $0.textColor = .todoaryGrey
        $0.font = UIFont.nbFont(type: .body2)
    }
    
    let autoLoginBtn = UIButton().then{
        $0.setImage(UIImage(named: "check_box_outline_blank"), for: .normal)
        $0.setImage(UIImage(named: "check_box"), for: .selected)
        $0.addTarget(self, action: #selector(autoLoginBtnDidTab), for: .touchUpInside)
    }
  
    let loginBtn = UIButton().then{
        $0.setTitle("로그인", for: .normal)
        $0.backgroundColor = UIColor(red: 184/255, green: 184/255, blue: 184/255, alpha: 1)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.textAlignment = .center
        $0.titleLabel?.font = UIFont.nbFont(ofSize: 20, weight: .semibold)
        $0.layer.cornerRadius = 51/2
        $0.isEnabled = false
        $0.addTarget(self, action: #selector(loginBtnDidTab), for: .touchUpInside)
    }
    
    let appleBtn = UIButton().then{
        $0.setImage(UIImage(named: "appleid_button 1"), for: .normal)
        $0.contentMode = .scaleToFill
        $0.imageView?.contentMode = .scaleToFill
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.buttonColor.cgColor
        $0.layer.cornerRadius = 51/2
        $0.addTarget(self, action: #selector(appleBtnDidTab), for: .touchUpInside)
    }
    
    let signUpBtn = UIButton().then{
        $0.setTitle("회원가입", for: .normal)
        $0.backgroundColor = .white
        $0.setTitleColor(.todoaryGrey, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(ofSize: 20, weight: .semibold)
        $0.titleLabel?.textAlignment = .center
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.buttonColor.cgColor
        $0.layer.cornerRadius = 51/2
        $0.addTarget(self, action: #selector(signUpBtnDidTab), for: .touchUpInside)
    }
    
    let pwSearchBtn = UIButton().then{
        $0.setTitle("비밀번호를 잊으셨나요?", for: .normal)
        $0.backgroundColor = .white
        $0.setTitleColor(.todoaryGrey, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .subButton)
        $0.titleLabel?.textAlignment = .center
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.todoaryGrey.cgColor
        $0.layer.cornerRadius = 25/2
        $0.addTarget(self, action: #selector(pwSearchBtnDidTab), for: .touchUpInside)
    }

    //MARK: - Lifecycles
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.idTf.delegate = self
        self.pwTf.delegate = self

        setUpView()
        setUpConstraint()
        setupData()
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        UIView.animate(withDuration: 0.3){
            self.view.window?.frame.origin.y = 0
        }
    }

    //MARK: - Actions
    
    @objc func tfDidChange() {
        if idTf.text != "" && pwTf.text != ""{
            loginBtn.backgroundColor = .buttonColor
            loginBtn.isEnabled = true
        }else{
            loginBtn.backgroundColor = UIColor(red: 184/255, green: 184/255, blue: 184/255, alpha: 1)
            loginBtn.isEnabled = false
        }
    }
    
    @objc func signUpBtnDidTab() {
        let vc = AgreementViewController()
        navigationController?.pushViewController(vc, animated: true)
        navigationController?.isNavigationBarHidden = true
    }
    @objc func pwSearchBtnDidTab() {
        
        let pwFindViewController = PwFindViewController()
        navigationController?.pushViewController(pwFindViewController, animated: true)
        navigationController?.isNavigationBarHidden = true
                }
    
    @objc func autoLoginBtnDidTab() {
        if autoLoginBtn.isSelected {
            autoLoginBtn.isSelected = false
            validateAutoLogin = false
        }
        else {
            autoLoginBtn.isSelected = true
            validateAutoLogin = true
        }
    }
    
    @objc func loginBtnDidTab() {
        if validateAutoLogin == false {
            let loginInput = LoginInput(email: idTf.text, password: pwTf.text, fcm_token: UserDefaults.standard.string(forKey: "firebaseToken"))
            LoginDataManager().loginDataManager(self,loginInput)
        } else {
            // 자동로그인을 눌렀을 때
            let autoLoginInput = AutoLoginInput(email: idTf.text, password: pwTf.text, fcm_token: UserDefaults.standard.string(forKey: "firebaseToken"))
            AutoLoginDataManager() .autologin(self,autoLoginInput)
        }
      
    }
    
    @objc func appleBtnDidTab() {
    }
        
        
    
    //MARK: - Helpers
    
    private func setupData() {
        if (UserDefaults.standard.string(forKey: "refreshToken") != nil){
            let authJwt = AuthJwtInput(refreshToken: UserDefaults.standard.string(forKey: "refreshToken"), fcm_token: UserDefaults.standard.string(forKey: "firebaseToken"))
            AuthJwtDataManager().authJwtDataManager(self,authJwt)
        }else {
            print("자동로그인 아님")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == idTf {
                pwTf.becomeFirstResponder()
            } else {
                pwTf.resignFirstResponder()
                UIView.animate(withDuration: 0.3){
                    self.view.window?.frame.origin.y = 0
                }
            }
            return true
        }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        UIView.animate(withDuration: 0.3){
            self.view.window?.frame.origin.y = 0
        }
        UIView.animate(withDuration: 0.3){
            self.view.window?.frame.origin.y -= 50
        }
        return true
    }
    
}

