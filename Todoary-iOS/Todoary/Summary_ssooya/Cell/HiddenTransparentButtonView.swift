//
//  HiddenTransparentButtonView.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/19.
//

import UIKit

class HiddenRightButtonView: UIView {
    
    lazy var settingButton = UIButton().then{
        $0.setImage(UIImage(named: "settings"), for: .normal)
    }
    
    lazy var deleteButton = UIButton().then{
        $0.setImage(UIImage(named: "trash"), for: .normal)
    }
    
    let borderLine = UIView().then{
        $0.backgroundColor = UIColor(red: 191/255, green: 191/255, blue: 191/255, alpha: 1)
    }
    
    let transparentView = UIView().then{
        $0.backgroundColor = .transparent
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpView()
        setUpConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func settingButtonDidClicked(_ sender : UIButton){
        print("setting button did clicked")
    }
    
    @objc
    func deleteButtonDidClicked(_ sender : UIButton){
        print("delete button did clicked")
    }
    
    func setUpView(){
        
        self.addSubview(transparentView)
    
        transparentView.addSubview(settingButton)
        transparentView.addSubview(deleteButton)
        transparentView.addSubview(borderLine)
        
    }
    
    func setUpConstraint(){

        self.snp.makeConstraints{ make in
            make.height.equalTo(60)
            make.width.equalTo(105)
        }

        transparentView.snp.makeConstraints{ make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        settingButton.snp.makeConstraints{ make in
            make.width.height.equalTo(28)
            make.trailing.equalTo(borderLine.snp.leading).offset(-11)
            make.centerY.equalToSuperview()
        }
        
        deleteButton.snp.makeConstraints{ make in
            make.width.height.equalTo(30)
            make.trailing.equalToSuperview().offset(-14)
            make.centerY.equalToSuperview()
        }
        
        borderLine.snp.makeConstraints{ make in
            make.width.height.equalTo(1)
            make.top.equalToSuperview().offset(17)
            make.bottom.equalToSuperview().offset(-15)
            make.trailing.equalTo(deleteButton.snp.leading).offset(-10)
        }
        
    }
}


class HiddenLeftButtonView: UIView{
    
    lazy var pinButton = UIButton().then{
        $0.setImage(UIImage(named: "push_pin_big"), for: .normal)
    }
    
    let transparentView = UIView().then{
        $0.backgroundColor = .transparent
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.addSubview(transparentView)
    
        transparentView.addSubview(pinButton)
        
        self.snp.makeConstraints{ make in
            make.height.equalTo(60)
            make.width.equalTo(58)
        }

        transparentView.snp.makeConstraints{ make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
        
        pinButton.snp.makeConstraints{ make in
            make.width.height.equalTo(28)
            make.leading.equalToSuperview().offset(18)
            make.centerY.equalToSuperview()
        }
    }
    
    @objc
    func pinButtonDidClicked(_ sender : UIButton){
        print("pin button did clicked")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
