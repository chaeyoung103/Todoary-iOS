//
//  HomeViewController.swift
//  Todoary
//
//  Created by 예리 on 2022/07/10.
//

import Foundation
import UIKit
import SnapKit
import Then

class HomeViewController : UIViewController {
    
    //MARK: - UIComponenets

    //settingBtn
    
    let settingBtn = UIButton().then{
        $0.setImage(UIImage(named: "homemenu"), for: .normal)
        $0.addTarget(self, action: #selector(settingBtnDidTab), for: .touchUpInside)
    }


//MARK: - viewDidLoad

    override func viewDidLoad() {
    
        super.viewDidLoad()
    
        self.view.backgroundColor = .white
        
        setUpView()
        setUpConstraint()
    }

    
    //MARK: - settingBtnDidTab
    
    @objc
    func settingBtnDidTab(_ sender: UIButton){
        self.navigationController?.pushViewController(SettingViewController(), animated: true)
    }

}
