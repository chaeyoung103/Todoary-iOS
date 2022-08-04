//
//  DiaryToolbarViewController.swift
//  Todoary
//
//  Created by 예리 on 2022/08/04.
//

import Foundation
import UIKit
import SnapKit
import Then


class DiaryToolbar : UIView {
    
    //MARK: - UIComponenets
    
    let backToolbar = UIView().then{
        $0.backgroundColor = .none
    }
    
    let cameraBtn = UIButton().then{
        $0.setImage(UIImage(named: "camera"), for: .normal)
    }
    let textBtn = UIButton().then{
        $0.setImage(UIImage(named: "type"), for: .normal)
    }
    let stickerBtn = UIButton().then{
        $0.setImage(UIImage(named: "smile"), for: .normal)
    }
    let highlightBtn = UIButton().then{
        $0.setImage(UIImage(named: "edit"), for: .normal)
    }
    let exitBtn = UIButton().then{
        $0.setImage(UIImage(named: "x"), for: .normal)
    }
    
    let firstToolbar = UIView().then{
        $0.backgroundColor = UIColor(
            red: 230/255,
            green: 230/255,
            blue: 230/255,
            alpha: 1
        )
    }
    
    //MARK: - UIComponenets_colorToolbar
    
    let yellowBtn = UIButton().then{
        $0.backgroundColor = UIColor(
            red: 254/255,
            green: 210/255,
            blue: 90/255,
            alpha: 1
        )
        $0.layer.cornerRadius = 28/2
    }
    
    let orangeBtn = UIButton().then{
        $0.backgroundColor = UIColor(
            red: 255/255,
            green: 143/255,
            blue: 84/255,
            alpha: 1
        )
        $0.layer.cornerRadius = 28/2
    }
    
    let redBtn = UIButton().then{
        $0.backgroundColor = UIColor(
            red: 234/255,
            green: 44/255,
            blue: 4/255,
            alpha: 1
        )
        $0.layer.cornerRadius = 28/2
    }
    
    let greenBtn = UIButton().then{
        $0.backgroundColor = UIColor(
            red: 172/255,
            green: 215/255,
            blue: 134/255,
            alpha: 1
        )
        $0.layer.cornerRadius = 28/2
    }
    
    let blueBtn = UIButton().then{
        $0.backgroundColor = UIColor(
            red: 86/255,
            green: 152/255,
            blue: 255/255,
            alpha: 1
        )
        $0.layer.cornerRadius = 28/2
    }
    
    let grayBtn = UIButton().then{
        $0.backgroundColor = UIColor(
            red: 184/255,
            green: 184/255,
            blue: 184/255,
            alpha: 1
        )
        $0.layer.cornerRadius = 28/2
    }
    
    let colorToolbar = UIView().then{
        $0.backgroundColor = .white
        $0.layer.borderColor = UIColor.silver_225.cgColor
        $0.layer.borderWidth = 1
    }
    
    //MARK: - UIComponenets_textToolbar
    
    let 
    
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
    
    //MARK: - Helpers
}
