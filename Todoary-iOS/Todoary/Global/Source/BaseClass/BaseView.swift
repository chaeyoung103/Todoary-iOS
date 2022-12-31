//
//  BaseView.swift
//  Todoary
//
//  Created by 박지윤 on 2022/12/31.
//

import UIKit

class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        hierarchy()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func style() { }
    func hierarchy() { }
    func layout() { }

}
