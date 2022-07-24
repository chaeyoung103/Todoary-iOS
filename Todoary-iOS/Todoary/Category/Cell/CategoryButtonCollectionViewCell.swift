//
//  CategoryButton.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/23.
//

import UIKit

class CategoryButtonCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "categoryButtonCell"
    
    lazy var categoryBtn = UIButton().then{
        $0.setTitle("운동", for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(ofSize: 14, weight: .bold)
        $0.addLetterSpacing(spacing: 0.28)
        $0.layer.borderWidth = 1
        $0.setTitleColor(UIColor.category1, for: .normal)
        $0.setTitleColor(UIColor.white, for: .selected)
        $0.addTarget(self, action: #selector(categoryButtonDidClicked(_:)), for: .touchUpInside)
        $0.titleEdgeInsets = UIEdgeInsets(top: 5, left: 16, bottom: 4, right: 16)
        $0.layer.cornerRadius = 26/2
    }
   
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.contentView.addSubview(categoryBtn)
        
        self.snp.makeConstraints{ make in
            make.height.equalTo(26)
            make.width.equalTo(categoryBtn.titleLabel!.snp.width).offset(32)
        }
        
        self.contentView.snp.makeConstraints{ make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        categoryBtn.snp.makeConstraints{ make in
            make.leading.trailing.top.bottom.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setBtnColor(){
        
    }
    
    @objc
    func categoryButtonDidClicked(_ sender: UIButton){
        
    }
}
