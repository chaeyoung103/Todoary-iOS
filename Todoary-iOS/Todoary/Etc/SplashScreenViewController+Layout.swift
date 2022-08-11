//
//  SplashScreenViewController+Layout.swift
//  Todoary
//
//  Created by 예리 on 2022/08/11.
//

import Foundation
import SnapKit
import UIKit


extension SplashScreenViewController{
    
    func setUpView(){
        
        self.view.addSubview(appface)
        self.view.addSubview(apptitle)
        
    }
    
    func setUpConstraint(){
        
        self.appface.snp.makeConstraints{ make in
            make.width.height.equalTo(173)
            make.top.equalToSuperview().offset(305)
            make.centerX.equalToSuperview()
        
        self.apptitle.snp.makeConstraints{ make in
            make.width.equalTo(200)
            make.height.equalTo(55)
            make.top.equalToSuperview().offset(496)
            make.centerX.equalToSuperview()
        }
        }
    }
}
        
