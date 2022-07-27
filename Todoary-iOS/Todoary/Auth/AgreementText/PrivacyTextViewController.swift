//
//  PrivacyTextViewController.swift
//  Todoary
//
//  Created by 예리 on 2022/07/04.
//

import Foundation
import UIKit
import SnapKit
import Then


class PrivacyTextViewController : UIViewController {
    
    //MARK: - UIComponenets
    
    let contentView = UIView().then{
        $0.backgroundColor = .white
        
    }
    
    var navigationView:NavigationView!
    
    //약관내용

    let contentScrollView = UIScrollView().then{
        $0.backgroundColor = .white
        $0.showsVerticalScrollIndicator = true
        $0.isScrollEnabled = true
        $0.indicatorStyle = .black
    }
    
    let privacyText = UILabel().then{
        $0.text = "개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의개인정보이용동의"
        $0.numberOfLines = 0
        $0.textAlignment = .left
        $0.textColor = .headline
       // $0.font = UIFont.nbFont(type: .body1)
        $0.labelTypeSetting(type: .acceptTerm)
    }
    

    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        navigationView = NavigationView(frame: .zero , self.navigationController!).then{
            $0.navigationTitle.text = "개인정보 이용동의"
        }

        setUpView()
        setUpConstraint()
    }
    
    @objc func backBtnDidTab() {
        self.navigationController?.popViewController(animated: true)
        }

}

