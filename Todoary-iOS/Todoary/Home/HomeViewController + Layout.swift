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
        
        self.view.addSubview(year_Month)
        self.view.addSubview(previousMonthBtn)
        self.view.addSubview(nextMonthBtn)
        
        self.view.addSubview(collectionView)

       
    }
    
    
    func setUpConstraint(){
        
        //settingBtn
        settingBtn.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(52)
            make.trailing.equalToSuperview().offset(-25)
            make.width.equalTo(25)
            make.height.equalTo(25)
        }
        
        //logo
        logo.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(52)
            make.leading.equalToSuperview().offset(42)
            make.width.equalTo(90)
            make.height.equalTo(24)
        }
        
        //profile
        profileImage.snp.makeConstraints{ make in
            make.top.equalTo(logo.snp.bottom).offset(29)
            make.leading.equalToSuperview().offset(41)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        nickname.snp.makeConstraints{ make in
            make.top.equalTo(profileImage)
            make.leading.equalTo(profileImage.snp.trailing).offset(10)
            make.height.equalTo(21)
        }
        
        introduce.snp.makeConstraints{ make in
            make.top.equalTo(nickname.snp.bottom).offset(4)
            make.leading.equalTo(profileImage.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-25)
        }
        
        year_Month.snp.makeConstraints{ make in
            make.top.equalTo(profileImage.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(45)
            make.width.equalTo(100)
            make.height.equalTo(22)
        }
        
        previousMonthBtn.snp.makeConstraints{ make in
            make.centerY.equalTo(year_Month)
            make.trailing.equalTo(nextMonthBtn.snp.leading).offset(-13)
        }
        
        nextMonthBtn.snp.makeConstraints{ make in
            make.centerY.equalTo(year_Month)
            make.trailing.equalToSuperview().offset(-33)
        }
        
        collectionView.snp.makeConstraints{ make in
            make.top.equalTo(year_Month.snp.bottom).offset(17)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(28)
            make.trailing.equalToSuperview().offset(-28)
            make.bottom.equalToSuperview()
        }
        
        
    }
}

        
