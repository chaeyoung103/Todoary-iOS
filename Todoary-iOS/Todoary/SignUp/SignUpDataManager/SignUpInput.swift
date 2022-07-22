//
//  SignUpInput.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/22.
//

import Foundation

struct SignUpInput: Encodable{
    
    var username: String?
    var nickname: String?
    var email: String?
    var password: String?
    
    //email 유효성 검사용 생성자
    init(email: String) {
        self.email = email
    }
    
    //회원가입용 생성자
    init(email: String, password: String, username: String, nickname: String) {
        self.email = email
        self.password = password
        self.username = username
        self.nickname = nickname
    }
    
}
