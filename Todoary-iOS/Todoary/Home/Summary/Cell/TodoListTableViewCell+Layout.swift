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

    }

    //TODO: - 레이아웃 수정
    /**
        1. 카테고리 5글자인 경우 offset 6*2로 지정
        2. 카테고리 5글자인 경우만 아이콘 간격 줄이기
     
     
        카테고리 -> 5글자 : 6*2 offset
     이외 -> 핀, 알람 모두 있을 경우 글자수별 사이즈 적용
     그외 -> 24로 통일
     */
    func setUpViewByCase(){
        
        titleLabel.snp.makeConstraints{ make in
            make.leading.equalTo(checkBox.snp.trailing).offset(13)
            make.centerY.equalToSuperview().offset(1.4)
            
            
            make.width.equalTo(106)
//            make.trailing.equalToSuperview().offset(-177)
            titleLabel.backgroundColor = .red
        }

        categoryButton.snp.makeConstraints{ make in
            make.width.equalTo(categoryButton.titleLabel!.snp.width).offset(cellData.categoryWidth)
            make.height.equalTo(21)
            make.centerY.equalToSuperview().offset(1)
        }
        
        
        if(cellData.isAlarmEnabled){
            
            self.backView.addSubview(timeLabel)
            
            timeLabel.snp.makeConstraints{ make in
                make.trailing.equalToSuperview().offset(-18)
                make.centerY.equalToSuperview().offset(2)
                make.height.equalTo(15)
            }
            
            alarmImageConstraint()
            
            alarmImage.snp.makeConstraints{ make in
                make.trailing.equalTo(timeLabel.snp.leading).offset(-2)
            }
            
            if(cellData.isPinned!){
                
                pinImageConstraint()
                
                pinImage.snp.makeConstraints{ make in
                    make.trailing.equalTo(alarmImage.snp.leading).offset(-2)
                }
                categoryButton.snp.makeConstraints{ make in
                    make.trailing.equalTo(pinImage.snp.leading).offset(-3)
                }
 
                titleLabel.snp.updateConstraints{ make in
                    make.leading.equalTo(checkBox.snp.trailing).offset(7)
                }
            }else{
                categoryButton.snp.makeConstraints{ make in
                    make.trailing.equalTo(alarmImage.snp.leading).offset(-7)
                }
            }
        }else{
            if(cellData.isPinned!){
                
                pinImageConstraint()
                
                pinImage.snp.makeConstraints{ make in
                    make.trailing.equalToSuperview().offset(-18)
                }
                categoryButton.snp.makeConstraints{ make in
                    make.trailing.equalTo(pinImage.snp.leading).offset(-7)
                }
            }else{
                categoryButton.snp.makeConstraints{ make in
                    make.trailing.equalToSuperview().offset(-18)
                }
            }
        }
    }

    
    func pinImageConstraint(){
        
        self.backView.addSubview(pinImage)
        
        pinImage.snp.makeConstraints{ make in
            make.width.equalTo(14)
            make.height.equalTo(13.2)
            make.centerY.equalToSuperview().offset(1)
        }
    }
    
    func alarmImageConstraint(){
        
        self.backView.addSubview(alarmImage)
        
        alarmImage.snp.makeConstraints{ make in
            make.width.equalTo(14)
            make.height.equalTo(13.2)
            make.centerY.equalToSuperview().offset(0.6)
        }
    }

}
