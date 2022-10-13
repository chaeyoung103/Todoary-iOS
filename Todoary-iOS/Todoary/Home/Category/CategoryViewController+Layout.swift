//
//  CategoryViewController+Layout.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/23.
//

import Foundation

extension CategoryViewController{
    
    func setUpView(){

        self.view.addSubview(collectionView)
        self.view.addSubview(tableView)
        
        self.view.addSubview(trashButton)
    }
    
    func setUpConstraint(){
        
        trashButton.snp.makeConstraints{ make in
            make.width.equalTo(61)
            make.height.equalTo(55)
            make.top.equalToSuperview().offset(42)
            make.trailing.equalToSuperview().offset(-18.95)
        }
        
        collectionView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(106)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(26)
        }
        
        tableView.snp.makeConstraints{ make in
            make.top.equalTo(collectionView.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
