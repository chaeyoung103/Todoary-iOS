//
//  AppleLoginInput.swift
//  Todoary
//
//  Created by 박지윤 on 2022/08/22.
//

import Foundation
    
struct AppleLoginInput: Encodable{
    var name: String
    var email: String
    var provider: String
    var providerId: String
    var isTermsEnable: Bool
    var fcm_token: String
}
