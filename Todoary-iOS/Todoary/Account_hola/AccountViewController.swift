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
        $0.labelTypeSetting(type: .body1)
        $0.font = UIFont.nbFont(type: .header)
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
