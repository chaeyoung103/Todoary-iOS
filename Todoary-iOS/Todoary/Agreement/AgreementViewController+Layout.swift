//
//  AgreementViewController+Layout.swift
//  Todoary
//
//  Created by 예리 on 2022/07/02.
//

import UIKit
import SnapKit


extension UIView {

}

extension AgreementViewController {
    
    func setUpView(){
        
        self.view.addSubview(agreeTitle)
        self.view.addSubview(confirmButton)
        
        self.view.addSubview(contentScrollView)
        self.view.addSubview(agreeBox)
        self.view.addSubview(agreeLabel)
        
    }
    
    
    func setUpConstraint(){
        
        agreeTitle.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(144)
            make.leading.equalToSuperview().offset(56)
        }
        
        
        //약관내용 박스
        
        agreeBox.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(175)
            make.leading.equalToSuperview().offset(38)
            make.centerX.equalTo(agreeTitle)
            make.top.equalTo(agreeTitle.snp.bottom).offset(11)
        }

        //약관내용
        contentScrollView.snp.makeConstraints{ make in
            make.width.equalTo(281)
            make.height.equalTo(415)
            make.top.equalTo(agreeBox.snp.top).offset(26)
            make.centerX.equalTo(agreeTitle)
        }
        
        contentScrollView.addSubview(agreeLabel)
        
        agreeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentScrollView)
            make.width.equalTo(contentScrollView).multipliedBy(0.85)
            make.centerX.equalTo(contentScrollView)
            make.bottom.equalTo(contentScrollView)
        }
        
        
        //button
        confirmButton.snp.makeConstraints{ make in
            make.bottom.equalToSuperview().offset(-47)
            make.leading.equalToSuperview().offset(26)
            make.trailing.equalToSuperview().offset(-26)
            make.height.equalTo(52)
        }
    }
}

