//
//  ProfileViewController+Layout.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/11.
//

import UIKit

extension ProfileViewController {
    
    func setUpView(){
        
        self.view.addSubview(navigationView)
        
        self.view.addSubview(profileImage)
        self.view.addSubview(imagePicker)
        self.view.addSubview(nickNameTitle)
        self.view.addSubview(nickNameTf)
        self.view.addSubview(nickNameCount)
        self.view.addSubview(nickNameNotice)
        self.view.addSubview(introduceTitle)
        self.view.addSubview(introduceTf)
        self.view.addSubview(introduceCount)
        self.view.addSubview(confirmBtn)
        


    
    }
    
    func setUpConstraint(){
        
        //navigation bar
        navigationView.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
        }

        //profile
        profileImage.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(124)
            make.centerX.equalToSuperview()
            make.width.equalTo(85)
            make.height.equalTo(85)
        }
        
        imagePicker.snp.makeConstraints{ make in
            make.top.equalTo(profileImage.snp.bottom).offset(14)
            make.centerX.equalToSuperview()
            make.width.equalTo(82)
            make.height.equalTo(26)
        }
        
        nickNameTitle.snp.makeConstraints{ make in
            make.top.equalTo(imagePicker.snp.bottom).offset(31)
            make.leading.equalToSuperview().offset(31)
        }
        
        nickNameTf.snp.makeConstraints{ make in
            make.top.equalTo(nickNameTitle.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-31)
            make.height.equalTo(45)
        }
        
        nickNameCount.snp.makeConstraints{ make in
            make.centerY.equalTo(nickNameTitle)
            make.leading.equalTo(nickNameTitle.snp.trailing).offset(8)
            make.width.equalTo(40)
        }
        
        nickNameNotice.snp.makeConstraints{ make in
            make.centerY.equalTo(nickNameTitle)
            make.trailing.equalToSuperview().offset(-50)
            make.width.equalTo(234)
        }
        
        introduceTitle.snp.makeConstraints{ make in
            make.top.equalTo(nickNameTf.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(31)
        }
        
        introduceTf.snp.makeConstraints{ make in
            make.top.equalTo(introduceTitle.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-31)
            make.height.equalTo(67)
        }
        
        introduceCount.snp.makeConstraints{ make in
            make.centerY.equalTo(introduceTitle)
            make.leading.equalTo(introduceTitle.snp.trailing).offset(8)
            make.width.equalTo(40)
        }
        
        //button
        confirmBtn.snp.makeConstraints{ make in
            make.bottom.equalToSuperview().offset(-47)
            make.leading.equalToSuperview().offset(26)
            make.trailing.equalToSuperview().offset(-26)
            make.height.equalTo(52)
        }
        
        
    }
}

