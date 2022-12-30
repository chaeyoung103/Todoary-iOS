//
//  UseServiceViewController.swift
//  Todoary
//
//  Created by 예리 on 2022/07/04.
//

import Foundation
import UIKit
import SnapKit
import Then


class UseServiceViewController : BaseViewController {
    
    let mainView = UseServiceView()

    override func style() {
        super.style()
        navigationTitle.text = "서비스 이용약관"
    }
    
    override func layout() {
        super.layout()
        
        self.view.addSubview(mainView)
        
        mainView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(Const.Offset.top)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

}
