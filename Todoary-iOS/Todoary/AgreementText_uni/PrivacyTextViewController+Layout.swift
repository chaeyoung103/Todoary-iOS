//
//  PrivacyTextViewController+Layout.swift
//  Todoary
//
//  Created by 예리 on 2022/07/04.
//

import Foundation
import SnapKit

extension UIView {

}

extension PrivacyTextViewController {
    
    func setUpView(){
        
//        self.view.addSubview(PrivacyNavigationView)
        
        self.view.addSubview(contentScrollView)
        self.view.addSubview(privacyText)
        
    }
        
    
    func setUpConstraint(){
        
        //navigationView
      //  PrivacyNavigationView.snp.makeConstraints{ make in
       //     make.top.equalToSuperview()
          //  make.leading.trailing.equalToSuperview()
         
       // }
        
    //약관내용
        contentScrollView.snp.makeConstraints{ make in
            make.width.equalTo(318)
            make.height.equalTo(687)
            make.top.equalToSuperview().offset(104)
            make.centerX.equalToSuperview()
        }
        
        contentScrollView.addSubview(privacyText)
    
        privacyText.snp.makeConstraints { (make) in
            make.top.equalTo(contentScrollView)
            make.width.equalTo(contentScrollView)
            make.centerX.equalTo(contentScrollView)
            make.bottom.equalTo(contentScrollView)
        }
    }
}
