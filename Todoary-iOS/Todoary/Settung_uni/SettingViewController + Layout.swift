//
//  SettingViewController + Layout.swift
//  Todoary
//
//  Created by 예리 on 2022/07/10.
//

import Foundation
import UIKit

extension  SettingViewController{
    
    func setUpView(){
        
        self.view.addSubview(navigationView)
        self.view.addSubview(tableView)
        
        
    }
    
    func setUpConstraint(){
        
        //navigation bar
        navigationView.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
        }
        
    }
}
