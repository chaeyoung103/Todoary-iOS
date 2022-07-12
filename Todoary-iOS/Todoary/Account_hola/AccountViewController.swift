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
        $0.text = "베어"
        $0.textColor = .black
        $0.addLetterSpacing(spacing: 0.36)
        $0.font = UIFont.nbFont(type: .header)
    }
    
    let introduce = UILabel().then{
        $0.text = "J가 되고 싶은 P"
        $0.textColor = .black
        $0.addLetterSpacing(spacing: 0.28)
        $0.font = UIFont.nbFont(type: .body1)
    }
    
    let profileChangeBtn = UIButton().then{
        $0.setTitle("프로필 변경", for: .normal)
        $0.backgroundColor = .white
        $0.setTitleColor(.silver_115, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(ofSize: 11, weight: .semibold)
        $0.contentVerticalAlignment = .center
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.silver_115.cgColor
        $0.layer.cornerRadius = 26/2
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
    
    @objc func cellDidTab() {
        
        let pwFindViewController = PwFindViewController()
        navigationController?.pushViewController(pwFindViewController, animated: true)
        navigationController?.isNavigationBarHidden = true
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
        
        let tapGesture = CellButtonTapGesture(target: self, action: #selector(cellDidTab))
        tapGesture.caller = indexPath.row
        
        switch indexPath.row{
        case 0:
            cell.title.text = "비밀번호 재설정"
            cell.main.addGestureRecognizer(tapGesture)
            cell.nextBtn.addTarget(self, action: #selector(cellDidTab), for: .touchUpInside)
            return cell
        case 1:
            cell.title.text = "로그아웃"
            cell.nextBtn.isHidden = true
            return cell
        case 2:
            cell.title.text = "계정 삭제하기"
            cell.title.textColor = .deleteRed
            cell.nextBtn.isHidden = true
            return cell
        default:
            fatalError("TableViewCell Error")
        }
    }
}
