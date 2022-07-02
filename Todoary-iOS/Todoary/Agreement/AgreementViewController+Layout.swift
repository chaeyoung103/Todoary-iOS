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
        
    }
    
    func setUpConstraint(){
        
        agreeTitle.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(144)
            make.leading.equalToSuperview().offset(56)
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
