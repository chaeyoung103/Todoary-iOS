//
//  HomeViewController + Layout.swift
//  Todoary
//
//  Created by 예리 on 2022/07/10.
//

import Foundation
import SnapKit


extension HomeViewController {
    
    func setUpView(){
        
        self.view.addSubview(settingBtn)
       
    }
    
    
    func setUpConstraint(){
        
        (settingBtn).snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(60)
            make.trailing.equalToSuperview().offset(-9)
            make.width.equalTo(33)
            make.height.equalTo(33)
        }
    }
}

        
