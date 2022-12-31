//
//  FontSettingView.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/11.
//

import Foundation

class FontSettingView: BaseView{
    
    let tableView = UITableView().then{
        $0.isScrollEnabled = false
        
        $0.register(FontSettingTableViewCell.self, forCellReuseIdentifier: "fontSettingCell")
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
