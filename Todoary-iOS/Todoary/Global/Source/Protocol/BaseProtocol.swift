//
//  BaseView.swift
//  Todoary
//
//  Created by 박지윤 on 2022/12/25.
//

import UIKit

protocol BaseSourceProtocol{
    var baseView: UIView { get }
    func baseViewConfigure()
}

@objc protocol BaseViewProtocol{
    @objc optional func style()
    func hierarchy()
    func layout()
}

@objc protocol BaseViewControllerProtocol{
    @objc optional func style()
    @objc optional func initialize()
    func layout()
}

@objc protocol BaseCellProtocol: BaseViewProtocol{
    static var cellIdentifier: String{ get }
}
