//
//  PrivacyTextViewController.swift
//  Todoary
//
//  Created by 예리 on 2022/07/04.
//

import Foundation
import UIKit
import SnapKit
import Then


class PrivacyTextViewController : BaseViewController {
    
    let mainView = PrivacyTextView()

    override func style() {
        super.style()
        navigationTitle.text = "개인정보 이용동의"
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

