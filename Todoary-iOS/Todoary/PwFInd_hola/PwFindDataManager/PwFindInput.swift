//
//  SignUpInput.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/22.
//

import Foundation

struct PwFindInput: Encodable{
    
//    var exPassword: String?
    var newPassword: String?
    
    //회원가입용 생성자
    init(newPassword: String) {
        self.newPassword = newPassword
    }
    
}
