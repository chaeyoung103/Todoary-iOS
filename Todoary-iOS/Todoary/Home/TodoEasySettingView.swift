//
//  TodoEasySettingView.swift
//  Todoary
//
//  Created by 송채영 on 2022/08/05.
//


class TodoEasySettingView : UIView {

    //MARK: - UIComponenets
    
    let backgroundView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 30
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.clipsToBounds = true
        $0.isUserInteractionEnabled = false
    }

    
    //MARK: - Lifecycles
    
    override init(frame: CGRect) {
      super.init(frame: frame)
    
        setUpView()
        setUpConstraint()
    }
    
    required init?(corder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Layout
    
    func setUpView(){
        self.addSubview(backgroundView)

    }
    
    func setUpConstraint(){
        backgroundView.snp.makeConstraints{ make in
            make.width.equalToSuperview()
            make.height.equalTo(118)
        }

    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    
    
   
}
