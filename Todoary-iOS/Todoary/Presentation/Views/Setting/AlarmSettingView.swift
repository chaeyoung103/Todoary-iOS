//
//  AlarmSettingView.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/10.
//

import UIKit

class AlarmSettingView: BaseView{
    
    let tableView = UITableView().then{
        $0.register(AlarmSettingTableViewCell.self, forCellReuseIdentifier: "alarmSettingCell")
        $0.isScrollEnabled = false
        $0.allowsSelection = false
    }
    
    override func hierarchy() {
        self.addSubview(tableView)
    }
    
    override func layout() {
        tableView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(26)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
