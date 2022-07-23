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
    
    var emailCheck = false
    
    //유효성검사를 위한 프로퍼티
    var isValidPw = false {
        //didSet -> 세팅이 끝난 후에 코드블럭을 실행하겠다는 의미
        didSet {//프로퍼티 옵저버
            self.validatePw()
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
        $0.addTarget(self, action: #selector(idCertificationBtnDidTab), for: .touchUpInside)
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
        $0.setTitle("확인", for: .normal)
        $0.backgroundColor = .buttonColor
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .button1)
        $0.layer.cornerRadius = 52/2
        $0.addTarget(self, action: #selector(passWordChangeButtonDidClicked), for: .touchUpInside)
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
        case pwTf:
            pwNoticeLb.isHidden = false
            self.isValidPw = text.isValidPw()
            self.password = text
        case pwCertificationTf:
            pwCertificationNoticeLb.isHidden = false
            if text == self.password {
                isValidPw = true
                pwCertificationNoticeLb.isHidden = true
            }else{
                isValidPw = false
            }
        default:
            fatalError("Missing TextField...")
        }
    }
    
    @objc func idCertificationBtnDidTab() {

        EmailCheckDataManager().emailCheckDataManager(self, email: idTf.text!)
        

    }
    
    @objc func passWordChangeButtonDidClicked(){
        
        let pwInput = PwFindInput(newPassword: self.password)
        
        PwFindDataManager().pwFindDataManager(self, pwInput)
    }
    
    //MARK: - Helpers
    
    func checkEmail(_ code: Int){
        
        if(code == 1000) { //사용가능 이메일 점검 조건문 추가
            
            idNoticeLb.text = "*존재하는 이메일입니다."
            idNoticeLb.textColor = .todoaryGrey
            
            MailSender.shared.sendEmail()
            
            //이메일 사용 가능한 경우, 메일 발송 팝업 띄우기
            let alert = UIAlertController(title: "인증코드가 메일로 발송되었습니다.", message: nil, preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            
        }else if(code == 2017){
            idNoticeLb.text = "*유효하지 않은 이메일입니다. 다시 입력해 주세요."
            idNoticeLb.textColor = .noticeRed
        }
    }
    
    private func validatePw(){
        if isValidPw{
            pwNoticeLb.isHidden = true
            }
        else { //유효성 검사 -> 유효하지 않음
            pwNoticeLb.isHidden = false
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
