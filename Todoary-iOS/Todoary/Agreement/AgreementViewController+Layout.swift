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
        self.view.addSubview(confirmBtn)
        
        self.view.addSubview(agreeAllCheckBtn)
        self.view.addSubview(agreeAllCheckText)
        
       
        
    }
    
    
    func setUpConstraint(){
        
        agreeTitle.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(144)
            make.leading.equalToSuperview().offset(56)
        }
        
        
        //약관 체크버튼
        
        agreeAllCheckBtn.snp.makeConstraints{ make in
            make.width.equalTo(22)
            make.height.equalTo(22)
            make.left.equalToSuperview().offset(55)
            make.top.equalTo(agreeTitle.snp.bottom).offset(9)
        }
        
        agreeAllCheckText.snp.makeConstraints{ make in
            make.width.equalTo(58)
            make.height.equalTo(19)
            make.leading.equalTo(agreeAllCheckBtn.snp.trailing).offset(7)
            make.centerY.equalTo(agreeAllCheckBtn)
            
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

