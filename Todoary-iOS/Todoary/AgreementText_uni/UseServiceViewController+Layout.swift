//
//  UseServiceViewController+Layout.swift
//  Todoary
//
//  Created by 예리 on 2022/07/04.
//

import Foundation
import SnapKit

extension UIView {

}

extension UseServiceViewController {
    
    func setUpView(){
        
        self.view.addSubview(UseServiceNavigationView)
        
        self.view.addSubview(contentScrollView)
        self.view.addSubview(UseServiceText)
        
    }
        
    
    func setUpConstraint(){
        
        //navigationView
        UseServiceNavigationView.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            
        }
        
    //약관내용
        contentScrollView.snp.makeConstraints{ make in
            make.width.equalTo(318)
            make.height.equalTo(687)
            make.top.equalToSuperview().offset(104)
            make.centerX.equalToSuperview()
        }
        
        contentScrollView.addSubview(UseServiceText)
    
        UseServiceText.snp.makeConstraints { (make) in
            make.top.equalTo(contentScrollView)
            make.width.equalTo(contentScrollView)
            make.centerX.equalTo(contentScrollView)
            make.bottom.equalTo(contentScrollView)
        }
    }
}
