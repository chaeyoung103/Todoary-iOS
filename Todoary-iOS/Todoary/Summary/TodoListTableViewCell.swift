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
        $0.setImage(UIImage(named: "check_box"), for: .selected)
    }
    
    let titleLabel = UILabel().then{
        $0.text = "아침 산책"
        $0.textColor = .black
        $0.font = UIFont.nbFont(ofSize: 15, weight: .bold)
        $0.addLetterSpacing(spacing: 0.3)
    }
    
    let categoryButton = UIButton().then{
        $0.setTitle("운동", for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(ofSize: 12, weight: .bold)
        $0.addLetterSpacing(spacing: 0.24)
    }
    
    let pinImage = UIImageView().then{
        $0.image = UIImage(named: "document")
    }
    
    let alarmImage = UIImageView().then{
        $0.image = UIImage(named: "document")
    }
    
    let timeLabel = UILabel().then{
        $0.text = "AM 7:00"
        $0.font = UIFont.nbFont(ofSize: 13, weight: .medium)
        $0.addLetterSpacing(spacing: -0.26)
        $0.textAlignment = .right
    }
    
    let stackView = UIStackView().then{
        $0.axis = .horizontal
        $0.spacing = 2
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
        
        stackView.addArrangedSubview(pinImage)
        stackView.addArrangedSubview(alarmImage)
        stackView.addArrangedSubview(timeLabel)
        
        self.contentView.addSubview(checkBox)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(categoryButton)
        self.contentView.addSubview(stackView)
        
        self.selectedBackgroundView = selectedBackView
        
        
        self.backgroundColor = .red
        self.contentView.backgroundColor = .green
        
    }
    
    func setUpConstraint(){
        
//        self.snp.makeConstraints{ make in
////            make.leading.equalToSuperview().offset(32)
////            make.trailing.equalToSuperview().offset(-30)
//            make.width.equalTo(328)
//            make.height.equalTo(60)
//        }
        
        self.contentView.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(60)
            make.centerY.equalToSuperview()
        }
        
        checkBox.snp.makeConstraints{ make in
            make.width.height.equalTo(24)
            make.leading.equalToSuperview().offset(19)
            make.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints{ make in
            make.leading.equalTo(checkBox.snp.trailing).offset(13)
            make.top.equalToSuperview().offset(20.09)
            make.bottom.equalToSuperview().offset(-23.89)
        }
        
        categoryButton.snp.makeConstraints{ make in
            make.width.equalTo(46)
            make.height.equalTo(21)
            make.trailing.equalTo(stackView.snp.leading).offset(-7)
            make.top.equalToSuperview().offset(21)
            make.bottom.equalToSuperview().offset(-18)
        }
        
        
        pinImage.snp.makeConstraints{ make in
            make.width.equalTo(14)
            make.height.equalTo(13.2)
        }
        
        
        alarmImage.snp.makeConstraints{ make in
            make.width.equalTo(14)
            make.height.equalTo(13.2)
        }
        
        
        timeLabel.snp.makeConstraints{ make in
            
        }
        
        
        stackView.snp.makeConstraints{ make in
            make.trailing.equalToSuperview().offset(-18)
            make.top.equalTo(23.4)
            make.bottom.equalTo(-22.46)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0))
    }
}
