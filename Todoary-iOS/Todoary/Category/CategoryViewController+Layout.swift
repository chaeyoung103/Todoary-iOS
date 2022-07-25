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
        self.view.addSubview(navigationView)
        
        navigationView.addSubview(trashButton)
    }
    
    func setUpConstraint(){
        
        navigationView.snp.makeConstraints{ make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        trashButton.snp.makeConstraints{ make in
            make.width.equalTo(61)
            make.height.equalTo(55)
            make.bottom.equalToSuperview().offset(2)
            make.trailing.equalToSuperview().offset(-19)
        }
        
        collectionView.snp.makeConstraints{ make in
            make.top.equalTo(navigationView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(42)
            make.trailing.equalToSuperview()
            make.height.equalTo(26)
        }
        
        tableView.snp.makeConstraints{ make in
            make.top.equalTo(collectionView.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
