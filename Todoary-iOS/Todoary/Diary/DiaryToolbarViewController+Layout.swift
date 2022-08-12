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
            make.leading.equalTo(firstToolbar.snp.leading).offset(32)
        }
        
        textBtn.snp.makeConstraints{ make in
            make.width.height.equalTo(24)
            make.centerY.equalTo(firstToolbar)
            make.leading.equalTo(firstToolbar.snp.leading).offset(110)
        }
        
        stickerBtn.snp.makeConstraints{ make in
            make.width.height.equalTo(24)
            make.centerY.equalTo(firstToolbar)
            make.leading.equalTo(firstToolbar.snp.leading).offset(188)
        }
        
        highlightBtn.snp.makeConstraints{ make in
            make.width.height.equalTo(24)
            make.centerY.equalTo(firstToolbar)
            make.leading.equalTo(firstToolbar.snp.leading).offset(266)
        }
        
        exitBtn.snp.makeConstraints{ make in
            make.width.height.equalTo(24)
            make.centerY.equalTo(firstToolbar)
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
        
        backToolbar.addSubview(textToolbar)
        
        textToolbar.snp.makeConstraints{ make in
            make.width.equalToSuperview()
            make.height.equalTo(46)
            make.top.equalToSuperview()
        }

        textToolbar.addSubview(alignLeftBtn)
        textToolbar.addSubview(ailgnCenterBtn)
        textToolbar.addSubview(alignRightBtn)
        textToolbar.addSubview(fontBtn)
        textToolbar.addSubview(strikeLineBtn)
        textToolbar.addSubview(underLineBtn)
        textToolbar.addSubview(boldBtn)

        alignLeftBtn.snp.makeConstraints{make in
            make.width.height.equalTo(24)
            make.centerY.equalTo(textToolbar)
            make.leading.equalTo(textToolbar.snp.leading).offset(33)
        }

        ailgnCenterBtn.snp.makeConstraints{ make in
            make.width.height.equalTo(24)
            make.centerY.equalTo(textToolbar)
            make.leading.equalTo(alignLeftBtn.snp.trailing).offset(32)
        }

        alignRightBtn.snp.makeConstraints{make in
            make.width.height.equalTo(24)
            make.centerY.equalTo(textToolbar)
            make.leading.equalTo(ailgnCenterBtn.snp.trailing).offset(32)
        }
        
        fontBtn.snp.makeConstraints{make in
            make.width.equalTo(19)
            make.height.equalTo(22)
            make.centerY.equalToSuperview()
            make.leading.equalTo(alignRightBtn.snp.trailing).offset(32)
            
        }

        strikeLineBtn.snp.makeConstraints{make in
            make.width.equalTo(14)
            make.height.equalTo(22)
            make.centerY.equalToSuperview()
            make.leading.equalTo(fontBtn.snp.trailing).offset(32)
        }

        underLineBtn.snp.makeConstraints{make in
            make.width.equalTo(13)
            make.height.equalTo(22)
            make.centerY.equalTo(textToolbar)
            make.leading.equalTo(strikeLineBtn.snp.trailing).offset(32)
        }

        boldBtn.snp.makeConstraints{make in
            make.width.equalTo(14)
            make.height.equalTo(22)
            make.centerY.equalTo(textToolbar)
            make.leading.equalTo(underLineBtn.snp.trailing).offset(32)
        }
        
        backToolbar.addSubview(fontToolbar)
        
        fontToolbar.snp.makeConstraints{make in
            make.width.equalToSuperview()
            make.height.equalTo(46)
            make.top.equalToSuperview()
        }
        
        fontToolbar.addSubview(fontBtn1)
        fontToolbar.addSubview(fontBtn2)
        fontToolbar.addSubview(fontBtn3)
        fontToolbar.addSubview(fontBtn4)
        fontToolbar.addSubview(fontBtn5)
        
        fontBtn1.snp.makeConstraints{make in
            make.width.equalTo(58)
            make.height.equalTo(22)
            make.centerY.equalTo(fontToolbar)
            make.leading.equalTo(fontToolbar.snp.leading).offset(23)
        }
        
        fontBtn2.snp.makeConstraints{make in
            make.width.equalTo(63)
            make.height.equalTo(22)
            make.centerY.equalTo(fontToolbar)
            make.leading.equalTo(fontBtn1.snp.trailing).offset(13)
        }
        
        fontBtn3.snp.makeConstraints{make in
            make.width.equalTo(63)
            make.height.equalTo(22)
            make.centerY.equalTo(fontToolbar)
            make.leading.equalTo(fontBtn2.snp.trailing).offset(11)
        }
        
        fontBtn4.snp.makeConstraints{make in
            make.width.equalTo(57)
            make.height.equalTo(22)
            make.centerY.equalTo(fontToolbar)
            make.leading.equalTo(fontBtn3.snp.trailing).offset(14)
        }
        
        fontBtn5.snp.makeConstraints{make in
            make.width.equalTo(55)
            make.height.equalTo(22)
            make.centerY.equalTo(fontToolbar)
            make.leading.equalTo(fontBtn4.snp.trailing).offset(13)
        }
    }
}

