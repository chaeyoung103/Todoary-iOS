//
//  UseServiceViewController.swift
//  Todoary
//
//  Created by 예리 on 2022/07/04.
//

import Foundation
import UIKit
import SnapKit
import Then


class UseServiceViewController : UIViewController {
    
    //MARK: - UIComponenets
    
    //navigationView
    //let UseServiceNavigationView = NavigationView().then {
       // $0.navigationTitle.text = "서비스 이용약관"
   // }
    
    //약관내용

    let contentScrollView = UIScrollView().then{
        $0.backgroundColor = .white
        $0.showsVerticalScrollIndicator = true
        $0.isScrollEnabled = true
        $0.indicatorStyle = .black
    }
    
    let UseServiceText = UILabel().then{
        $0.numberOfLines = 0
        $0.textAlignment = .left
        $0.textColor = .headline
        $0.font = UIFont.nbFont(type: .body1)
    }

    override func viewDidLoad() {
    
        super.viewDidLoad()

        setUpView()
        setUpConstraint()
    }

}
