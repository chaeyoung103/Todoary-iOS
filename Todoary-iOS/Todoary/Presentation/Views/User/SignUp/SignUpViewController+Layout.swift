//
//  SignUpViewController+Layout.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/01.
//

import UIKit

extension SignUpViewController {
    
    func setUpView(){

        self.view.addSubview(idTitle)
        self.view.addSubview(idTextField)
        self.view.addSubview(idBorderLine)
        self.view.addSubview(idCanUseLabel)

        self.view.addSubview(idCertificationButton)

        self.view.addSubview(certificationTitle)
        self.view.addSubview(certificationTextField)
        self.view.addSubview(certificationBorderLine)
        self.view.addSubview(certificationOkButton)
        
        self.view.addSubview(pwTitle)
        self.view.addSubview(pwTextField)
        self.view.addSubview(pwBorderLine)
        self.view.addSubview(pwCanUseLabel)
        
        self.view.addSubview(pwCertificationTextField)
        self.view.addSubview(pwCertificationBorderLine)
        self.view.addSubview(pwIncorrectLabel)
        
        self.view.addSubview(nameTitle)
        self.view.addSubview(nameTextField)
        self.view.addSubview(nameBorderLine)
        self.view.addSubview(nameCanUseLabel)
        
        self.view.addSubview(nicknameTitle)
        self.view.addSubview(nicknameTextField)
        self.view.addSubview(nicknameBorderLine)
        self.view.addSubview(nicknameCanUseLabel)
        
        self.view.addSubview(nextButton)
    
    }
    
    func setUpConstraint(){

        //id
        idTitle.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(154)
            make.leading.equalToSuperview().offset(38)
            make.height.equalTo(20)
        }

        idTextField.snp.makeConstraints{ make in
            make.top.equalTo(idTitle.snp.bottom).offset(16)
            make.width.equalTo(261)
            make.height.equalTo(20)
            make.leading.equalTo(idTitle)
        }
        
        idBorderLine.snp.makeConstraints{ make in
            make.height.equalTo(1)
            make.leading.equalTo(idTextField)
            make.trailing.equalToSuperview().offset(-38)
            make.bottom.equalTo(idTextField).offset(2)
        }
        
        idCanUseLabel.snp.makeConstraints{ make in
            make.height.equalTo(20)
            make.top.equalTo(idBorderLine.snp.bottom).offset(6)
            make.leading.equalTo(idTitle)
        }
        
        idCertificationButton.snp.makeConstraints{ make in
            make.width.equalTo(65)
            make.height.equalTo(22)
            make.trailing.equalToSuperview().offset(-40)
            make.top.equalToSuperview().offset(150)
//            make.top.equalTo(navigationView.snp.bottom).offset(66)
        }
        
        //certification
        certificationTitle.snp.makeConstraints{ make in
            make.top.equalTo(idCanUseLabel.snp.bottom).offset(8)
            make.leading.equalTo(idTitle)
            make.height.equalTo(20)
        }

        certificationTextField.snp.makeConstraints{ make in
            make.top.equalTo(certificationTitle.snp.bottom).offset(16)
            make.height.equalTo(20)
            make.leading.equalTo(idTitle)
            make.leading.trailing.equalTo(idBorderLine)
        }
        
        certificationBorderLine.snp.makeConstraints{ make in
            make.height.equalTo(1)
            make.leading.trailing.equalTo(idBorderLine)
            make.bottom.equalTo(certificationTextField.snp.bottom).offset(2)
        }
        
        certificationOkButton.snp.makeConstraints{ make in
            make.width.equalTo(65)
            make.height.equalTo(22)
            make.trailing.equalToSuperview().offset(-40)
            make.top.equalTo(idCanUseLabel.snp.bottom).offset(7)
        }
        
        //password
        pwTitle.snp.makeConstraints{ make in
            make.top.equalTo(certificationBorderLine).offset(48)
            make.leading.equalTo(idTitle)
            make.height.equalTo(20)
        }
        
        pwTextField.snp.makeConstraints{ make in
            make.top.equalTo(pwTitle.snp.bottom).offset(17)
            make.leading.equalTo(idTitle)
            make.height.equalTo(20)
            make.leading.trailing.equalTo(idBorderLine)
        }
        
        pwBorderLine.snp.makeConstraints{ make in
            make.height.equalTo(1)
            make.leading.trailing.equalTo(idBorderLine)
            make.bottom.equalTo(pwTextField.snp.bottom).offset(2)
        }
        
        pwCanUseLabel.snp.makeConstraints{ make in
            make.top.equalTo(pwBorderLine.snp.bottom).offset(7)
            make.leading.trailing.equalTo(idTextField)
            make.height.equalTo(20)
        }
        
        pwCertificationTextField.snp.makeConstraints{ make in
            make.top.equalTo(pwCanUseLabel.snp.bottom).offset(13)
            make.leading.equalTo(idTitle)
            make.height.equalTo(20)
            make.leading.trailing.equalTo(idBorderLine)
        }
        
        pwCertificationBorderLine.snp.makeConstraints{ make in
            make.height.equalTo(1)
            make.leading.trailing.equalTo(idBorderLine)
            make.bottom.equalTo(pwCertificationTextField.snp.bottom).offset(3)
        }
        
        pwIncorrectLabel.snp.makeConstraints{ make in
            make.top.equalTo(pwCertificationBorderLine.snp.bottom).offset(7)
            make.leading.equalTo(idTextField.snp.leading)
            make.height.equalTo(20)
        }
        
        //name
        nameTitle.snp.makeConstraints{ make in
            make.top.equalTo(pwIncorrectLabel).offset(33)
            make.leading.equalTo(idTitle)
            make.height.equalTo(20)
        }
        
        nameTextField.snp.makeConstraints{ make in
            make.top.equalTo(nameTitle.snp.bottom).offset(16)
            make.height.equalTo(20)
            make.leading.trailing.equalTo(idBorderLine)
        }
        
        nameBorderLine.snp.makeConstraints{ make in
            make.width.equalTo(certificationBorderLine)
            make.height.equalTo(1)
            make.leading.equalTo(idTextField.snp.leading)
            make.bottom.equalTo(nameTextField.snp.bottom).offset(4)
        }
        
        nameCanUseLabel.snp.makeConstraints{ make in
            make.top.equalTo(nameBorderLine.snp.bottom).offset(7)
            make.leading.equalTo(idTextField.snp.leading)
            make.height.equalTo(20)
        }
        
        //nickname
        nicknameTitle.snp.makeConstraints{ make in
            make.top.equalTo(nameCanUseLabel.snp.bottom).offset(19)
            make.leading.equalTo(idTitle)
            make.height.equalTo(20)
        }
        
        nicknameTextField.snp.makeConstraints{ make in
            make.top.equalTo(nicknameTitle.snp.bottom).offset(16)
            make.leading.equalTo(idTitle)
            make.height.equalTo(20)
            make.leading.trailing.equalTo(idBorderLine)
        }
        
        nicknameBorderLine.snp.makeConstraints{ make in
            make.leading.trailing.equalTo(idBorderLine)
            make.height.equalTo(1)
            make.bottom.equalTo(nicknameTextField.snp.bottom).offset(4)
        }
        
        nicknameCanUseLabel.snp.makeConstraints{ make in
            make.top.equalTo(nicknameBorderLine.snp.bottom).offset(7)
            make.leading.equalTo(idTextField.snp.leading)
            make.height.equalTo(20)
        }
        
        //button
        nextButton.snp.makeConstraints{ make in
            make.bottom.equalToSuperview().offset(-47)
            make.leading.equalToSuperview().offset(26)
            make.trailing.equalToSuperview().offset(-26)
            make.height.equalTo(52)
        }
    }
}
