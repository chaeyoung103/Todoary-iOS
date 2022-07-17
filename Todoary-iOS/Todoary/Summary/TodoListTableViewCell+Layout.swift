//
//  TodoListTableViewCell+Layout.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/17.
//

import Foundation

extension TodoListTableViewCell{
    
    func setUpView(){
    
        self.contentView.addSubview(backView)
        
        self.backView.addSubview(checkBox)
        self.backView.addSubview(titleLabel)
        self.backView.addSubview(categoryButton)
        
        self.backView.addSubview(pinImage)
        self.backView.addSubview(alarmImage)
        self.backView.addSubview(timeLabel)
        
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
        
        backView.snp.makeConstraints{ make in
            make.leading.trailing.top.bottom.equalToSuperview()
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
            make.top.equalToSuperview().offset(23.4)
            make.bottom.equalToSuperview().offset(-23.4)
        }
        
        timeLabel.snp.makeConstraints{ make in
            make.trailing.equalToSuperview().offset(-18)
            make.top.equalToSuperview().offset(23.4)
            make.bottom.equalToSuperview().offset(-22.46)
            make.lastBaseline.equalTo(alarmImage)
        }
        
    }
}
