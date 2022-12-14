//
//  BaseViewController.swift
//  Todoary
//
//  Created by 박지윤 on 2022/09/02.
//

import UIKit

class BaseViewController: UIViewController {
    
    private let navigationView = UIView()
    
    final lazy var backBtn = UIButton().then{
        $0.setImage(UIImage(named: "back_arrow"), for: .normal)
        $0.addTarget(self, action: #selector(backButtonDidClicked(_:)), for: .touchUpInside)
    }
    
    final let navigationTitle = UILabel().then{
        $0.font = UIFont.nbFont(type: .header)
        $0.textColor = .black
    }
    
    lazy var rightButton = UIButton().then{
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .header)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        baseConfigure()
    }
    
    final func baseConfigure(){
        
        self.view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true
        
        self.view.addSubview(navigationView)
        
        navigationView.addSubview(backBtn)
        navigationView.addSubview(navigationTitle)
        
        navigationView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(40)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(55)
        }
        
        backBtn.snp.makeConstraints{ make in
            make.width.equalTo(61)
            make.leading.top.bottom.equalToSuperview()
        }
        
        navigationTitle.snp.makeConstraints{ make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    final func setRightButtonWithText(_ text: String){
        
        rightButton.setTitle(text, for: .normal)
        
        navigationView.addSubview(rightButton)
        
        rightButton.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-23.86)
            $0.width.height.equalTo(rightButton.titleLabel!)
        }
    }
    
    final func setRightButtonWithImage(_ image: UIImage!){
        
        rightButton.setImage(image, for: .normal)
        
        navigationView.addSubview(rightButton)
        
        rightButton.snp.makeConstraints{
            $0.top.equalToSuperview().offset(2)
            $0.height.equalToSuperview()
            $0.width.equalTo(60.84)
            $0.trailing.equalToSuperview().offset(-18.95)
        }
    }
    
    @objc func backButtonDidClicked(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }

}
