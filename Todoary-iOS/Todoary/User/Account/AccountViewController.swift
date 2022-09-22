//
//  AccountViewController.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/10.
//

import UIKit
import SnapKit
import Then
import AuthenticationServices

class AccountViewController : BaseViewController {
    
    //MARK: - UIComponenets
    
    //tableView
    var tableView : UITableView!
    
    //profile
    
    let profileImage = UIImageView().then {
        $0.image = UIImage(named: "profile")
        $0.contentMode = .scaleAspectFill
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 1).cgColor
        $0.layer.cornerRadius = 85/2
        $0.clipsToBounds = true
    }
    
    let nickName = UILabel().then{
        $0.text = ""
        $0.textColor = .black
        $0.addLetterSpacing(spacing: 0.36)
        $0.font = UIFont.nbFont(type: .header)
    }
    
    let introduce = UILabel().then{
        $0.text = ""
        $0.textColor = .black
        $0.numberOfLines = 2
        $0.addLetterSpacing(spacing: 0.28)
        $0.font = UIFont.nbFont(type: .body1)
    }
    
    let profileChangeBtn = UIButton().then{
        $0.titleEdgeInsets = UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)
        $0.setTitle("프로필 변경", for: .normal)
        $0.backgroundColor = .white
        $0.setTitleColor(.silver_115, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(ofSize: 13, weight: .semibold)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.silver_115.cgColor
        $0.layer.cornerRadius = 31/2
        $0.addTarget(self, action: #selector(profileChangeBtnDidTab), for: .touchUpInside)
    }
    
    let accountTitle = UILabel().then{
        $0.text = "계정"
        $0.textColor = .black
        $0.addLetterSpacing(spacing: 0.28)
        $0.font = UIFont.nbFont(type: .body2)
    }
    
    //account
    let userAccount = UILabel().then{
        $0.text = ""
        $0.textColor = .black
        $0.addLetterSpacing(spacing: 0.32)
        $0.font = UIFont.nbFont(type: .tableCell)
    }
    
    let accountBorderLine = UIView().then{
        $0.backgroundColor = .silver_225
    }
    
    
    //MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationTitle.text = "계정"
        
        tableView = UITableView().then{
            $0.isScrollEnabled = false
            $0.separatorStyle = .none
            $0.register(AccountTableViewCell.self, forCellReuseIdentifier: "accountTableViewCell")
            $0.delegate = self
            $0.dataSource = self
        }

        self.view.backgroundColor = .white
        
        setUpView()
        setUpConstraint()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        GetProfileDataManager().getProfileDataManger(self)
    }
    
    //MARK: - Actions
    
    @objc func profileChangeBtnDidTab() {
        
        let profileViewController = ProfileViewController()
        navigationController?.pushViewController(profileViewController, animated: true)
        navigationController?.isNavigationBarHidden = true
                }
    
    @objc func pwFindCellDidTab() {
        let pwFindViewController = PwFindViewController()
        navigationController?.pushViewController(pwFindViewController, animated: true)
        navigationController?.isNavigationBarHidden = true
                }
    
    @objc func logoutCellDidTab() {
        let alert = UIAlertController(title: "로그아웃 하시겠습니까?", message: nil, preferredStyle: .alert)
        let no = UIAlertAction(title: "아니오", style: .default)
        let yes = UIAlertAction(title: "네", style: .cancel){(_) in
            SignoutDataManager().signout(self)
        }
            
        alert.addAction(yes)
        alert.addAction(no)
        
        
        self.present(alert, animated: true, completion: nil)
    }


    
    @objc func accountDeleteCellDidTab() {
        
        let alert = CancelMessageAlertViewController(title: "정말 계정을 삭제하시겠습니까?", message: "삭제된 데이터는 복구할 수 없습니다.")
        alert.alertHandler = {
            
            if KeyChain.read(key: Const.UserDefaults.appleIdentifier) != nil{
                let appleIDProvider = ASAuthorizationAppleIDProvider()
                let request = appleIDProvider.createRequest()
                request.requestedScopes = [.fullName, .email]
                
                let authorizationController = ASAuthorizationController(authorizationRequests: [request])
                authorizationController.delegate = self
                authorizationController.presentationContextProvider = self
                authorizationController.performRequests()
            }else{
                UserDeleteDataManager().patch(self)
            }
        }
        alert.modalPresentationStyle = .overFullScreen
        self.present(alert, animated: false, completion: nil)

    }
    
    //MARK: - Helpers
    
    func successAPI_account(_ result : GetProfileResult) {
        nickName.text = result.nickname
        introduce.text = result.introduce
        userAccount.text = result.email
        let url = URL(string: result.profileImgUrl!)
        profileImage.load(url: url!)
    }
    
    func deleteApiResultCode(_ result: Int){
        switch result{
        case 1000:
            self.navigationController?.pushViewController(LoginViewController(), animated: true)
            return
        case 2010, 4000:
            let alert = DataBaseErrorAlert()
            self.present(alert, animated: true, completion: nil)
            return
        default:
            fatalError()
        }
    }
}

extension AccountViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "accountTableViewCell", for: indexPath) as? AccountTableViewCell else{
            return UITableViewCell()
        }
        
        let tapPwFind = CellButtonTapGesture(target: self, action: #selector(pwFindCellDidTab))
        tapPwFind.caller = indexPath.row
        
        let tapLogout = CellButtonTapGesture(target: self, action: #selector(logoutCellDidTab))
        tapLogout.caller = indexPath.row
        
        let tapAccountDelete = CellButtonTapGesture(target: self, action: #selector(accountDeleteCellDidTab))
        tapAccountDelete.caller = indexPath.row
        
        switch indexPath.row{
        case 0:
            cell.title.text = "비밀번호 재설정"
            cell.main.addGestureRecognizer(tapPwFind)
            cell.nextBtn.addTarget(self, action: #selector(pwFindCellDidTab), for: .touchUpInside)
            return cell
        case 1:
            cell.title.text = "로그아웃"
            cell.main.addGestureRecognizer(tapLogout)
            cell.nextBtn.isHidden = true
            return cell
        case 2:
            cell.title.text = "계정 삭제하기"
            cell.title.textColor = .deleteRed
            cell.main.addGestureRecognizer(tapAccountDelete)
            cell.nextBtn.isHidden = true
            return cell
        default:
            fatalError("TableViewCell Error")
        }
    }
}

extension AccountViewController: ASAuthorizationControllerPresentationContextProviding, ASAuthorizationControllerDelegate{
    
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
            
            let authorizationCode = String(data: appleIDCredential.authorizationCode!, encoding: .utf8)!
            
            UserDeleteDataManager().postAppleUserDelete(self, authorizationCode: authorizationCode)
            
        default:
            break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
    
}
