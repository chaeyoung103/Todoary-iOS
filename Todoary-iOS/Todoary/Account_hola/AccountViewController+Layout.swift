//
//  AccountViewController+Layout.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/10.
//

import UIKit

extension AccountViewController {
    
    func setUpView(){
        
        self.view.addSubview(contentView)
        
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
        
        //background
        contentView.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        
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
            make.leading.equalTo(profileImage.snp.trailing).offset(20)
        }
        
        introduce.snp.makeConstraints{ make in
            make.top.equalTo(nickName.snp.bottom).offset(10)
            make.leading.equalTo(nickName.snp.leading)
        }
        
        profileChangeBtn.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(165)
            make.trailing.equalToSuperview().offset(-50)
            make.width.equalTo(78)
            make.height.equalTo(26)
        }
        
        //account
        accountTitle.snp.makeConstraints{ make in
            make.top.equalTo(profileImage.snp.bottom).offset(52)
            make.leading.equalToSuperview().offset(31)
        }
        
        userAccount.snp.makeConstraints{ make in
            make.centerY.equalTo(accountTitle)
            make.leading.equalTo(accountTitle.snp.trailing).offset(187)
        }
        
        accountBorderLine.snp.makeConstraints{ make in
            make.width.equalTo(328)
            make.height.equalTo(1)
            make.leading.equalTo(accountTitle.snp.leading)
            make.top.equalTo(accountTitle.snp.bottom).offset(17)
        }
        
        //tableView
        tableView.snp.makeConstraints{ make in
            make.top.equalTo(accountBorderLine.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
    }
}
