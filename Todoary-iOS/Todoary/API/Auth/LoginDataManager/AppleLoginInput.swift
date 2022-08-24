//
//  AppleLoginInput.swift
//  Todoary
//
//  Created by 박지윤 on 2022/08/22.
//

import Foundation
    
struct AppleLoginInput: Encodable{
    var appleUserInfo: AppleUserInfo
    var code: String //authorizationCode
    var idToken: String
}

struct AppleUserInfo: Encodable{
    var name: String
    var email: String
//    var userIdentifier: String
}
