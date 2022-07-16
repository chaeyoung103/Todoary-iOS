//
//  TodoListTableViewCell.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/16.
//

import UIKit
import SnapKit

class TodoListTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "todoListCell"
    
    let selectedBackView = UIView().then{
        $0.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
    }
    
    let checkBox = UIButton().then{
        $0.setImage(UIImage(named: "check_box_outline_blank"), for: .normal)
        $0.setImage(UIImage(named: "todo_check"), for: .selected)
        $0.addTarget(self, action: #selector(checkBoxDidClicked(_:)), for: .touchUpInside)
    }
    
    let titleLabel = UILabel().then{
        $0.text = "아침 산책"
        $0.textColor = .black
        $0.font = UIFont.nbFont(ofSize: 15, weight: .bold)
        $0.addLetterSpacing(spacing: 0.3)
    }
    
    let categoryButton = UIButton().then{
        $0.setTitle("운동", for: .normal)
        $0.setTitleColor(UIColor(red: 122/255, green: 73/255, blue: 185/255, alpha: 1), for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(ofSize: 12, weight: .bold)
        $0.addLetterSpacing(spacing: 0.24)
        $0.layer.borderColor = UIColor(red: 122/255, green: 73/255, blue: 185/255, alpha: 1).cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 21/2
        $0.titleEdgeInsets = UIEdgeInsets(top: 5, left: 13, bottom: 3, right: 11)
//        $0.backgroundColor = .red
    }
    
    let pinImage = UIImageView().then{
        $0.image = UIImage(named: "push_pin")
    }
    
    let alarmImage = UIImageView().then{
        $0.image = UIImage(named: "notifications")
    }
    
    let timeLabel = UILabel().then{
        $0.text = "AM 7:00"
        $0.font = UIFont.nbFont(ofSize: 13, weight: .medium)
        $0.addLetterSpacing(spacing: -0.26)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        
        self.contentView.backgroundColor = .white
        self.contentView.layer.cornerRadius = 20
        
        
        setUpView()
        setUpConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView(){
        
        self.contentView.addSubview(checkBox)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(categoryButton)
        
        self.contentView.addSubview(pinImage)
        self.contentView.addSubview(alarmImage)
        self.contentView.addSubview(timeLabel)
        
        self.selectedBackgroundView = selectedBackView
        
    }
    
    func setUpConstraint(){
        
        self.contentView.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(75)
            make.top.equalToSuperview().offset(7.5)
            make.bottom.equalToSuperview().offset(-7.5)
        }
        
        checkBox.snp.makeConstraints{ make in
            make.width.height.equalTo(24)
            make.leading.equalToSuperview().offset(19)
            make.top.equalToSuperview().offset(18)
            make.bottom.equalToSuperview().offset(-18)
        }
        
        titleLabel.snp.makeConstraints{ make in
            make.leading.equalTo(checkBox.snp.trailing).offset(13)
//            make.top.equalToSuperview().offset(20.09)
//            make.bottom.equalToSuperview().offset(-23.89)
            make.centerY.equalTo(checkBox)
        }
        
        categoryButton.snp.makeConstraints{ make in
            make.width.equalTo(categoryButton.titleLabel!.snp.width).offset(24)
            make.height.equalTo(21)
            make.trailing.equalTo(pinImage.snp.leading).offset(-7)
            make.top.equalToSuperview().offset(21)
            make.bottom.equalToSuperview().offset(-18)
        }
        
        
        pinImage.snp.makeConstraints{ make in
            make.width.equalTo(14)
            make.height.equalTo(13.2)
            make.trailing.equalTo(alarmImage.snp.leading).offset(-2)
            make.top.equalToSuperview().offset(24.34)
            make.bottom.equalToSuperview().offset(-22.46)
        }
        
        alarmImage.snp.makeConstraints{ make in
            make.width.equalTo(14)
            make.height.equalTo(13.2)
            make.trailing.equalToSuperview().offset(-69)
            make.centerY.equalToSuperview()
        }
        
        timeLabel.snp.makeConstraints{ make in
            make.trailing.equalToSuperview().offset(-18)
            make.top.equalToSuperview().offset(23.4)
            make.bottom.equalToSuperview().offset(-22.46)
            make.lastBaseline.equalTo(alarmImage)
        }
        
    }

    @objc
    func checkBoxDidClicked(_ sender: UIButton){
        
        sender.isSelected.toggle()
        
//        if(sender.isSelected){
//
//        }else{
//
//        }
    }
}
