//
//  SettingAgreementView.swift
//  Todoary
//
//  Created by 예리 on 2022/07/10.
//

import Foundation
import UIKit

class  SettingAgreementView: UIView, BaseViewProtocol{
    
    let tableView = UITableView().then{
        $0.register(SettingAgreementViewCell.self, forCellReuseIdentifier: "SettingAgreementViewCell")
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
        
        //tableView
        tableView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(26)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-572)
        }
    }
}
