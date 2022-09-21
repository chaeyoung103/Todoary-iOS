//
//  LoginViewController.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/01.
//


import UIKit
import SnapKit
import Then
import AuthenticationServices

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
        
        
        //로그인VC 접근시 기존 스택VC들 제거
        let endIndex = (self.navigationController?.viewControllers.endIndex)!
        
        self.navigationController?.viewControllers.removeSubrange(0..<endIndex - 1)
        
//        UserDefaults.standard.removeObject(forKey: "accessToken")
//        UserDefaults.standard.removeObject(forKey: "refreshToken")
//        KeyChain.delete(key: Const.UserDefaults.appleIdentifier)
//        KeyChain.delete(key: Const.UserDefaults.appleRefreshToken)
        
    
        
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
            let loginInput = LoginInput(email: idTf.text, password: pwTf.text)
            LoginDataManager().loginDataManager(self,loginInput)
        } else {
            // 자동로그인을 눌렀을 때
            let autoLoginInput = AutoLoginInput(email: idTf.text, password: pwTf.text)
            AutoLoginDataManager() .autologin(self,autoLoginInput)
        }
        
        UIView.animate(withDuration: 0.3){
            self.view.window?.frame.origin.y = 0
        }
      
    }
    
    @objc func appleBtnDidTab() {

            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
        
    }
        
        
    
    //MARK: - Helpers
    
    
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

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding, ASAuthorizationControllerDelegate{
    
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    /*
     email, userName 정보 -> 키체인에 바로 저장
     userIdentifier 정보 -> 프로퍼티에 임시 저장
     이후 회원가입 완료시 userIndentifier 정보도 키체인에 저장
     
     => userIdentifier가 키체인에 있을 경우 유저 정보가 있다는 걸로..
     */
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            let authorizationCode = String(data: appleIDCredential.authorizationCode!, encoding: .utf8)
            let identityToken = String(data: appleIDCredential.identityToken!, encoding: .ascii)!
            let userIdentifier = appleIDCredential.user
            
            let email: String!
            let userName: String!
            
            if let emailData = appleIDCredential.email, let name =  appleIDCredential.fullName{
                //email 값 nil 아닌 경우 -> 키체인에 값 저장하기
                email = emailData
                userName = "\(name.familyName!)\(name.givenName!)"
                
                KeyChain.create(key: Const.UserDefaults.email, value: email)
                KeyChain.create(key: Const.UserDefaults.userName, value: userName)
            }else{
                //email 값 nil인 경우 -> 키체인에서 값 가져오기
                email = KeyChain.read(key: Const.UserDefaults.email)
                userName = KeyChain.read(key: Const.UserDefaults.userName)
            }
            
            let userInput = AppleLoginInput(code: authorizationCode!, idToken: identityToken, name: userName, email: email, userIdentifier: userIdentifier)
            
            if KeyChain.read(key: Const.UserDefaults.appleRefreshToken) != nil {
                //userIdentifier값 nil이 아닌 경우 -> 로그인 진행
                KeyChain.delete(key: Const.UserDefaults.appleIdentifier)
                KeyChain.delete(key: Const.UserDefaults.appleRefreshToken)
                
                AppleLoginDataManager().post(self, parameter: userInput)
            }else{
                //userIdentifier값 nil인 경우 -> 회원가입 필요
                let vc = AgreementViewController()
                
                vc.appleUserInfo = userInput
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        default:
            break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
    
}

import Foundation
import Security

class Const{
    class UserDefaults{
        static let appleRefreshToken = "APPLE_REFRESH_TOKEN"
        static let appleIdentifier = "APPLE_IDENTIFIER"
        static let email = "APPLE_EMAIL"
        static let userName = "APPLE_USERNAME"
    }
}

class KeyChain {
    // Create
    class func create(key: String, value: String) {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,   // 저장할 Account
            kSecValueData: value.data(using: .utf8, allowLossyConversion: false) as Any   // 저장할 Token
        ]
        SecItemDelete(query)    // Keychain은 Key값에 중복이 생기면, 저장할 수 없기 때문에 먼저 Delete해줌

        let status = SecItemAdd(query, nil)
        assert(status == noErr, "failed to save Token")
    }
    
    // Read
    class func read(key: String) -> String? {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecReturnData: kCFBooleanTrue as Any,  // CFData 타입으로 불러오라는 의미
            kSecMatchLimit: kSecMatchLimitOne       // 중복되는 경우, 하나의 값만 불러오라는 의미
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query, &dataTypeRef)
        
        if status == errSecSuccess {
            if let retrievedData: Data = dataTypeRef as? Data {
                let value = String(data: retrievedData, encoding: String.Encoding.utf8)
                return value
            } else { return nil }
        } else {
            print("failed to loading, status code = \(status)")
            return nil
        }
    }
    
    // Delete
    class func delete(key: String) {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key
        ]
        let status = SecItemDelete(query)
        assert(status == noErr, "failed to delete the value, status code = \(status)")
    }
}

