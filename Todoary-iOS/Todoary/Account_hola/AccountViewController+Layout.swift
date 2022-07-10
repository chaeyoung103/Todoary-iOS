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
    }
}
