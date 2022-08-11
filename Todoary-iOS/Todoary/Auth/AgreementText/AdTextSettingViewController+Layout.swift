//
//  AdTextSettingViewController+Layout.swift
//  Todoary
//
//  Created by 예리 on 2022/08/11.
//

import Foundation
import SnapKit

extension UIView {

}

extension AdTextSettingViewController {
    
    func setUpView(){
        
        self.view.addSubview(contentView)
        
        self.view.addSubview(navigationView)
        
        self.view.addSubview(contentScrollView)
        self.view.addSubview(AdText)
        
        self.view.addSubview(adTitle)
        self.view.addSubview(adCheckBtn)
        
    }
        
    
    func setUpConstraint(){
        
        //navigationView
        contentView.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        navigationView.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        
        
    //약관내용
        contentScrollView.snp.makeConstraints{ make in
            make.width.equalTo(318)
            make.height.equalTo(651)
            make.top.equalToSuperview().offset(104)
            make.centerX.equalToSuperview()
        }
        
        contentScrollView.addSubview(AdText)
    
        AdText.snp.makeConstraints { make in
            make.top.equalTo(contentScrollView)
            make.width.equalTo(contentScrollView)
            make.centerX.equalTo(contentScrollView)
            make.bottom.equalTo(contentScrollView)
        }
        
        adTitle.snp.makeConstraints{ make in
            make.top.equalTo(contentScrollView.snp.bottom).offset(2)
            make.width.equalTo(63)
            make.height.equalTo(18)
            make.trailing.equalTo(contentScrollView.snp.trailing)
        }
        
        adCheckBtn.snp.makeConstraints{make in
            make.width.height.equalTo(20)
            make.centerY.equalTo(adTitle)
            make.trailing.equalTo(adTitle.snp.leading).offset(-5)
        }
    }
}
