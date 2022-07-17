//
//  HomeViewController + Layout.swift
//  Todoary
//
//  Created by 예리 on 2022/07/10.
//

import Foundation
import SnapKit


extension HomeViewController {
    
    func setUpView(){
        
        self.view.addSubview(settingBtn)
        self.view.addSubview(logo)
        
        self.view.addSubview(profileImage)
        self.view.addSubview(nickname)
        self.view.addSubview(introduce)
        
        self.view.addSubview(calendarTitle)
        self.view.addSubview(previousMonthBtn)
        self.view.addSubview(nextMonthBtn)
        
        self.view.addSubview(collectionView)

       
    }
    
    
    func setUpConstraint(){
        
        //settingBtn
        settingBtn.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(60)
            make.trailing.equalToSuperview().offset(-9)
            make.width.equalTo(33)
            make.height.equalTo(33)
        }
        
        //logo
        logo.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(56)
            make.leading.equalToSuperview().offset(42)
            make.width.equalTo(56)
            make.height.equalTo(19.27)
        }
        
        //profile
        profileImage.snp.makeConstraints{ make in
            make.top.equalTo(logo.snp.bottom).offset(29.73)
            make.leading.equalToSuperview().offset(41)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        nickname.snp.makeConstraints{ make in
            make.top.equalTo(profileImage)
            make.leading.equalTo(profileImage.snp.trailing).offset(10)
            make.width.equalTo(55)
            make.height.equalTo(21)
        }
        
        introduce.snp.makeConstraints{ make in
            make.top.equalTo(nickname.snp.bottom).offset(4)
            make.leading.equalTo(nickname)
        }
        
        //calendar
        calendarTitle.snp.makeConstraints{ make in
            make.top.equalTo(profileImage.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(45)
        }
        
        previousMonthBtn.snp.makeConstraints{ make in
            make.centerX.equalTo(calendarTitle)
            make.leading.equalTo(calendarTitle.snp.trailing).offset(141)
        }
        
        nextMonthBtn.snp.makeConstraints{ make in
            make.centerX.equalTo(calendarTitle)
            make.leading.equalTo(previousMonthBtn.snp.trailing).offset(13)
        }
        
        collectionView.snp.makeConstraints{ make in
            make.top.equalTo(nextMonthBtn.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-338)
        }
        
        
    }
}

        
