//
//  CategoryTableViewCell.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/23.
//

import UIKit

class CategoryTodoTableViewCell: UITableViewCell {

    static let cellIdentifier = "todoCell"
    
    lazy var checkBox = UIButton().then{
        $0.setImage(UIImage(named: "todo_check_empty"), for: .normal)
        $0.setImage(UIImage(named: "todo_check"), for: .selected)
        $0.addTarget(self, action: #selector(checkBoxDidClicked(_:)), for: .touchUpInside)
    }
    
    let todoTitle = UILabel().then{
        $0.text  = "운동"
        $0.numberOfLines = 0
        $0.font = UIFont.nbFont(ofSize: 15, weight: .bold)
        $0.addLetterSpacing(spacing: 0.3)
        $0.setTextWithLineHeight(lineHeight: 22)
        $0.textColor = .black
        
    }
    
    let dateLabel = UILabel().then{
        $0.text = "7월 21일"
        $0.font = UIFont.nbFont(ofSize: 13, weight: .medium)
        $0.textColor = .timeColor
    }
    
    let timeLabel = UILabel().then{
        $0.text = "AM 7:00"
        $0.textColor = .timeColor
        $0.font = UIFont.nbFont(ofSize: 13, weight: .medium)
    }
    
    let alarmImage = UIImageView().then{
        $0.image = UIImage(named: "notifications")
        $0.isHidden = true
    }
    
    let categoryStack = UIStackView().then{
        $0.axis = .horizontal
        $0.spacing = 8
    }
    
    let backView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpView()
        setUpConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView(){
        
        self.contentView.addSubview(backView)
        
        backView.addSubview(categoryStack)
        backView.addSubview(checkBox)
        backView.addSubview(todoTitle)
        backView.addSubview(timeLabel)
        backView.addSubview(dateLabel)
        backView.addSubview(alarmImage)
        
    }
    
    func setUpConstraint(){
        
        self.contentView.snp.makeConstraints{ make in
            make.height.equalTo(todoTitle.snp.height).offset(68+20)
            make.bottom.equalToSuperview().offset(-20)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-30)
            make.top.equalToSuperview()
        }
        
        backView.snp.makeConstraints{ make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        categoryStack.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(19)
//            make.trailing.equalToSuperview().offset(-35)
            make.top.equalToSuperview().offset(11)
            make.height.equalTo(21)
        }
        
        checkBox.snp.makeConstraints{ make in
            make.width.height.equalTo(22)
            make.top.equalTo(categoryStack.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(19)
        }
        
        todoTitle.snp.makeConstraints{ make in
            make.width.equalTo(177)
            make.top.equalTo(categoryStack.snp.bottom).offset(14)
            make.bottom.equalToSuperview().offset(-19)
            make.leading.equalTo(checkBox.snp.trailing).offset(9)
        }
        
        dateLabel.snp.makeConstraints{ make in
            make.trailing.equalToSuperview().offset(-18)
            make.leading.equalTo(todoTitle.snp.trailing).offset(12)
        }
        
        timeLabel.snp.makeConstraints{ make in
            make.width.equalTo(71)
            make.height.equalTo(14.14)
            make.trailing.equalToSuperview().offset(-1)
        }
        
        alarmImage.snp.makeConstraints{ make in
            make.width.equalTo(14)
            make.height.equalTo(13.2)
            make.leading.equalTo(timeLabel).offset(6)
            make.lastBaseline.equalTo(timeLabel)
        }
        
        
        
    }
    
    @objc
    func checkBoxDidClicked(_ sender: UIButton){
        sender.isSelected.toggle()
    }
    
    
}
