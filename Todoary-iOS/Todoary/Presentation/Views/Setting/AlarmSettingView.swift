//
//  AlarmSettingView.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/10.
//

import UIKit

class AlarmSettingView: UIView, BaseViewProtocol {
    
    let tableView = UITableView().then{
        $0.register(AlarmSettingTableViewCell.self, forCellReuseIdentifier: "alarmSettingCell")
        $0.isScrollEnabled = false
        $0.allowsSelection = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        hierarchy()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func hierarchy() {
        self.addSubview(tableView)
    }
    
    func layout() {
        tableView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(26)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
