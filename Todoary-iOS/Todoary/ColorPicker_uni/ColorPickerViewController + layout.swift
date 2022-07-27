//
//  ColorPickerViewController + layout.swift
//  Todoary
//
//  Created by 예리 on 2022/07/24.
//

import Foundation

extension ColorPickerViewController {
    
    func setUpView(){
        
        self.view.addSubview(navigationView)
        
        self.view.addSubview(categoryTitle)
        self.view.addSubview(colorview)
    }
    
    
    func setUpConstraint(){
        
        navigationView.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        categoryTitle.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(120)
            make.centerX.equalToSuperview()
            make.width.equalTo(327)
            make.height.equalTo(45)

        }
        
        colorview.snp.makeConstraints{ make in
            make.top.equalTo(categoryTitle.snp.bottom).offset(18)
            make.width.equalTo(326)
            make.height.equalTo(196)
            make.centerX.equalToSuperview()
        }
    }
}
