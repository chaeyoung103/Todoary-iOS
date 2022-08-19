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
        
        firstToolbar.addSubview(firstStackView)
        
        firstToolbar.snp.makeConstraints{ make in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            
        }
        
        firstStackView.addArrangedSubview(cameraBtn)
        firstStackView.addArrangedSubview(textBtn)
        firstStackView.addArrangedSubview(stickerBtn)
        firstStackView.addArrangedSubview(highlightBtn)
        firstStackView.addArrangedSubview(exitBtn)
        
        cameraBtn.snp.makeConstraints{ make in
            make.width.height.equalTo(24)
//            make.centerY.equalToSuperview()
//            make.leading.equalTo(firstToolbar.snp.leading).offset(27)
//            make.trailing.equalTo(firstToolbar.snp.trailing).offset(-339)
        }
        
        textBtn.snp.makeConstraints{ make in
            make.width.height.equalTo(24)
//            make.centerY.equalToSuperview()
//            make.leading.equalTo(firstToolbar.snp.leading).offset(105)
//            make.trailing.equalTo(firstToolbar.snp.trailing).offset(-261)

        }
        
        stickerBtn.snp.makeConstraints{ make in
            make.width.height.equalTo(24)
//            make.centerY.equalToSuperview()
//            make.leading.equalTo(firstToolbar.snp.leading).offset(183)
//            make.trailing.equalTo(firstToolbar.snp.trailing).offset(-183)
        }
        
        highlightBtn.snp.makeConstraints{ make in
            make.width.height.equalTo(24)
//            make.centerY.equalToSuperview()
//            make.leading.equalTo(firstToolbar.snp.leading).offset(261)
//            make.trailing.equalTo(firstToolbar.snp.trailing).offset(-105)
        }
        
        exitBtn.snp.makeConstraints{ make in
            make.width.height.equalTo(24)
//            make.centerY.equalToSuperview()
//            make.leading.equalTo(firstToolbar.snp.leading).offset(339)
//            make.trailing.equalTo(firstToolbar.snp.trailing).offset(-27)
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
            make.trailing.equalTo(orangeBtn.snp.leading).offset(-30)
        }
        
        orangeBtn.snp.makeConstraints{ make in
            make.width.height.equalTo(28)
            make.centerY.equalTo(colorToolbar)
            make.trailing.equalTo(redBtn.snp.leading).offset(-30)
        }
        
        redBtn.snp.makeConstraints{ make in
            make.width.height.equalTo(28)
            make.centerY.equalTo(colorToolbar)
            make.centerX.equalToSuperview().offset(-29)
        }
        
        greenBtn.snp.makeConstraints{ make in
            make.width.height.equalTo(28)
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview().offset(29)
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
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-334)
        }

        ailgnCenterBtn.snp.makeConstraints{ make in
            make.width.height.equalTo(24)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(89)
            make.trailing.equalToSuperview().offset(-277)
        }

        alignRightBtn.snp.makeConstraints{make in
            make.width.height.equalTo(24)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(145)
            make.trailing.equalToSuperview().offset(-221)
        }
        
        fontBtn.snp.makeConstraints{make in
            make.width.equalTo(19)
            make.height.equalTo(22)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(201)
            make.trailing.equalToSuperview().offset(-170)
        }

        strikeLineBtn.snp.makeConstraints{make in
            make.width.equalTo(14)
            make.height.equalTo(22)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(252)
            make.trailing.equalToSuperview().offset(-124)
        }

        underLineBtn.snp.makeConstraints{make in
            make.width.equalTo(13)
            make.height.equalTo(22)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(298)
            make.trailing.equalToSuperview().offset(-79)
        }

        boldBtn.snp.makeConstraints{make in
            make.width.equalTo(14)
            make.height.equalTo(22)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(342)
            make.trailing.equalToSuperview().offset(-34)
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
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(22)
            make.trailing.equalToSuperview().offset(-310)
        }
        
        fontBtn2.snp.makeConstraints{make in
            make.width.equalTo(63)
            make.height.equalTo(22)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(94)
            make.trailing.equalToSuperview().offset(-233)
        }
        
        fontBtn3.snp.makeConstraints{make in
            make.width.equalTo(63)
            make.height.equalTo(22)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(168)
            make.trailing.equalToSuperview().offset(-159)
        }
        
        fontBtn4.snp.makeConstraints{make in
            make.width.equalTo(57)
            make.height.equalTo(22)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(245)
            make.trailing.equalToSuperview().offset(-88)
        }
        
        fontBtn5.snp.makeConstraints{make in
            make.width.equalTo(55)
            make.height.equalTo(22)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(314)
            make.trailing.equalToSuperview().offset(-21)
        }
    }
}

