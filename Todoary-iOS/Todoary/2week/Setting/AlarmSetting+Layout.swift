//
//  AlarmSettingViewController+Layout.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/10.
//

import UIKit

extension AlarmSettingViewController {

    func setUpView(){
        self.view.addSubview(navigationView)
        self.view.addSubview(tableView)
    }
    
    func setUpConstraint(){
        
        navigationView.snp.makeConstraints{ make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        tableView.snp.makeConstraints{ make in
            make.top.equalTo(navigationView.snp.bottom).offset(38)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
