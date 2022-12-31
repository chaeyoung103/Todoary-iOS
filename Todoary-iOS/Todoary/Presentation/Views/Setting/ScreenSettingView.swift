//
//  ScreenSettingView.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/11.
//

import UIKit

class ScreenSettingView: BaseView {
    
    let tableView = UITableView().then{
        $0.isScrollEnabled = false
        
        $0.register(DefaultTableViewCell.self, forCellReuseIdentifier: "screenSettingCell")
    }
    
    override func hierarchy(){
        self.addSubview(tableView)
    }
    
    override func layout(){
        tableView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(26)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
