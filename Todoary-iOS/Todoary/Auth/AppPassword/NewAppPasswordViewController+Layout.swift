//
//  NewAppPasswordViewController+Layout.swift
//  Todoary
//
//  Created by 예리 on 2022/08/12.
//

import Foundation
import UIKit
import SnapKit

extension NewAppPasswordViewController {
    
    func setUpView(){
        
        self.view.addSubview(appPwTitle)
        self.view.addSubview(newAppPwtext)
        self.view.addSubview(newAppPwtext2)
        
        self.view.addSubview(inputNotPw)
        self.view.addSubview(inputNotPw1)
        self.view.addSubview(inputNotPw2)
        self.view.addSubview(inputNotPw3)
        self.view.addSubview(inputNotPw4)
        
        self.view.addSubview(inputPw1)
        self.view.addSubview(inputPw2)
        self.view.addSubview(inputPw3)
        self.view.addSubview(inputPw4)
        
        self.view.addSubview(numBtn1)
        self.view.addSubview(numBtn2)
        self.view.addSubview(numBtn3)
        self.view.addSubview(numBtn4)
        self.view.addSubview(numBtn5)
        self.view.addSubview(numBtn6)
        self.view.addSubview(numBtn7)
        self.view.addSubview(numBtn8)
        self.view.addSubview(numBtn9)
        self.view.addSubview(numBtn0)
        self.view.addSubview(blueCharacter)
        self.view.addSubview(deletBtn)
        
    }

    func setUpConstraint(){
        
        //text
        appPwTitle.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(140)
            make.centerX.equalToSuperview()
        }
        
        newAppPwtext.snp.makeConstraints{ make in
            make.top.equalTo(appPwTitle.snp.bottom).offset(16)
            make.width.equalTo(161)
            make.height.equalTo(17)
            make.centerX.equalTo(appPwTitle)
        }
        
        newAppPwtext2.snp.makeConstraints{ make in
            make.top.equalTo(appPwTitle.snp.bottom).offset(16)
            make.width.equalTo(128)
            make.height.equalTo(17)
            make.centerX.equalTo(appPwTitle)
        }
        
        //inputNotPassword img
        
        inputNotPw.snp.makeConstraints{ make in
            make.width.equalTo(208)
            make.height.equalTo(40)
            make.top.equalTo(newAppPwtext.snp.bottom).offset(92)
            make.centerX.equalToSuperview()
        }
        
        inputNotPw.addSubview(inputNotPw1)
        inputNotPw.addSubview(inputNotPw2)
        inputNotPw.addSubview(inputNotPw3)
        inputNotPw.addSubview(inputNotPw4)
        
        inputNotPw1.snp.makeConstraints{ make in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.leading.equalToSuperview()
            make.centerY.equalTo(inputNotPw)

        }
        
        inputNotPw2.snp.makeConstraints{ make in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.leading.equalTo(inputNotPw1.snp.trailing).offset(16)
            make.centerY.equalTo(inputNotPw)

        }
        
        inputNotPw3.snp.makeConstraints{ make in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.leading.equalTo(inputNotPw2.snp.trailing).offset(16)
            make.centerY.equalTo(inputNotPw)
        }
        
        inputNotPw4.snp.makeConstraints{ make in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.leading.equalTo(inputNotPw3.snp.trailing).offset(16)
            make.centerY.equalTo(inputNotPw)
        }
        
        //inputPassword img
        
        inputPw1.snp.makeConstraints{ make in
            make.top.equalTo(newAppPwtext.snp.bottom).offset(92)
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.left.equalToSuperview().offset(91)
        }
        
        inputPw2.snp.makeConstraints{ make in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.leading.equalTo(inputPw1.snp.trailing).offset(16)
            make .centerY.equalTo(inputPw1)

        }
        
        inputPw3.snp.makeConstraints{ make in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.leading.equalTo(inputPw2.snp.trailing).offset(16)
            make .centerY.equalTo(inputPw2)
        }
        
        inputPw4.snp.makeConstraints{ make in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.leading.equalTo(inputPw3.snp.trailing).offset(16)
            make .centerY.equalTo(inputPw3)
        
        
    
            //button
            numBtn1.snp.makeConstraints{ make in
                make.top.equalToSuperview().offset(465)
                make.width.height.equalTo(43)
                make.leading.equalToSuperview().offset(71)
            }
            
            numBtn2.snp.makeConstraints{ make in
                make.leading.equalTo(numBtn1.snp.trailing).offset(60)
                make.width.height.equalTo(43)
                make.centerY.equalTo(numBtn1)
            }
            
            numBtn3.snp.makeConstraints{ make in
                make.leading.equalTo(numBtn2.snp.trailing).offset(60)
                make.width.height.equalTo(43)
                make.centerY.equalTo(numBtn2)
            }
            
            numBtn4.snp.makeConstraints{ make in
                make.top.equalTo(numBtn1.snp.bottom).offset(40)
                make.width.height.equalTo(43)
                make.centerX.equalTo(numBtn1)
            }
            
            numBtn5.snp.makeConstraints{ make in
                make.leading.equalTo(numBtn4.snp.trailing).offset(60)
                make.width.height.equalTo(43)
                make.centerY.equalTo(numBtn4)
            }
            
            numBtn6.snp.makeConstraints{ make in
                make.leading.equalTo(numBtn5.snp.trailing).offset(60)
                make.width.height.equalTo(43)
                make.centerY.equalTo(numBtn5)
            }
            
            numBtn7.snp.makeConstraints{ make in
                make.top.equalTo(numBtn4.snp.bottom).offset(40)
                make.width.height.equalTo(43)
                make.centerX.equalTo(numBtn4)
            }
            
            numBtn8.snp.makeConstraints{ make in
                make.leading.equalTo(numBtn7.snp.trailing).offset(60)
                make.width.height.equalTo(43)
                make.centerY.equalTo(numBtn7)
            }
            
            numBtn9.snp.makeConstraints{ make in
                make.leading.equalTo(numBtn8.snp.trailing).offset(60)
                make.width.height.equalTo(43)
                make.centerY.equalTo(numBtn8)
            }
            
            numBtn0.snp.makeConstraints{ make in
                make.top.equalTo(numBtn8.snp.bottom).offset(40)
                make.width.height.equalTo(43)
                make.centerX.equalTo(numBtn8)
            }
            
            blueCharacter.snp.makeConstraints{ make in
                make.width.height.equalTo(40)
                make.top.equalTo(numBtn7.snp.bottom).offset(42)
                make.centerX.equalTo(numBtn7)
            }
        
        deletBtn.snp.makeConstraints{ make in
            make.leading.equalTo(numBtn0.snp.trailing).offset(81)
            make.width.equalTo(28)
            make.height.equalTo(26.13)
            make.centerY.equalTo(numBtn0)
            }
        }
    }
}
