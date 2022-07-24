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
    
    lazy var todoTitle = UILabel().then{
        $0.text  = "운동"
        $0.numberOfLines = 0
        $0.font = UIFont.nbFont(ofSize: 15, weight: .bold)
        $0.addLetterSpacing(spacing: 0.3)
        $0.setTextWithLineHeight(lineHeight: 22)
        $0.textColor = .black
        
    }
    
    let dateLabel = UILabel().then{
        $0.text = "7월 21일"
        $0.textAlignment = .right
        $0.font = UIFont.nbFont(ofSize: 13, weight: .medium)
        $0.textColor = .timeColor
    }
    
    let timeLabel = UILabel().then{
        $0.text = "AM 7:00"
        $0.textAlignment = .right
        $0.textColor = .timeColor
        $0.font = UIFont.nbFont(ofSize: 13, weight: .medium)
    }
    
    let alarmImage = UIImageView().then{
        $0.image = UIImage(named: "notifications")
//        $0.isHidden = true
    }
    
    let categoryStack = UIStackView().then{
        $0.axis = .horizontal
        $0.spacing = 8
    }
    
    let timeView = UIView()
    
    let timeStack = UIStackView().then{
        $0.axis = .vertical
        $0.spacing = 7.86
    }
    
    let backView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
        $0.layer.shadowRadius = 7.0
        $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowOpacity = 1
        $0.layer.masksToBounds = false
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpView()
        setUpCategory()
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
        backView.addSubview(timeStack)
        
        timeView.addSubview(timeLabel)
        timeView.addSubview(alarmImage)
        
        timeStack.addArrangedSubview(dateLabel)
        timeStack.addArrangedSubview(timeView)
        
    }
    
    func setUpCategory(){
        
        let category = ["운동","취미","대외활동"]
        
        let category2 = ["가나다라마바","가나다라마바","가나다라마바"]
        
        category2.forEach{ each in
            lazy var button = CategoryLabel()
            button.setTitle(each, for: .normal)
            categoryStack.addArrangedSubview(button)
        }
    }
    
    func setUpConstraint(){
        
        self.contentView.snp.makeConstraints{ make in
            make.height.equalTo(todoTitle.snp.height).offset(68+20)
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-30)
        }
        
        backView.snp.makeConstraints{ make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
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
        
        timeStack.snp.makeConstraints{ make in
            make.trailing.equalToSuperview().offset(-18)
            make.leading.equalTo(todoTitle.snp.trailing).offset(12)
        }
        
        dateLabel.snp.makeConstraints{ make in
            make.width.equalTo(71)
            make.height.equalTo(14.14)
        }
        
        timeView.snp.makeConstraints{ make in
            make.width.equalTo(71)
            make.height.equalTo(14.14)
        }
        
        timeLabel.snp.makeConstraints{ make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        alarmImage.snp.makeConstraints{ make in
            make.width.equalTo(14)
            make.height.equalTo(13.2)
            make.leading.equalToSuperview().offset(6)
            make.lastBaseline.equalTo(timeLabel)
            make.top.equalToSuperview()
        }
        
    }

    @objc
    func checkBoxDidClicked(_ sender: UIButton){
        sender.isSelected.toggle()
    }
    
    
}

class CategoryLabel: UIButton{
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setUpValue()
        setUpConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpValue(){
        self.setTitle("운동", for: .normal)
        self.titleEdgeInsets = UIEdgeInsets(top: 4, left: 11, bottom: 3, right: 11)
        self.layer.borderWidth = 1
        self.setTitleColor(.category1, for: .normal)
        self.titleLabel?.font = UIFont.nbFont(ofSize: 12, weight: .bold)
    }
    
    func setUpConstraint(){
        self.snp.makeConstraints{ make in
            make.width.equalTo(self.titleLabel!).offset(22)
            make.height.equalTo(21)
        }
    }
}
