//
//  TodoCategoryCell.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/31.
//

import UIKit

class TodoCategoryCell: UICollectionViewCell {
    
    static let cellIdentifier = "todoCategoryCell"
    
//    var delegate: CategoryButtonSelect?
    
    var viewController: TodoSettingViewController!
    
    lazy var categoryBtn = UIButton().then{
        $0.setTitleColor(.white, for: .selected)
        $0.titleLabel?.font = UIFont.nbFont(ofSize: 14, weight: .bold)
        $0.addLetterSpacing(spacing: 0.28)
        $0.titleLabel?.textAlignment = .center
        $0.layer.borderWidth = 1
        $0.addTarget(self, action: #selector(categoryButtonDidClicked(_:)), for: .touchUpInside)
        $0.titleEdgeInsets = UIEdgeInsets(top: 5, left: 16, bottom: 4, right:16)
        $0.layer.cornerRadius = 26/2
    }
    
    var categoryColor : UIColor!
   
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.contentView.addSubview(categoryBtn)
        
        self.snp.makeConstraints{ make in
            make.width.height.equalTo(categoryBtn)
        }
        self.contentView.snp.makeConstraints{ make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        categoryBtn.snp.makeConstraints{ make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setBtnAttribute(title:String,color: UIColor){
        
        categoryColor = color
        
        categoryBtn.setTitle(title, for: .normal)
        categoryBtn.setTitleColor(categoryColor, for: .normal)
        
        buttonIsNotSelected()
        
    }
    
    @objc
    func categoryButtonDidClicked(_ sender: UIButton){
        if(!categoryBtn.isSelected){
            buttonIsSelected()
        }else{
            buttonIsNotSelected()
        }
    }
    
    func buttonIsSelected(){
        categoryBtn.backgroundColor = categoryColor
        categoryBtn.isSelected.toggle()
    }
    
    func buttonIsNotSelected(){
        categoryBtn.layer.borderColor = categoryColor.cgColor
        categoryBtn.backgroundColor = .white
    }
}
