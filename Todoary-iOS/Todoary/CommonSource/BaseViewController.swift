//
//  BaseViewController.swift
//  Todoary
//
//  Created by 박지윤 on 2022/09/02.
//

import UIKit

class BaseViewController: UIViewController {
    
    lazy var backBtn = UIButton().then{
        $0.setImage(UIImage(named: "back_arrow"), for: .normal)
        $0.addTarget(self, action: #selector(backButtonDidClicked(_:)), for: .touchUpInside)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true
        
        self.view.addSubview(backBtn)
        
        backBtn.snp.makeConstraints{ make in
            make.width.equalTo(61)
            make.height.equalTo(55)
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(40)
        }
        
    }
    
    @objc
    func backButtonDidClicked(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }

}
