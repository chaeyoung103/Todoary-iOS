//
//  SignUpInput.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/22.
//

import Foundation

struct SingUpInput: Encodable{
    
    var username: String?
    var nickname: String?
    var email: String?
    var password: String?
}
