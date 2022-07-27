//
//  SettingAgreementViewController + Layout.swift
//  Todoary
//
//  Created by 예리 on 2022/07/10.
//

import Foundation
import UIKit

extension  SettingAgreementViewController{
    
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
        
        //tableView
        tableView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(122)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-572)
        }
    }
}
