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
    
    let colorBtn = UIButton().then{
        $0.backgroundColor = UIColor.category1
        //원형버튼 만들기
        $0.layer.cornerRadius = 35/2
    }
    
    let colorBtnpick = UIView().then{
        $0.layer.borderWidth = 2
        $0.layer.cornerRadius = 45/2
        $0.layer.borderColor = UIColor.category1.cgColor
    }
    
    //layout
    
    override init(frame: CGRect) {
      super.init(frame: frame)
        
        setUpContentView()
        setUpConstraint()
    }

    
        func setUpContentView(){
            
            contentView.addSubview(colorBtn)
            contentView.addSubview(colorBtnpick)
        }
            
        
        func setUpConstraint(){
            
            colorBtn.snp.makeConstraints{ make in
                make.width.height.equalTo(35)
            }
            
//            colorBtnpick.snp.makeConstraints{ make in
//                make.width.height.equalTo(45)
//                make.centerX.centerY.equalTo(colorBtn)
//            }
        }
            
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }

