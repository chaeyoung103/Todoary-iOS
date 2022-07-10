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
        
        self.view.addSubview(versionBorderLine1)
        self.view.addSubview(versionText)
        self.view.addSubview(versionNum)
        self.view.addSubview(versionBorderLine2)
    }
    
    func setUpConstraint(){
        
        //navigation bar
        navigationView.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        //tableView
        tableView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(135)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(322)
        }
        
    }
}
