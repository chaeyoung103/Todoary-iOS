//
//  AppPasswordViewController+Layout.swift
//  Todoary
//
//  Created by 예리 on 2022/07/02.
//

import UIKit
import SnapKit

extension UIView{
    func addSubview(){
        
    }
}

extension AppPasswordViewController {
    func setUpView(){
        
        self.view.addSubview(appPwTitle)
        self.view.addSubview(appPwtext)
        
        self.view.addSubview(nemberBtn1)
        self.view.addSubview(nemberBtn2)
        self.view.addSubview(nemberBtn3)
        self.view.addSubview(nemberBtn4)
        self.view.addSubview(nemberBtn5)
        self.view.addSubview(nemberBtn6)
        self.view.addSubview(nemberBtn7)
        self.view.addSubview(nemberBtn8)
        self.view.addSubview(nemberBtn9)
        self.view.addSubview(nemberBtn0)
        self.view.addSubview(deletBnt)
        
    }

    func setUpConstraint(){
        
        appPwTitle.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(140)
            make.leading.equalToSuperview().offset(161)
        }
        
        appPwtext.snp.makeConstraints{ make in
            make.top.equalTo(appPwTitle.snp.bottom).offset(16)
            make.width.equalTo(120)
            make.height.equalTo(17)
            make.centerX.equalTo(appPwTitle)
        }
    
        nemberBtn1.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(452)
            make.width.equalTo(10)
            make.height.equalTo(31)
            make.leading.equalToSuperview().offset(87)
        }
        
        nemberBtn2.snp.makeConstraints{ make in
            make.leading.equalTo(nemberBtn1.snp.trailing).offset(93)
            make.width.equalTo(14)
            make.height.equalTo(31)
            make.centerY.equalTo(nemberBtn1)
        }
        
        nemberBtn3.snp.makeConstraints{ make in
            make.leading.equalTo(nemberBtn2.snp.trailing).offset(88)
            make.width.equalTo(14)
            make.height.equalTo(31)
            make.centerY.equalTo(nemberBtn2)
        }
        
        nemberBtn4.snp.makeConstraints{ make in
            make.top.equalTo(nemberBtn1.snp.bottom).offset(51)
            make.width.equalTo(16)
            make.height.equalTo(31)
            make.centerX.equalTo(nemberBtn1)
        }
        
        nemberBtn5.snp.makeConstraints{ make in
            make.leading.equalTo(nemberBtn4.snp.trailing).offset(89)
            make.width.equalTo(14)
            make.height.equalTo(31)
            make.centerY.equalTo(nemberBtn4)
        }
        
        nemberBtn6.snp.makeConstraints{ make in
            make.leading.equalTo(nemberBtn5.snp.trailing).offset(87)
            make.width.equalTo(16)
            make.height.equalTo(31)
            make.centerY.equalTo(nemberBtn5)
        }
        
        nemberBtn7.snp.makeConstraints{ make in
            make.top.equalTo(nemberBtn4.snp.bottom).offset(51)
            make.width.equalTo(14)
            make.height.equalTo(31)
            make.centerX.equalTo(nemberBtn4)
        }
        
        nemberBtn8.snp.makeConstraints{ make in
            make.leading.equalTo(nemberBtn7.snp.trailing).offset(88)
            make.width.equalTo(16)
            make.height.equalTo(31)
            make.centerY.equalTo(nemberBtn7)
        }
        
        nemberBtn9.snp.makeConstraints{ make in
            make.leading.equalTo(nemberBtn8.snp.trailing).offset(87)
            make.width.equalTo(16)
            make.height.equalTo(31)
            make.centerY.equalTo(nemberBtn8)
        }
        
        nemberBtn0.snp.makeConstraints{ make in
            make.top.equalTo(nemberBtn8.snp.bottom).offset(51)
            make.width.equalTo(15)
            make.height.equalTo(31)
            make.centerX.equalTo(nemberBtn8)
        }
        
        deletBnt.snp.makeConstraints{ make in
            make.leading.equalTo(nemberBtn0.snp.trailing).offset(81)
            make.width.equalTo(28)
            make.height.equalTo(26.13)
            make.centerY.equalTo(nemberBtn0)
        }
}
}
