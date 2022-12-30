//
//  FontSettingView.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/11.
//

import Foundation

class FontSettingView: UIView, BaseViewProtocol{
    
    let tableView = UITableView().then{
        $0.isScrollEnabled = false
        
        $0.register(FontSettingTableViewCell.self, forCellReuseIdentifier: "fontSettingCell")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        hierarchy()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func hierarchy(){
        self.addSubview(tableView)
    }
    
    func layout(){
        tableView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(26)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
