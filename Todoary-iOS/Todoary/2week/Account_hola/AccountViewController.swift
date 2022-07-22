//
//  AccountViewController.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/10.
//

import UIKit
import SnapKit
import Then

class AccountViewController : UIViewController {
    
    //MARK: - UIComponenets
    
    //navigation bar
    var navigationView : NavigationView!
    
    //tableView
    var tableView : UITableView!
    
    //profile
    
    let profileImage = UIImageView().then {
        $0.image = UIImage(named: "profile")
        $0.layer.cornerRadius = 85/2
        $0.clipsToBounds = true
    }
    
    let nickName = UILabel().then{
        $0.text = "일이삼사오육칠팔구십"
        $0.textColor = .black
        $0.addLetterSpacing(spacing: 0.36)
        $0.font = UIFont.nbFont(type: .header)
    }
    
    let introduce = UILabel().then{
        $0.text = "가가가가가가가가가가가가가가가가가가가가각가ㅏ가가가가가가가가ㅏ가"
        $0.textColor = .black
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
        $0.text = "asdf@naver.com"
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
        
        navigationView = NavigationView(frame: .zero , self.navigationController!).then{
            $0.navigationTitle.text = "계정"
        }
        
        tableView = UITableView().then{
            $0.separatorStyle = .none
            $0.register(AccountTableViewCell.self, forCellReuseIdentifier: "accountTableViewCell")
            $0.delegate = self
            $0.dataSource = self
        }

        self.view.backgroundColor = .white
        
        setUpView()
        setUpConstraint()
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
        let yes = UIAlertAction(title: "네", style: .cancel)
        alert.addAction(no)
        alert.addAction(yes)
        
        self.present(alert, animated: true, completion: nil)
                }
    
    @objc func accountDeleteCellDidTab() {
        let alert = UIAlertController(title: "정말 계정을 삭제하시겠습니까?", message: "삭제된 데이터는 복구할 수 없습니다.", preferredStyle: .alert)
        let no = UIAlertAction(title: "아니오", style: .cancel)
        let yes = UIAlertAction(title: "네", style: .default){ _ in
            UserDeleteDataManager().patch(self)
        }
        alert.addAction(no)
        alert.addAction(yes)
        
        self.present(alert, animated: true, completion: nil)
                
    }
    
    //MARK: - Helpers
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
