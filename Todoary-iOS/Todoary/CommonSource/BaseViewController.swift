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
    
    let navigationTitle = UILabel().then{
        $0.font = UIFont.nbFont(type: .header)
        $0.textColor = .black
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true
        
        self.view.addSubview(backBtn)
        self.view.addSubview(navigationTitle)
        
        backBtn.snp.makeConstraints{ make in
            make.width.equalTo(61)
            make.height.equalTo(55)
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(40)
        }
        
        navigationTitle.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(backBtn)
        }
        
    }
    
    @objc
    func backButtonDidClicked(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }

}
