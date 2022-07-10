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
    
    let contentView = UIView().then{
        $0.backgroundColor = .white
    }
    
    //navigation bar
    var navigationView : NavigationView!
    
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
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.silver_115.cgColor
        $0.layer.cornerRadius = 25/2
    }
    
    
    //MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationView = NavigationView(frame: .zero , self.navigationController!).then{
            $0.navigationTitle.text = "계정"
        }

        setUpView()
        setUpConstraint()
    }
    
    
}
