//
//  TodoBannerCell.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/29.
//

import UIKit

class TodoBannerCell: UITableViewCell , UITextFieldDelegate{

    static let cellIdentifier = "todoBannerCell"
    
    var navigation : UINavigationController!
    
    let selectedBackView = UIView().then{
        $0.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
    }

    lazy var checkBox = UIButton().then{
        $0.setImage(UIImage(named: "todo_check_empty"), for: .normal)
    }
    
    let titleLabel = UITextField().then{
        $0.placeholder = "오늘의 할 일은 무엇인가요?"
        $0.tintColor = .clear
        $0.font = UIFont.nbFont(ofSize: 15, weight: .bold)
        $0.addLetterSpacing(spacing: 0.3)
        $0.setPlaceholderColor(.black)
    }
    
    let backView = UIView().then{
        $0.layer.cornerRadius = 20
        $0.backgroundColor = .white
        $0.layer.shadowRadius = 10.0
        $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowOpacity = 1
        $0.layer.masksToBounds = false
    }
    
    let todoEasySettingView = TodoEasySettingView().then{
        $0.frame = CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 118.0)
    }
    
    let todoTf = UITextField().then{
        $0.placeholder = "오늘의 할일은 무엇인가요?"
        $0.font = UIFont.nbFont(ofSize: 15, weight: .bold)
        $0.addLeftPadding()
        $0.borderStyle = .none
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.silver_217.cgColor
        $0.layer.cornerRadius = 10
        $0.tintColor = .clear
    }
    

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .transparent
     
        setUpView()
        setUpConstraint()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(willMoveNewTodoVC))
        self.contentView.addGestureRecognizer(tapGesture)
        
        titleLabel.delegate = self
        titleLabel.inputAccessoryView = todoEasySettingView
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didShowKeyboardNotification(_:)),
                                               name: UIResponder.keyboardDidShowNotification ,
                                            object: nil)
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView(){
        
        self.contentView.addSubview(backView)
        
        self.backView.addSubview(checkBox)
        self.backView.addSubview(titleLabel)
        self.todoEasySettingView.addSubview(todoTf)
        
        self.selectedBackgroundView = selectedBackView
        
    }
    
    func setUpConstraint(){
        
        self.contentView.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(75)
            make.top.equalToSuperview().offset(7.5)
            make.bottom.equalToSuperview().offset(-7.5)
        }
        
        backView.snp.makeConstraints{ make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        checkBox.snp.makeConstraints{ make in
            make.width.height.equalTo(24)
            make.leading.equalToSuperview().offset(19)
            make.top.equalToSuperview().offset(18)
            make.bottom.equalToSuperview().offset(-18)
        }
        
        titleLabel.snp.makeConstraints{ make in
            make.leading.equalTo(checkBox.snp.trailing).offset(13)
            make.centerY.equalTo(checkBox)
            make.width.equalTo(170)
        }
        
        todoTf.snp.makeConstraints{ make in
            make.width.equalTo(327)
            make.height.equalTo(45)
            make.leading.equalTo(todoEasySettingView).offset(31)
            make.bottom.equalTo(todoEasySettingView).offset(-56)
        }
    
    }
    
    @objc
    func willMoveNewTodoVC(){
        
        self.titleLabel.becomeFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        todoTf.text = textField.text
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        todoTf.text = textField.text
        return true
    }
    
    @objc func didShowKeyboardNotification(_ notification: Notification) {
        print("되니?")
        todoTf.becomeFirstResponder()
    }
}
