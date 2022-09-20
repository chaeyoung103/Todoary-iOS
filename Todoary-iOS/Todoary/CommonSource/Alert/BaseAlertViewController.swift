//
//  BaseAlertViewController.swift
//  Todoary
//
//  Created by 박지윤 on 2022/09/20.
//

import UIKit

class BaseAlertViewController: UIAlertController {
    
    let titleLabel = UILabel().then{
        $0.font = UIFont.nbFont(ofSize: 17, weight: .bold, type: .apple)
        $0.textAlignment = .center
        $0.labelAttributeSetting(letterSpacing: -0.41, lineHeight: 22)
    }
    
    lazy var okBtn = UIButton().then{
        $0.layer.cornerRadius = 11
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(ofSize: 17, weight: .semibold, type: .apple)
        $0.titleLabel?.textAlignment = .center
        $0.addTarget(self, action: #selector(okBtnDidClicked), for: .touchUpInside)
    }
    
    let containerView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 14
        $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4).cgColor
        $0.layer.shadowOpacity = 1
        $0.layer.shadowRadius = 8
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
    }
    
    let btnStackView = UIStackView().then{
        $0.spacing = 40
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpInitSetting()
        setUpView()
        setUpConstraint()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)

        // curveEaseOut: 시작은 천천히, 끝날 땐 빠르게
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseOut) { [weak self] in
            self?.containerView.transform = .identity
            self?.containerView.isHidden = false
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)

        // curveEaseIn: 시작은 빠르게, 끝날 땐 천천히
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseIn) { [weak self] in
            self?.containerView.transform = .identity
            self?.containerView.isHidden = true
        }
    }
    
    func setUpInitSetting(){
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissAlertController))
        gesture.delegate = self
        
        self.view.addGestureRecognizer(gesture)
    }
    
    func setUpView(){
        
        self.view.addSubview(containerView)
        
        containerView.addSubview(btnStackView)
        
        btnStackView.addArrangedSubview(okBtn)
    }
    
    func setUpConstraint(){
        
        containerView.snp.makeConstraints{ make in
            make.centerY.equalToSuperview().offset(-2)
            make.leading.equalToSuperview().offset(60)
            make.trailing.equalToSuperview().offset(-60)
        }
        
    }
    
    //MARK: - Action
    
    @objc func dismissAlertController(){
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc func okBtnDidClicked(){
        self.dismiss(animated: false, completion: nil)
    }

}

extension BaseAlertViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        guard touch.view?.isDescendant(of: self.containerView) == false else { return false }
        
        return true
    }
}
