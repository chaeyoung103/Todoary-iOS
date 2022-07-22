//
//  AutoLoginModel.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/22.
//

import Foundation

struct AutoLoginModel : Decodable {
    var isSuccess : Bool?
    var code : Int?
    var message : String?
    var result : AutoLoginModelReult?
    
}

struct AutoLoginModelReult : Decodable {
    var token : Token?
}

struct Token : Decodable {
    var accessToken : String?
    var refreshToken : String?
}
