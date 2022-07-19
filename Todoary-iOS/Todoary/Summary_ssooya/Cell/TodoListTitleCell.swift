//
//  TodoListTitleCell.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/18.
//

import UIKit

class TodoListTitleCell: UITableViewCell {
    
    static let cellIdentifier = "todolistTitleCell"
    
    let backView = UIView().then{
        $0.backgroundColor = .transparent
    }
    
    let selectedBackView = UIView().then{
        $0.backgroundColor = .transparent
    }

    let todoListTitle = PaddingLabel().then{
        $0.text = "TODO LIST"
        $0.font = UIFont.nbFont(ofSize: 12, weight: .extraBold)
        $0.textColor = .summaryTitle
        $0.addLetterSpacing(spacing: 0.24)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 24/2
        $0.clipsToBounds = true
    }
    
    let addPlanButton = UIButton().then{
        $0.setImage(UIImage(named: "todo_plus"), for: .normal)
        $0.addTarget(self, action: #selector(addPlanButtonDidClicked(_:)), for: .touchUpInside)
    }
    
    let moveCategoryButton = UIButton().then{
        $0.setImage(UIImage(named: "category"), for: .normal)
        $0.addTarget(self, action: #selector(moveCategoryButtonDidClicked(_:)), for: .touchUpInside)
    }
    
    let buttonStackView = UIStackView().then{
        $0.axis = .horizontal
        $0.spacing = 0
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .transparent
        self.selectedBackgroundView = selectedBackView
        
        setUpView()
        setUpConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func addPlanButtonDidClicked(_ sender: UIButton){
        print("add plan button did cliked")
    }
    
    @objc
    func moveCategoryButtonDidClicked(_ sender: UIButton){
        print("move category button did cliked")
    }
    
    func setUpView(){
        
        self.contentView.addSubview(backView)
        
        buttonStackView.addArrangedSubview(addPlanButton)
        buttonStackView.addArrangedSubview(moveCategoryButton)
        
        backView.addSubview(todoListTitle)
        backView.addSubview(buttonStackView)
        
    }
    
    func setUpConstraint(){
        
        self.contentView.snp.makeConstraints{ make in
            make.height.equalTo(59)
            make.width.equalToSuperview()
        }
        
        backView.snp.makeConstraints{ make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        todoListTitle.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(32)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        buttonStackView.snp.makeConstraints{ make in
            make.trailing.equalToSuperview().offset(-23)
        }
        
        addPlanButton.snp.makeConstraints{ make in
            make.width.equalTo(43)
            make.height.equalTo(59)
        }
        
        moveCategoryButton.snp.makeConstraints{ make in
            make.width.equalTo(43)
            make.height.equalTo(59)
        }
    }
}
