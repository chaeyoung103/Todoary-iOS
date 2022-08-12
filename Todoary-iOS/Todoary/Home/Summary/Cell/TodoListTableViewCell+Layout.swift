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
            make.centerY.equalTo(checkBox)
            make.width.equalTo(106)
        }
        
    }
    
    //default 아닌 view
    func setUpViewByCase(){
        
        self.backView.addSubview(categoryButton)
        
        categoryButton.snp.makeConstraints{ make in
            make.width.equalTo(categoryButton.titleLabel!.snp.width).offset(24)
            make.height.equalTo(21)
            make.centerY.equalToSuperview()
        }
        
        //time
        if(cellData.targetTime != nil){
            
            self.backView.addSubview(timeLabel)
            
            timeLabel.snp.makeConstraints{ make in
                make.trailing.equalToSuperview().offset(-18)
                make.top.equalToSuperview().offset(24)
                make.bottom.equalToSuperview().offset(-21)
                make.height.equalTo(15)
            }
            
            //alarm
            if(cellData.isAlarmEnabled){
                
                alarmImageConstraint()
                
                alarmImage.snp.makeConstraints{ make in
                    make.trailing.equalTo(timeLabel.snp.leading).offset(-4.33)
                }
                
                //pin
                if(cellData.isPinned!){
                    
                    pinImageConstraint()
                    
                    pinImage.snp.makeConstraints{ make in
                        make.trailing.equalTo(alarmImage.snp.leading).offset(-7.25)
                    }
                    categoryButton.snp.makeConstraints{ make in
                        make.trailing.equalTo(pinImage.snp.leading).offset(-5.92)
//                        make.width.equalTo(categoryButton.titleLabel!.snp.width).offset(cellData.categoryWidth)
                    }
                    categoryButton.snp.updateConstraints{ make in
                        make.width.equalTo(categoryButton.titleLabel!.snp.width).offset(cellData.categoryWidth)
                    }
                    
                }else{
                    categoryButton.snp.makeConstraints{ make in
                        make.trailing.equalTo(alarmImage.snp.leading).offset(-9.33)
                    }
                }
                
                
            }else{
                //pin
                if(cellData.isPinned!){
                    
                    pinImageConstraint()
                    
                    pinImage.snp.makeConstraints{ make in
                        make.trailing.equalTo(timeLabel.snp.leading).offset(-5)
                    }
                    categoryButton.snp.makeConstraints{ make in
                        make.trailing.equalTo(pinImage.snp.leading).offset(-7)
                    }
                    
                }else{
                    categoryButton.snp.makeConstraints{ make in
                        make.trailing.equalTo(timeLabel.snp.leading).offset(-7)
                    }
                }
            }
        }else{
            
            //alarm
            if(cellData.isAlarmEnabled){
                
                alarmImageConstraint()
                
                alarmImage.snp.makeConstraints{ make in
                    make.trailing.equalToSuperview().offset(-18)
                }
                
                if(cellData.isPinned!){
                    
                    pinImageConstraint()
                    
                    pinImage.snp.makeConstraints{ make in
                        make.trailing.equalTo(alarmImage.snp.leading).offset(-2)
                    }
                    categoryButton.snp.makeConstraints{ make in
                        make.trailing.equalTo(pinImage.snp.leading).offset(-7)
                    }
                }else{
                    categoryButton.snp.makeConstraints{ make in
                        make.trailing.equalToSuperview().offset(-18)
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
    }
    
    func pinImageConstraint(){
        
        self.backView.addSubview(pinImage)
        
        pinImage.snp.makeConstraints{ make in
            make.width.equalTo(8.17)
            make.height.equalTo(11)
            make.top.equalToSuperview().offset(26.44)
            make.bottom.equalToSuperview().offset(-22.56)
        }
    }
    
    func alarmImageConstraint(){
        
        self.backView.addSubview(alarmImage)
        
        alarmImage.snp.makeConstraints{ make in
            make.width.equalTo(9.33)
            make.height.equalTo(10.73)
            make.top.equalToSuperview().offset(25.77)
            make.bottom.equalToSuperview().offset(-23.5)
        }
    }

}
