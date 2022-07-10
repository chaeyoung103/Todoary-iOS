//
//  DefaultTableViewCell.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/10.
//

import UIKit

class DefaultTableViewCell: UITableViewCell {
    
    let backView = UIView()
    
    let cellTitle = UILabel().then{
        $0.labelTypeSetting(type: .tableCell)
    }
    
    let arrowImage = UIImageView().then{
        $0.image = UIImage(named: "next_btn")
    }
    
    let separatorLine = UIView().then{
        $0.backgroundColor = .silver_225
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView(){
        
        self.contentView.addSubview(backView)
        
        backView.addSubview(cellTitle)
    }
    
    func setUpConstraint(){
        
    }
    
}
