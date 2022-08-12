//
//  AccountViewController+Layout.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/10.
//

import UIKit

extension AccountViewController {
    
    func setUpView(){
        
        self.view.addSubview(navigationView)
        
        self.view.addSubview(profileImage)
        self.view.addSubview(nickName)
        self.view.addSubview(introduce)
        self.view.addSubview(profileChangeBtn)
        
        self.view.addSubview(accountTitle)
        self.view.addSubview(userAccount)
        self.view.addSubview(accountBorderLine)
        
        self.view.addSubview(tableView)


    
    }
    
    func setUpConstraint(){
        
        //navigation bar
        navigationView.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
        }

        //profile
        profileImage.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(135)
            make.leading.equalToSuperview().offset(42)
            make.width.equalTo(85)
            make.height.equalTo(85)
        }
        
        nickName.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(155)
            make.leading.equalTo(profileImage.snp.trailing).offset(17)
        }
        
        introduce.snp.makeConstraints{ make in
            make.top.equalTo(nickName.snp.bottom).offset(10)
            make.leading.equalTo(nickName.snp.leading)
            make.trailing.equalToSuperview().offset(-31)
        }
        
        profileChangeBtn.snp.makeConstraints{ make in
            make.top.equalTo(introduce.snp.bottom).offset(38)
            make.centerX.equalToSuperview()
            make.width.equalTo(118)
            make.height.equalTo(31)
        }
        
        //account
        accountTitle.snp.makeConstraints{ make in
            make.top.equalTo(profileChangeBtn.snp.bottom).offset(41)
            make.leading.equalToSuperview().offset(31)
        }
        
        userAccount.snp.makeConstraints{ make in
            make.centerY.equalTo(accountTitle)
            make.trailing.equalToSuperview().offset(-31)
        }
        
        accountBorderLine.snp.makeConstraints{ make in
            make.trailing.equalToSuperview().offset(-31)
            make.height.equalTo(1)
            make.leading.equalTo(accountTitle.snp.leading)
            make.top.equalTo(accountTitle.snp.bottom).offset(17)
        }
        
        //tableView
        tableView.snp.makeConstraints{ make in
            make.top.equalTo(accountBorderLine.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
