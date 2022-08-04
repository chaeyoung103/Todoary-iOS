//
//  DiaryToolbarViewController+Layout.swift
//  Todoary
//
//  Created by 예리 on 2022/08/04.
//

import Foundation
import UIKit
import SnapKit

extension DiaryToolbar {
    
    func setUpView(){
        self.addSubview(backToolbar)
        
        self.addSubview(firstToolbar)
        
        self.addSubview(colorToolbar)
        

    }
    
    
    func setUpConstraint(){
        
        backToolbar.snp.makeConstraints{ make in
            make.width.equalToSuperview()
            make.height.equalTo(92)
        }
        
        backToolbar.addSubview(firstToolbar)
        
        firstToolbar.snp.makeConstraints{ make in
            make.width.equalToSuperview()
            make.height.equalTo(46)
            make.bottom.equalToSuperview()
        }
        
        firstToolbar.addSubview(cameraBtn)
        firstToolbar.addSubview(textBtn)
        firstToolbar.addSubview(stickerBtn)
        firstToolbar.addSubview(highlightBtn)
        firstToolbar.addSubview(exitBtn)
        
        cameraBtn.snp.makeConstraints{ make in
            make.width.height.equalTo(24)
            make.centerY.equalTo(firstToolbar)
//            make.top.equalTo(11)
            make.leading.equalTo(firstToolbar.snp.leading).offset(32)
        }
        
        textBtn.snp.makeConstraints{ make in
            make.width.height.equalTo(24)
            make.centerY.equalTo(firstToolbar)
//            make.top.equalTo(11)
            make.leading.equalTo(firstToolbar.snp.leading).offset(110)
        }
        
        stickerBtn.snp.makeConstraints{ make in
            make.width.height.equalTo(24)
            make.centerY.equalTo(firstToolbar)
//            make.top.equalTo(11)
            make.leading.equalTo(firstToolbar.snp.leading).offset(188)
        }
        
        highlightBtn.snp.makeConstraints{ make in
            make.width.height.equalTo(24)
            make.centerY.equalTo(firstToolbar)
//            make.top.equalTo(11)
            make.leading.equalTo(firstToolbar.snp.leading).offset(266)
        }
        
        exitBtn.snp.makeConstraints{ make in
            make.width.height.equalTo(24)
            make.centerY.equalTo(firstToolbar)
//            make.top.equalTo(11)
            make.leading.equalTo(firstToolbar.snp.leading).offset(344)
        }
        
        backToolbar.addSubview(colorToolbar)
        
        colorToolbar.snp.makeConstraints{ make in
            make.width.equalToSuperview()
            make.height.equalTo(46)
            make.top.equalToSuperview()
        }
        
        colorToolbar.addSubview(yellowBtn)
        colorToolbar.addSubview(orangeBtn)
        colorToolbar.addSubview(redBtn)
        colorToolbar.addSubview(greenBtn)
        colorToolbar.addSubview(blueBtn)
        colorToolbar.addSubview(grayBtn)
        
        yellowBtn.snp.makeConstraints{ make in
            make.width.height.equalTo(28)
            make.centerY.equalTo(colorToolbar)
            make.leading.equalTo(colorToolbar.snp.leading).offset(36)
        }
        
        orangeBtn.snp.makeConstraints{ make in
            make.width.height.equalTo(28)
            make.centerY.equalTo(colorToolbar)
            make.leading.equalTo(yellowBtn.snp.trailing).offset(30)
        }
        
        redBtn.snp.makeConstraints{ make in
            make.width.height.equalTo(28)
            make.centerY.equalTo(colorToolbar)
            make.leading.equalTo(orangeBtn.snp.trailing).offset(30)
        }
        
        greenBtn.snp.makeConstraints{ make in
            make.width.height.equalTo(28)
            make.centerY.equalTo(colorToolbar)
            make.leading.equalTo(redBtn.snp.trailing).offset(30)
        }
        
        blueBtn.snp.makeConstraints{ make in
            make.width.height.equalTo(28)
            make.centerY.equalTo(colorToolbar)
            make.leading.equalTo(greenBtn.snp.trailing).offset(30)
        }
        
        grayBtn.snp.makeConstraints{ make in
            make.width.height.equalTo(28)
            make.centerY.equalTo(colorToolbar)
            make.leading.equalTo(blueBtn.snp.trailing).offset(30)
        }
    }
}
