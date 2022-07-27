//
//  ColorPickerCollectionViewCell.swift
//  Todoary
//
//  Created by 예리 on 2022/07/24.
//

import UIKit
import UIKit
import SnapKit
import Then

class ColorPickerCollectionViewCell: UICollectionViewCell {
    static let identifier = "ColorPickerCollectionViewCell"
    
    
    //MARK: - UIComponenets
    
    var iscolorBtntap = false{
        didSet{
            self.colorBtndidtap()
        }
    }
    
    let colorBtn = UIButton().then{
        //원형버튼 만들기
        $0.layer.cornerRadius = 30/2
        $0.addTarget(self, action: #selector(colorBtnDidTab), for: .touchUpInside)
    }
    
   
    let colorBtnpick = UIView().then{
        $0.layer.borderWidth = 2
        $0.layer.cornerRadius = 40/2
        $0.isHidden = true
        $0.isUserInteractionEnabled = true
        
    }
   
    
    //MARK: - Lifecycles
    
    override init(frame: CGRect) {
      super.init(frame: frame)
    
        setUpContentView()
        setUpConstraint()
    }

    //MARK: - layout
        func setUpContentView(){
            
            contentView.addSubview(colorBtn)
            contentView.addSubview(colorBtnpick)
        }
            
        
        func setUpConstraint(){
            
            colorBtn.snp.makeConstraints{ make in
                make.width.height.equalTo(30)
            }
            
            colorBtnpick.snp.makeConstraints{ make in
                make.width.height.equalTo(40)
                make.centerX.centerY.equalTo(colorBtn)
            }
        }
            
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    

    //MARK: - Actions

    @objc func colorBtnDidTab() {
        if colorBtn.isSelected == true {
            iscolorBtntap = true
        } else {
            iscolorBtntap = false
        }
    }

    //MARK: - Helpers
    
    private func colorBtndidtap() {
        if iscolorBtntap {
            colorBtnpick.isHidden = true
        } else {colorBtnpick.isHidden = false
    }
}
    override var isSelected: Bool {
            didSet {
                if isSelected {
                    iscolorBtntap = true
                } else {
                    iscolorBtntap = false
                }

}

